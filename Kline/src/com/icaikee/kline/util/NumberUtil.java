package com.icaikee.kline.util;

import java.util.Random;

public class NumberUtil {

	public static double getRandom(int x) {
		Random random = new Random();
		return random.nextDouble() * random.nextInt(x);
	}

}
