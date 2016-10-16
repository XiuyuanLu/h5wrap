package com.icaikee.kline.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.MessageDigest;

public class StringUtils {

	public static boolean isEmpty(String s) {
		return (s == null || "".equals(s));
	}

	public static void main(String[] args) {
		System.out.println(
				MD5("appId=icaikeeApp&appSecret=icaikee2016&candle_mode=1&candle_period=6&end_date=20161015&start_date=20161008&trade_type=B1&u_id=68")
						.toLowerCase());
	}

	public static String GBK2Unicode(String str) {
		StringBuffer result = new StringBuffer();
		for (int i = 0; i < str.length(); i++) {
			char chr1 = (char) str.charAt(i);
			if (!isNeedConvert(chr1)) {
				result.append(chr1);
				continue;
			}
			result.append("\\u" + Integer.toHexString((int) chr1));
		}
		return result.toString();
	}

	public static String getUtf8(String x) {
		String xmString;
		try {
			xmString = new String(x.getBytes("UTF-8"));
			return URLEncoder.encode(xmString, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		return "error";
	}

	public static String getChn(String x) {
		String xmString;
		try {
			xmString = new String(x.getBytes("UTF-8"));
			return URLDecoder.decode(xmString, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		return "error";
	}

	public static boolean isNeedConvert(char para) {
		return ((para & (0x00FF)) != para);
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

	public static String deUnicode(String content) {// 将16进制数转换为汉字
		String enUnicode = null;
		String deUnicode = null;
		for (int i = 0; i < content.length(); i++) {
			if (enUnicode == null) {
				enUnicode = String.valueOf(content.charAt(i));
			} else {
				enUnicode = enUnicode + content.charAt(i);
			}
			if (i % 4 == 3) {
				if (enUnicode != null) {
					if (deUnicode == null) {
						deUnicode = String.valueOf((char) Integer.valueOf(enUnicode, 16).intValue());
					} else {
						deUnicode = deUnicode + String.valueOf((char) Integer.valueOf(enUnicode, 16).intValue());
					}
				}
				enUnicode = null;
			}

		}
		return deUnicode;

	}

	public static String enUnicode(String content) {// 将汉字转换为16进制数
		String enUnicode = null;
		for (int i = 0; i < content.length(); i++) {
			if (i == 0) {
				enUnicode = getHexString(Integer.toHexString(content.charAt(i)).toUpperCase());
			} else {
				enUnicode = enUnicode + getHexString(Integer.toHexString(content.charAt(i)).toUpperCase());
			}
		}
		return enUnicode;

	}

	private static String getHexString(String hexString) {
		String hexStr = "";
		for (int i = hexString.length(); i < 4; i++) {
			if (i == hexString.length())
				hexStr = "0";
			else
				hexStr = hexStr + "0";
		}
		return hexStr + hexString;
	}

}
