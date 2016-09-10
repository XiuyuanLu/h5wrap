package com.icaikee.kline.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TimeUtil {

	private static Logger logger = LoggerFactory.getLogger(TimeUtil.class);

	public static final String DATE_PATTERN = "yyyy-MM-dd";

	public static final String DATE_PATTERN_NOBAR = "yyyyMMdd";

	public static final String START_MORNING = "0930";

	public static final String END_MORNING = "1130";

	public static final String START_AFTERNOON = "1300";

	public static final String END_AFTERNOON = "1500";

	public static final String DATE_TIME_PATTERN = "yyyy-MM-dd HH:mm";

	public static final String DATE_TIME_PATTERN_NOBAR = "yyyyMMddHHmm";

	public static final String TIME_PATTERN = "HH:mm";

	public static final int MINITE = 12;

	public static final int DAY = 5;

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

	public static String format(String date, String inputPattern, String outputPattern) throws ParseException {
		Date d = parse(date, inputPattern);
		SimpleDateFormat dateFormater = new SimpleDateFormat(outputPattern);
		return dateFormater.format(d);
	}

	public static boolean isTradeTime(Date now) {
		SimpleDateFormat df = new SimpleDateFormat("hh:mm:ss");
		try {
			Date d1 = df.parse("09:29:59");
			Date d2 = df.parse("11:30:01");
			Date d3 = df.parse("12:59:59");
			Date d4 = df.parse("15:00:01");
			return ((now.after(d1) && now.before(d2)) || (now.after(d3) && now.before(d4)));
		} catch (ParseException e) {
			logger.error("时间格式有误", e);
			return false;
		}
	}

	public static String getStartMorning() {
		return format(new Date(), DATE_PATTERN_NOBAR) + START_MORNING;
	}

	public static String getEndAfternoon() {
		return format(new Date(), DATE_PATTERN_NOBAR) + END_AFTERNOON;
	}

	public static String getStartMorning(String date) {
		return date + START_MORNING;
	}

	public static String getEndAfternoon(String date) {
		return date + END_AFTERNOON;
	}

	public static String getNowMinite() {
		return format(new Date(), DATE_TIME_PATTERN_NOBAR);
	}

}