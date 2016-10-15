package com.icaikee.kline.biz.pool;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.icaikee.kline.biz.UrlConstants;
import com.icaikee.kline.http.HttpHandler;
import com.icaikee.kline.util.StringUtils;
import com.icaikee.kline.util.TimeUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class PoolService {

	private static final String QUERY_URL = "api/chanlun/v1/quote/bspoints";

	public List<PoolDto> getPool(String uid, String tradeType, String candlePeriod, String candleMode) {
		List<PoolDto> pool = new ArrayList<PoolDto>();
		Date endDate = new Date();
		Date startDate;

		String start;
		String end;

		if ("4".equals(candlePeriod))
			startDate = TimeUtil.getTimeByOffset(TimeUtil.DAY, endDate, -90);
		else if ("6".equals(candlePeriod))
			startDate = TimeUtil.getTimeByOffset(TimeUtil.DAY, endDate, -7);
		else
			return pool;

		if ("4".equals(candlePeriod)) {
			start = TimeUtil.format(startDate, TimeUtil.DATE_TIME_PATTERN_NOBAR);
			end = TimeUtil.format(endDate, TimeUtil.DATE_TIME_PATTERN_NOBAR);
		} else {
			start = TimeUtil.format(startDate, TimeUtil.DATE_PATTERN_NOBAR);
			end = TimeUtil.format(endDate, TimeUtil.DATE_PATTERN_NOBAR);
		}

		JSONObject jsonParam = new JSONObject();
		jsonParam.put("appId", "icaikeeApp");
		jsonParam.put("candle_mode", candleMode);
		jsonParam.put("candle_period", candlePeriod);
		jsonParam.put("end_date", end);
		jsonParam.put("start_date", start);
		jsonParam.put("trade_type", tradeType);
		jsonParam.put("token", getQueryToken(candleMode, candlePeriod, end, start, tradeType));
		JSONObject result = HttpHandler.httpGet(UrlConstants.PREFIX + QUERY_URL, jsonParam);
		if (result == null)
			return pool;
		String status = result.getString("status");
		if ("200".equals(status)) {
			JSONArray data = result.getJSONArray("data");
			if (data != null && data.size() > 0) {
				for (int i = 0; i < data.size(); i++) {
					JSONObject x = (JSONObject) data.get(i);
					PoolDto item = new PoolDto();
					item.setCode(x.getString("code"));
					item.setName(x.getString("stock_name"));
					item.setEntryDate(x.getString("start_date"));
					item.setAccReturn(x.getString("gains "));
					item.setEntryPrice(x.getString("now_value"));
					pool.add(item);
				}
			}
		}
		return pool;
	}

	public static String getQueryToken(String candleMode, String candlePeriod, String endDate, String startDate,
			String tradeType) {
		return StringUtils
				.MD5(UrlConstants.TOKEN_PREFIX + "candle_mode=" + candleMode + "&candle_period=" + candlePeriod
						+ "&end_date=" + endDate + "&start_date=" + startDate + "&trade_type=" + tradeType)
				.toLowerCase();
	}

}
