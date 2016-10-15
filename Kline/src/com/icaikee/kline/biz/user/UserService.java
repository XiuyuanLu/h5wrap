package com.icaikee.kline.biz.user;

import org.springframework.stereotype.Service;

import com.icaikee.kline.biz.UrlConstants;
import com.icaikee.kline.http.HttpHandler;
import com.icaikee.kline.util.StringUtils;

import net.sf.json.JSONObject;

@Service
public class UserService {

	private static final String REG_URL = "api/user/v1/member/reguser";

	private static final String LOGIN_URL = "api/user/v1/member/login";

	private static final String VERIFY_URL = "api/service/v1/sms/sendReg";

	public String register(String loginName, String loginPassword, String verify) {
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("appId", "icaikeeApp");
		jsonParam.put("login_name", loginName);
		jsonParam.put("login_password", loginPassword);
		jsonParam.put("user_form", "chanlun");
		jsonParam.put("user_type", "mobile");
		jsonParam.put("mcode", verify);
		jsonParam.put("token", getRegisterToken(loginName, loginPassword, "chanlun", "mobile", verify));
		JSONObject result = HttpHandler.httpGet(UrlConstants.PREFIX + REG_URL, jsonParam);
		if (result == null)
			return "error";
		String status = result.getString("status");
		if ("200".equals(status))
			return "success";
		else
			return "error";
	}

	public String login(String username, String password) {
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("appId", "icaikeeApp");
		jsonParam.put("login_name", username);
		jsonParam.put("login_password", password);
		jsonParam.put("token", getLoginToken(username, password));
		JSONObject result = HttpHandler.httpGet(UrlConstants.PREFIX + LOGIN_URL, jsonParam);
		if (result == null)
			return "error";
		String status = result.getString("status");
		if ("200".equals(status)) {
			JSONObject data = result.getJSONObject("data");
			if (data == null)
				return "error";
			String userId = data.getString("u_id");
			if (StringUtils.isEmpty(userId))
				return "error";
			return userId;
		} else
			return "error";
	}

	public String getVerify(String mobile) {
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("mobile", mobile);
		jsonParam.put("token", getVerifyToken(mobile));
		JSONObject result = HttpHandler.httpGet(UrlConstants.PREFIX + VERIFY_URL, jsonParam);
		if (result == null)
			return "error";
		String status = result.getString("status");
		if ("200".equals(status)) {
			return "Ìí¼Ó³É¹¦";
		} else
			return "error";
	}

	public static String getLoginToken(String loginName, String loginPassword) {
		return StringUtils
				.MD5(UrlConstants.TOKEN_PREFIX + "login_name=" + loginName + "&login_password=" + loginPassword)
				.toLowerCase();
	}

	public static String getRegisterToken(String loginName, String loginPassword, String userform, String userType,
			String verify) {
		return StringUtils.MD5(UrlConstants.TOKEN_PREFIX + "login_name=" + loginName + "&login_password="
				+ loginPassword + "&mcode=" + verify + "&user_form=" + userform + "&user_type=" + userType)
				.toLowerCase();
	}

	public static String getVerifyToken(String mobile) {
		return StringUtils.MD5(UrlConstants.TOKEN_PREFIX + "mobile=" + mobile).toLowerCase();
	}

}
