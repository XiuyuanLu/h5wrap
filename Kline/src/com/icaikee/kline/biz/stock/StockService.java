package com.icaikee.kline.biz.stock;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.icaikee.kline.biz.DataGenerator;
import com.icaikee.kline.biz.common.model.Candlesticks;
import com.icaikee.kline.biz.common.model.RealtimeQuote;
import com.icaikee.kline.util.TimeUtil;

@Service
public class StockService {

	public List<String> fuzzyQuery() {
		List<String> result = new ArrayList<String>();
		result.add("000001 平安銀行");
		result.add("000002 不知道是什麼");
		return result;
	}

	public List<RealtimeQuote> getStockRealtime(String code) throws ParseException {
		return DataGenerator.getRealTime(code);
	}

	public List<Candlesticks> getCandlesticks(String code, String candlePeriod, String candleMode)
			throws ParseException {
		Date date = new Date();
		return DataGenerator.getK(code, candlePeriod, null, new Date(),
				TimeUtil.getTimeByOffset(TimeUtil.DAY, date, -7));
	}

}
