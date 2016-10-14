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
			// ���MD5ժҪ�㷨�� MessageDigest ����
			MessageDigest mdInst = MessageDigest.getInstance("MD5");
			// ʹ��ָ�����ֽڸ���ժҪ
			mdInst.update(btInput);
			// �������
			byte[] md = mdInst.digest();
			// ������ת����ʮ�����Ƶ��ַ�����ʽ
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
