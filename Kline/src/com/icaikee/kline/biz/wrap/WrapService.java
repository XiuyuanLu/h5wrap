package com.icaikee.kline.biz.wrap;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.icaikee.kline.biz.DataGenerator;
import com.icaikee.kline.biz.common.model.WrapPen;
import com.icaikee.kline.util.TimeUtil;

@Service
public class WrapService {

	public List<WrapPen> getWrap(String code, String candlePeriod, String candleMode) throws ParseException {
		Date date = new Date();
		return DataGenerator.getW(code, candlePeriod, null, new Date(),
				TimeUtil.getTimeByOffset(TimeUtil.DAY, date, -7));
	}

}
