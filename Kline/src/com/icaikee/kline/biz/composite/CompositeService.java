package com.icaikee.kline.biz.composite;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.icaikee.kline.biz.DataGenerator;
import com.icaikee.kline.biz.common.model.Candlesticks;
import com.icaikee.kline.biz.common.model.RealtimeQuote;
import com.icaikee.kline.util.TimeUtil;

@Service
public class CompositeService {

	public List<RealtimeQuote> getRealtimeQuote(String stockCode) throws ParseException {
		return DataGenerator.getRealTime(stockCode);
	}

	public List<Candlesticks> getCandlesticks(String code, String candlePeriod, String candleMode)
			throws ParseException {
		Date date = new Date();
		return DataGenerator.getK(code, candlePeriod, null, new Date(),
				TimeUtil.getTimeByOffset(TimeUtil.DAY, date, -7));
	}
}
