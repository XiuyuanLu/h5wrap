package com.icaikee.kline.biz.composite;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icaikee.kline.biz.DataGenerator;
import com.icaikee.kline.biz.common.CommonService;
import com.icaikee.kline.biz.common.model.Candlesticks;
import com.icaikee.kline.biz.common.model.RealtimeQuote;
import com.icaikee.kline.util.TimeUtil;

@Service
public class CompositeService {

	@Autowired
	private CommonService commonService;

	public List<RealtimeQuote> getRealtimeQuote(String stockCode) throws ParseException {
		List<RealtimeQuote> result = DataGenerator.getRealTime(stockCode);
		if (result.size() < 241) {
			List<String> timeList = commonService.getTradeTime();
			for (int i = 0; i < 241; i++) {
				if (i >= result.size()) {
					RealtimeQuote rq = new RealtimeQuote();
					rq.setTimeStamp(timeList.get(i));
					result.add(rq);
				}
			}
		}
		return result;
	}

	public List<Candlesticks> getCandlesticks(String code, String candlePeriod, String candleMode)
			throws ParseException {
		Date date = new Date();
		return DataGenerator.getK(code, candlePeriod, null, new Date(),
				TimeUtil.getTimeByOffset(TimeUtil.DAY, date, -7));
	}
}
