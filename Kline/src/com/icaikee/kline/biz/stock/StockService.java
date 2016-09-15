package com.icaikee.kline.biz.stock;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icaikee.kline.biz.DataFetcher;
import com.icaikee.kline.biz.common.CommonService;
import com.icaikee.kline.biz.common.model.Candlesticks;
import com.icaikee.kline.biz.common.model.Macd;
import com.icaikee.kline.biz.common.model.Product;
import com.icaikee.kline.biz.common.model.RealtimeQuote;
import com.icaikee.kline.util.TimeUtil;

@Service
public class StockService {

	@Autowired
	private CommonService commonService;

	@Autowired
	private DataFetcher dataFetcher;

	public List<Product> fuzzyQuery(String q) {
		return dataFetcher.getStocks(q);
	}

	public List<RealtimeQuote> getStock(String code) throws ParseException {
		List<RealtimeQuote> result = dataFetcher.getStockPrice(code);
		if (result == null)
			result = new ArrayList<RealtimeQuote>();
		if (result.size() < 241) {
			List<String> timeList = commonService.getTradeTime();
			for (int i = 0; i < 240; i++) {
				if (i >= result.size()) {
					RealtimeQuote rq = new RealtimeQuote();
					rq.setTimeStamp(timeList.get(i));
					result.add(rq);
				}
			}
		}
		return result;
	}

	public RealtimeQuote getSnapshot(String code) {
		return dataFetcher.getStockSnapshot(code);
	}

	public List<Candlesticks> getCandlesticks(String code, String candlePeriod, String candleMode)
			throws ParseException {
		Date endDate = new Date();
		Date startDate;

		String start;
		String end;

		if ("1".equals(candlePeriod))
			startDate = TimeUtil.getTimeByOffset(TimeUtil.DAY, endDate, -7);
		else if ("2".equals(candlePeriod))
			startDate = TimeUtil.getTimeByOffset(TimeUtil.DAY, endDate, -35);
		else if ("3".equals(candlePeriod))
			startDate = TimeUtil.getTimeByOffset(TimeUtil.DAY, endDate, -105);
		else if ("4".equals(candlePeriod))
			startDate = TimeUtil.getTimeByOffset(TimeUtil.DAY, endDate, -210);
		else if ("5".equals(candlePeriod))
			startDate = TimeUtil.getTimeByOffset(TimeUtil.DAY, endDate, -420);
		else if ("6".equals(candlePeriod))
			startDate = TimeUtil.getTimeByOffset(TimeUtil.DAY, endDate, -1680);
		else if ("7".equals(candlePeriod))
			startDate = TimeUtil.getTimeByOffset(TimeUtil.DAY, endDate, -11760);
		else if ("8".equals(candlePeriod))
			startDate = TimeUtil.getTimeByOffset(TimeUtil.DAY, endDate, -11760);
		else
			startDate = TimeUtil.getTimeByOffset(TimeUtil.DAY, endDate, -11760);

		if ("1".equals(candlePeriod) || "2".equals(candlePeriod) || "3".equals(candlePeriod) || "4".equals(candlePeriod)
				|| "5".equals(candlePeriod)) {
			start = TimeUtil.format(startDate, TimeUtil.DATE_TIME_PATTERN_NOBAR);
			end = TimeUtil.format(endDate, TimeUtil.DATE_TIME_PATTERN_NOBAR);
		} else {
			start = TimeUtil.format(startDate, TimeUtil.DATE_PATTERN_NOBAR);
			end = TimeUtil.format(endDate, TimeUtil.DATE_PATTERN_NOBAR);
		}
		return dataFetcher.getK(code, candlePeriod, null, start, end);
	}

	public List<Macd> getMacd(String code, String candlePeriod, String macdMode) {

	}

}
