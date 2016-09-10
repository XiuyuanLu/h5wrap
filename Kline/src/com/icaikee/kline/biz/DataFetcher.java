package com.icaikee.kline.biz;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.icaikee.kline.biz.common.model.Candlesticks;
import com.icaikee.kline.biz.common.model.Product;
import com.icaikee.kline.biz.common.model.RealtimeQuote;
import com.icaikee.kline.biz.common.model.WrapCenter;
import com.icaikee.kline.biz.common.model.WrapPen;
import com.icaikee.kline.biz.common.model.WrapSegment;
import com.icaikee.kline.biz.common.model.WrapStructures;
import com.icaikee.kline.http.HttpHandler;
import com.icaikee.kline.util.TimeUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class DataFetcher {

	public static final String URL_KLINE = "http://114.55.175.118:9090/quote/kline";

	public static final String URL_FUZZY_QUERY = "http://114.55.175.118:9090/quote/fuzzyquery";

	public static final String URL_SNAPSHOT = "http://114.55.175.118:9090/quote/snapshot";

	public static final String URL_WRAP = "http://114.55.175.118:9090/quote/cldata";

	public static final String URL_SALE_POINT = "http://114.55.175.118:9090/quote/bspoint";

	public List<Product> getStocks(String q) {
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

	public RealtimeQuote getStockSnapshot(String stockCode) {
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("prod_code", stockCode);
		jsonParam.put("fields",
				"open_px,high_px,last_px,low_px,turnover_ratio,vol_ratio,business_balance,px_change,px_change_rate,bid_grp,offer_grp");
		JSONObject httpResult = HttpHandler.httpGet(URL_SNAPSHOT, jsonParam);

		JSONObject snapshot = httpResult.getJSONObject("snapshot");
		JSONObject detail = snapshot.getJSONObject("snapshot_detail_data");

		RealtimeQuote result = new RealtimeQuote();

		double openPrice = detail.getDouble("open_px");
		double highPrice = detail.getDouble("open_px");
		double lowPrice = detail.getDouble("open_px");
		double lastPrice = detail.getDouble("open_px");
		double turnoverRatio = detail.getDouble("turnover_ratio");
		double volRatio = detail.getDouble("vol_ratio");
		double businessBalance = detail.getDouble("business_balance");
		double chg = detail.getDouble("px_change");
		double pchg = detail.getDouble("px_change_rate");

		result.setOpenPrice(openPrice);
		result.setHighPrice(highPrice);
		result.setLowPrice(lowPrice);
		result.setLastPrice(lastPrice);
		result.setTurnoverRatio(turnoverRatio);
		result.setVolRatio(volRatio);
		result.setBusinessBalance(businessBalance);
		result.setChg(chg);
		result.setPchg(pchg);

		String bg = detail.getString("bid_grp");
		String[] bids = {};
		if (bg != null)
			bids = bg.split(",");
		StringBuilder sb = new StringBuilder();
		List<String> bidGrp = new ArrayList<String>();
		for (int i = 0; i < bids.length; i++) {
			if (i % 3 == 0) {
				sb = new StringBuilder();
				sb.append(bids[i]);
			}
			if (i % 3 == 2) {
				bidGrp.add(sb.toString());
			}
		}

		String og = detail.getString("offer_grp");
		String[] offers = {};
		if (og != null)
			offers = og.split(",");
		sb = new StringBuilder();
		List<String> offerGrp = new ArrayList<String>();
		for (int i = 0; i < offers.length; i++) {
			if (i % 3 == 0) {
				sb = new StringBuilder();
				sb.append(offers[i]);
			}
			if (i % 3 == 2) {
				offerGrp.add(sb.toString());
			}
		}

		result.setBidGroup(bidGrp);
		result.setOfferGroup(offerGrp);
		return result;
	}

	public List<RealtimeQuote> getStockPrice(String stockCode) {
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("prod_code", stockCode);
		jsonParam.put("candle_period", "1");
		jsonParam.put("candle_mode", "0");
		jsonParam.put("start_date", TimeUtil.getStartMorning());
		jsonParam.put("end_date", TimeUtil.getEndAfternoon());
		JSONObject httpResult = HttpHandler.httpGet(URL_KLINE, jsonParam);
		if (httpResult == null)
			return null;

		JSONObject candle = httpResult.getJSONObject("candle");
		if (candle == null || candle.isNullObject())
			return null;
		JSONArray array = candle.getJSONArray("candle_detail_data");

		if (array == null || array.isEmpty() || array.size() == 0)
			return null;

		List<RealtimeQuote> result = new ArrayList<RealtimeQuote>();

		for (int i = 0; i < array.size(); i++) {
			JSONObject x = (JSONObject) array.get(i);
			RealtimeQuote data = new RealtimeQuote();
			data.setTimeStamp(x.getString("min_time"));
			data.setLastPrice(Double.parseDouble(x.getString("close_px")));
			data.setBusinessAmount(Double.parseDouble(x.getString("business_amount")));
			result.add(data);
		}

		return result;
	}

	public List<Candlesticks> getK(String stockCode, String candlePeriod, String candleMode, String startDate,
			String endDate) {
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("prod_code", stockCode);
		jsonParam.put("candle_period", candlePeriod);
		jsonParam.put("candle_mode", candleMode == null ? "0" : candleMode);
		jsonParam.put("start_date", startDate);
		jsonParam.put("end_date", endDate);
		JSONObject httpResult = HttpHandler.httpGet(URL_KLINE, jsonParam);
		if (httpResult == null)
			return null;

		JSONObject candle = httpResult.getJSONObject("candle");
		if (candle == null || candle.isNullObject())
			return null;
		JSONArray array = candle.getJSONArray("candle_detail_data");

		if (array == null || array.isEmpty() || array.size() == 0)
			return null;

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

	public WrapStructures getWrapData(String stockCode, String candlePeriod, String candleMode, String startDate,
			String endDate) {

		JSONObject jsonParam = new JSONObject();
		jsonParam.put("prod_code", stockCode);
		jsonParam.put("candle_period", candlePeriod);
		jsonParam.put("candle_mode", candleMode == null ? "0" : candleMode);
		jsonParam.put("start_date", startDate);
		jsonParam.put("end_date", endDate);
		JSONObject httpResult = HttpHandler.httpGet(URL_WRAP, jsonParam);
		WrapStructures wrapStructures = new WrapStructures();
		List<WrapPen> wrapPen = new ArrayList<WrapPen>();
		List<WrapSegment> wrapSegment = new ArrayList<WrapSegment>();
		List<WrapCenter> wrapPenCenter = new ArrayList<WrapCenter>();
		List<WrapCenter> wrapSegmentCenter = new ArrayList<WrapCenter>();
		wrapStructures.setPen(wrapPen);
		wrapStructures.setPenCenter(wrapPenCenter);
		wrapStructures.setSegment(wrapSegment);
		wrapStructures.setSegmentCenter(wrapSegmentCenter);
		if (httpResult == null)
			return wrapStructures;

		JSONObject cstructure = httpResult.getJSONObject("cstructure");
		if (cstructure == null || cstructure.isNullObject())
			return wrapStructures;
		JSONArray pen = cstructure.getJSONArray("bi_data");
		// JSONArray penCenter = cstructure.getJSONArray("bi_zs_data");
		// JSONArray segment = cstructure.getJSONArray("duan_data");
		// JSONArray segmentCenter = cstructure.getJSONArray("duan_zs_data");

		if (!(pen == null || pen.isEmpty() || pen.size() == 0)) {
			for (int i = 0; i < pen.size(); i++) {
				JSONObject x = (JSONObject) pen.get(i);
				WrapPen data = new WrapPen();
				data.setTimeStamp(x.getString("start_time"));
				data.setValue(x.getDouble("value"));
				wrapPen.add(data);
			}
		}
		// if (!(penCenter == null || penCenter.isEmpty() || penCenter.size() ==
		// 0)) {
		// for (int i = 0; i < penCenter.size(); i++) {
		// JSONObject x = (JSONObject) penCenter.get(i);
		// WrapCenter data = new WrapCenter();
		// data.setStartTime(x.getString("start_time"));
		// data.setEndTime(x.getString("end_time"));
		// data.setHigh(x.getDouble("high_head"));
		// data.setLow(x.getDouble("low_tail"));
		// data.setMaxHigh(x.getDouble("max_high"));
		// data.setMaxLow(x.getDouble("min_low"));
		// wrapPenCenter.add(data);
		// }
		// }
		// if (!(segment == null || segment.isEmpty() || segment.size() == 0)) {
		// for (int i = 0; i < segment.size(); i++) {
		// JSONObject x = (JSONObject) segment.get(i);
		// WrapSegment data = new WrapSegment();
		// data.setTimeStamp(x.getString("start_time"));
		// data.setValue(x.getDouble("value"));
		// segment.add(data);
		// }
		// }
		// if (!(segmentCenter == null || segmentCenter.isEmpty() ||
		// segmentCenter.size() == 0)) {
		// for (int i = 0; i < segmentCenter.size(); i++) {
		// JSONObject x = (JSONObject) segmentCenter.get(i);
		// WrapCenter data = new WrapCenter();
		// data.setStartTime(x.getString("start_time"));
		// data.setEndTime(x.getString("end_time"));
		// data.setHigh(x.getDouble("high_head"));
		// data.setLow(x.getDouble("low_tail"));
		// data.setMaxHigh(x.getDouble("max_high"));
		// data.setMaxLow(x.getDouble("min_low"));
		// wrapSegmentCenter.add(data);
		// }
		// }

		return wrapStructures;
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
