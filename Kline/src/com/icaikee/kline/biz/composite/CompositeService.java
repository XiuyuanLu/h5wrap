package com.icaikee.kline.biz.composite;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.icaikee.kline.biz.DataGenerator;
import com.icaikee.kline.biz.common.model.Candlesticks;
import com.icaikee.kline.biz.common.model.RealtimeQuote;

@Service
public class CompositeService {

	public List<RealtimeQuote> getRealtimeQuote(String stockCode) {
		return null;
	}

	public List<Candlesticks> getCandlesticks(String stockCode, String candlePeriod, String candleMode, Date startDate,
			Date endDate) throws ParseException {
		return DataGenerator.getK(null, "2", null, null, null);
	}
}
