package com.icaikee.kline.util;

import java.math.BigDecimal;
import java.util.Random;

public class NumberUtil {

	public static double getRandom(int x) {
		Random random = new Random();
		return round(random.nextDouble() * random.nextInt(x));
	}

	public static double round(double number) {
		return round(number, 2);
	}

	public static double round(double number, int x) {
		BigDecimal bd = new BigDecimal(number);
		return bd.setScale(x, BigDecimal.ROUND_HALF_UP).doubleValue();
	}

}
