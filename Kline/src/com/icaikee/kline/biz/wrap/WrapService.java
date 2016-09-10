package com.icaikee.kline.biz.wrap;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icaikee.kline.biz.DataFetcher;
import com.icaikee.kline.biz.DataGenerator;
import com.icaikee.kline.biz.common.model.SalePoints;
import com.icaikee.kline.biz.common.model.WrapCenter;
import com.icaikee.kline.biz.common.model.WrapPen;
import com.icaikee.kline.biz.common.model.WrapSegment;
import com.icaikee.kline.biz.common.model.WrapStructures;
import com.icaikee.kline.util.TimeUtil;

@Service
public class WrapService {

	@Autowired
	private DataFetcher dataFetcher;

	public List<WrapPen> getWrapPen(String code, String candlePeriod, String candleMode) throws ParseException {
		Date date = new Date();
		return DataGenerator.getW(code, candlePeriod, null, date, TimeUtil.getTimeByOffset(TimeUtil.DAY, date, -7));
	}

	public List<WrapSegment> getWrapSegment(String code, String candlePeriod, String candleMode) throws ParseException {
		Date date = new Date();
		return DataGenerator.getW2(code, candlePeriod, null, date, TimeUtil.getTimeByOffset(TimeUtil.DAY, date, -7));
	}

	public List<WrapCenter> getWrapPenCenter(String code, String candlePeriod, String candleMode)
			throws ParseException {
		Date date = new Date();
		return DataGenerator.getW3(code, candlePeriod, null, date, TimeUtil.getTimeByOffset(TimeUtil.DAY, date, -7));
	}

	public List<SalePoints> getSalePoints(String code, String candlePeriod, String candleMode) throws ParseException {
		Date date = new Date();
		return DataGenerator.getSP(code, candlePeriod, null, date, TimeUtil.getTimeByOffset(TimeUtil.DAY, date, -7));
	}

	public WrapStructures getWrapStructures(String stockCode, String candlePeriod, String candleMode)
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
		return dataFetcher.getWrapData(stockCode, candlePeriod, candleMode, start, end);
	}

}
