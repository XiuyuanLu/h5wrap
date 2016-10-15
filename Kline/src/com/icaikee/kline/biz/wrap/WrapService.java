package com.icaikee.kline.biz.wrap;

import java.text.ParseException;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icaikee.kline.biz.DataFetcher;
import com.icaikee.kline.biz.common.model.WrapStructures;
import com.icaikee.kline.util.TimeUtil;

@Service
public class WrapService {

	@Autowired
	private DataFetcher dataFetcher;

	public WrapStructures getWrapStructures(String stockCode, String candlePeriod, String candleMode)
			throws ParseException {
		Date endDate = new Date();
		Date startDate;

		String start;
		String end;

		if ("1".equals(candlePeriod))
			startDate = TimeUtil.getTimeByOffset(TimeUtil.DAY, endDate, -3);
		else if ("2".equals(candlePeriod))
			startDate = TimeUtil.getTimeByOffset(TimeUtil.DAY, endDate, -15);
		else if ("3".equals(candlePeriod))
			startDate = TimeUtil.getTimeByOffset(TimeUtil.DAY, endDate, -45);
		else if ("4".equals(candlePeriod))
			startDate = TimeUtil.getTimeByOffset(TimeUtil.DAY, endDate, -90);
		else if ("5".equals(candlePeriod))
			startDate = TimeUtil.getTimeByOffset(TimeUtil.DAY, endDate, -180);
		else if ("6".equals(candlePeriod))
			startDate = TimeUtil.getTimeByOffset(TimeUtil.DAY, endDate, -730);
		else if ("7".equals(candlePeriod))
			startDate = TimeUtil.getTimeByOffset(TimeUtil.DAY, endDate, -3650);
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
		return dataFetcher.getWrapData(stockCode, candlePeriod, candleMode, start, end);
	}

}
