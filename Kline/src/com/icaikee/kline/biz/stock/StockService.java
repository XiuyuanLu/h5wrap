package com.icaikee.kline.biz.stock;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icaikee.kline.biz.DataFetcher;
import com.icaikee.kline.biz.common.CommonService;
import com.icaikee.kline.biz.common.model.Candlesticks;
import com.icaikee.kline.biz.common.model.Product;
import com.icaikee.kline.biz.common.model.RealtimeQuote;
import com.icaikee.kline.util.TimeUtil;

@Service
public class StockService {

	@Autowired
	private CommonService commonService;

	public List<Product> fuzzyQuery(String q) {
		return DataFetcher.getStocks(q);
	}

	public List<RealtimeQuote> getStock(String code) throws ParseException {
		List<RealtimeQuote> result = DataFetcher.getStockPrice(code);
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
		return DataFetcher.getStockSnapshot(code);
	}

	public List<Candlesticks> getCandlesticks(String code, String candlePeriod, String candleMode)
			throws ParseException {
		Date date = new Date();
		return DataFetcher.getK(code, candlePeriod, null, new Date(), TimeUtil.getTimeByOffset(TimeUtil.DAY, date, -7));
	}

}
