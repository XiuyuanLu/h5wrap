package com.icaikee.kline.biz.wrap;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.icaikee.kline.biz.DataGenerator;
import com.icaikee.kline.biz.common.model.WrapCenter;
import com.icaikee.kline.biz.common.model.WrapPen;
import com.icaikee.kline.biz.common.model.WrapSegment;
import com.icaikee.kline.biz.common.model.WrapStructures;
import com.icaikee.kline.util.TimeUtil;

@Service
public class WrapService {

	public List<WrapPen> getWrapPen(String code, String candlePeriod, String candleMode) throws ParseException {
		Date date = new Date();
		return DataGenerator.getW(code, candlePeriod, null, new Date(),
				TimeUtil.getTimeByOffset(TimeUtil.DAY, date, -7));
	}

	public List<WrapSegment> getWrapSegment(String code, String candlePeriod, String candleMode) throws ParseException {
		Date date = new Date();
		return DataGenerator.getW2(code, candlePeriod, null, new Date(),
				TimeUtil.getTimeByOffset(TimeUtil.DAY, date, -7));
	}

	public List<WrapCenter> getWrapPenCenter(String code, String candlePeriod, String candleMode)
			throws ParseException {
		Date date = new Date();
		return DataGenerator.getW3(code, candlePeriod, null, new Date(),
				TimeUtil.getTimeByOffset(TimeUtil.DAY, date, -7));
	}

	public WrapStructures getWrapStructures(String code, String candlePeriod, String candleMode) throws ParseException {
		WrapStructures wrapStructures = new WrapStructures();
		wrapStructures.setStockCode(code);
		wrapStructures.setPen(getWrapPen(code, candlePeriod, candleMode));
		wrapStructures.setSegment(getWrapSegment(code, candlePeriod, candleMode));
		wrapStructures.setPenCenter(getWrapPenCenter(code, candlePeriod, candleMode));
		return wrapStructures;
	}

}
