package com.icaikee.kline.biz;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.icaikee.kline.biz.common.model.Candlesticks;
import com.icaikee.kline.util.NumberUtil;
import com.icaikee.kline.util.TimeUtil;

public class DataGenerator {

	public static List<Candlesticks> getK(String stockCode, String candlePeriod, String candleMode, Date startDate,
			Date endDate) throws ParseException {
		List<Candlesticks> result = new ArrayList<Candlesticks>();
		if (Integer.parseInt(candlePeriod) < 6) {
			Date now = TimeUtil.parse("2016-08-22 15:00:00", TimeUtil.DATE_TIME_PATTERN);
			for (int i = 0; i < 10; i++) {
				for (int j = 0; j < 48; j++) {
					Candlesticks candlesticks = new Candlesticks();
					candlesticks.setTimeStamp(TimeUtil.format(now, TimeUtil.DATE_TIME_PATTERN));
					candlesticks.setHighPrice(NumberUtil.getRandom());
					candlesticks.setLowPrice(NumberUtil.getRandom());
					candlesticks.setOpenPrice(NumberUtil.getRandom());
					candlesticks.setClosePrice(NumberUtil.getRandom());
					now = TimeUtil.getTimeByOffset(TimeUtil.MINITE, now, -5);
					result.add(candlesticks);
				}
				now = TimeUtil.getTimeByOffset(TimeUtil.DAY, now, -1);
				now = TimeUtil.getTimeByOffset(TimeUtil.MINITE, now, 240);
			}
			return result;
		} else
			return null;

	}

}
