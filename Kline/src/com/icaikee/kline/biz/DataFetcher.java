package com.icaikee.kline.biz;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.icaikee.kline.biz.common.model.Candlesticks;
import com.icaikee.kline.biz.common.model.Product;
import com.icaikee.kline.biz.common.model.RealtimeQuote;
import com.icaikee.kline.http.HttpHandler;
import com.icaikee.kline.util.TimeUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class DataFetcher {

	public static final String URL_KLINE = "http://120.76.218.30:9090/quote/kline";

	public static final String URL_FUZZY_QUERY = "http://120.76.218.30:9090/quote/fuzzyquery";

	public static List<Product> getStocks(String q) {
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("query_str", q);
		JSONObject httpResult = HttpHandler.httpGet(URL_FUZZY_QUERY, jsonParam);
		JSONArray stocks = httpResult.getJSONArray("stocks");

		List<Product> result = new ArrayList<Product>();
		for (int i = 0; i < stocks.size(); i++) {
			JSONObject x = (JSONObject) stocks.get(i);
			Product data = new Product();
			data.setName(x.getString("stock_abbr_name"));
			data.setCode(x.getString("prod_code"));
			result.add(data);
		}
		return result;
	}

	public static List<RealtimeQuote> getRealQuote(String stockCode) {
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("prod_code", stockCode);
		jsonParam.put("candle_period", "1");
		jsonParam.put("candle_mode", "0");
		// jsonParam.put("start_date", TimeUtil.getStartMorning());
		jsonParam.put("start_date", "201501050101");
		if (TimeUtil.isTradeTime(new Date()))
			jsonParam.put("end_date", TimeUtil.getNowMinite());
		else
			// jsonParam.put("end_date", TimeUtil.getEndAfternoon());
			jsonParam.put("end_date", "201501060101");
		JSONObject httpResult = HttpHandler.httpGet(URL_KLINE, jsonParam);

		JSONObject candle = httpResult.getJSONObject("candle");
		JSONArray array = candle.getJSONArray("candle_detail_data");

		List<RealtimeQuote> result = new ArrayList<RealtimeQuote>();

		for (int i = 0; i < array.size(); i++) {
			JSONObject x = (JSONObject) array.get(i);
			RealtimeQuote data = new RealtimeQuote();
			data.setTimeStamp(x.getString("min_time"));
			data.setLastPrice(Double.parseDouble(x.getString("close_px")));
			// data.setBusinessAmount(Double.parseDouble(x.getString("business_amount")));
			result.add(data);
		}

		return result;
	}

	public static List<Candlesticks> getK(String stockCode, String candlePeriod, String candleMode, Date startDate,
			Date endDate) {
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("prod_code", stockCode);
		jsonParam.put("candle_period", candlePeriod);
		jsonParam.put("candle_mode", candleMode == null ? "0" : candleMode);
		// jsonParam.put("start_date", TimeUtil.getStartMorning());
		jsonParam.put("start_date", "201501050101");
		if (TimeUtil.isTradeTime(new Date()))
			jsonParam.put("end_date", TimeUtil.getNowMinite());
		else
			// jsonParam.put("end_date", TimeUtil.getEndAfternoon());
			jsonParam.put("end_date", "201501060101");
		JSONObject httpResult = HttpHandler.httpGet(URL_KLINE, jsonParam);

		JSONObject candle = httpResult.getJSONObject("candle");
		JSONArray array = candle.getJSONArray("candle_detail_data");

		List<Candlesticks> result = new ArrayList<Candlesticks>();

		for (int i = 0; i < array.size(); i++) {
			JSONObject x = (JSONObject) array.get(i);
			Candlesticks data = new Candlesticks();
			data.setTimeStamp(x.getString("min_time"));
			data.setHighPrice(Double.parseDouble(x.getString("high_px")));
			data.setLowPrice(Double.parseDouble(x.getString("low_px")));
			data.setOpenPrice(Double.parseDouble(x.getString("open_px")));
			data.setClosePrice(Double.parseDouble(x.getString("close_px")));
			// data.setBusinessAmount(Double.parseDouble(x.getString("business_amount")));
			result.add(data);
		}

		return result;
	}

	private String timePattern(String candleMode) {
		Integer i = Integer.parseInt(candleMode);
		if (i < 6) {
			return TimeUtil.TIME_PATTERN;
		} else {
			return TimeUtil.DATE_PATTERN;
		}
	}

}
