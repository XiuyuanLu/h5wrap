package com.icaikee.kline.biz.user;

import org.springframework.stereotype.Service;

import com.icaikee.kline.http.HttpHandler;
import com.icaikee.kline.util.StringUtils;

import net.sf.json.JSONObject;

@Service
public class UserService {

	private static final String REG_URL = "http://api.test.icaikee.com/api/user/v1/member/reguser";

	private static final String LOGIN_URL = "http://api.test.icaikee.com/api/user/v1/member/login";

	public String register(String loginName, String nickname, String loginPassword, String mobile, String verify) {
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("appId", "icaikeeApp");
		jsonParam.put("login_name", loginName);
		jsonParam.put("login_password", loginPassword);
		jsonParam.put("nickname", nickname);
		jsonParam.put("user_type", "mobile");
		jsonParam.put("token", getRegisterToken(loginName, loginPassword, nickname, "mobile"));
		JSONObject result = HttpHandler.httpGet(REG_URL, jsonParam);
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
		JSONObject result = HttpHandler.httpGet(LOGIN_URL, jsonParam);
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

	public static String getLoginToken(String loginName, String loginPassword) {
		return StringUtils.MD5(
				"appId=icaikeeApp&appSecret=icaikee2016&login_name=" + loginName + "&login_password=" + loginPassword)
				.toLowerCase();
	}

	public static String getRegisterToken(String loginName, String loginPassword, String nickname, String userType) {
		return StringUtils.MD5("appId=icaikeeApp&appSecret=icaikee2016&login_name=" + loginName + "&login_password="
				+ loginPassword + "&nickname=" + nickname + "&user_type=" + userType).toLowerCase();
	}

}
