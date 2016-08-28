package com.icaikee.kline.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class TimeUtil {

	public static final String DATE_PATTERN = "yyyy-MM-dd";

	public static final String DATE_TIME_PATTERN = "yyyy-MM-dd hh:mm:ss";

	public static final String TIME_PATTERN = "hh:mm";

	public static final int MINITE = 12;

	public static final int DAY = 5;

	/**
	 * 功能描述：返回分
	 *
	 * @param date
	 *            日期
	 * @return 返回分钟
	 */
	public static int getMinute(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return calendar.get(Calendar.MINUTE);
	}

	public static Date parse(String dateString, String pattern) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		return sdf.parse(dateString);
	}

	public static Date getTimeByOffset(int mode, Date date, int offset) {
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(date);
		cal.add(mode, offset);
		return cal.getTime();
	}

	public static String format(Date date, String pattern) {
		SimpleDateFormat dateFormater = new SimpleDateFormat(pattern);
		return dateFormater.format(date);
	}

}
