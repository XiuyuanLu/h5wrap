package com.icaikee.kline.util;

import java.security.MessageDigest;

public class StringUtils {

	public static boolean isEmpty(String s) {
		return (s == null || "".equals(s));
	}

	public static void main(String[] args) {
		System.out.println(MD5("appId=icaikeeApp&appSecret=icaikee2016&u_id=22").toLowerCase());
		System.out.println(
				MD5("appId=icaikeeApp&appSecret=icaikee2016&login_name=1111&login_password=1111&nickname=aaa&user_type=mobile")
						.toLowerCase());
	}

	public final static String MD5(String s) {
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
		try {
			byte[] btInput = s.getBytes();
			// 获得MD5摘要算法的 MessageDigest 对象
			MessageDigest mdInst = MessageDigest.getInstance("MD5");
			// 使用指定的字节更新摘要
			mdInst.update(btInput);
			// 获得密文
			byte[] md = mdInst.digest();
			// 把密文转换成十六进制的字符串形式
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				str[k++] = hexDigits[byte0 >>> 4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
			return new String(str);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}
