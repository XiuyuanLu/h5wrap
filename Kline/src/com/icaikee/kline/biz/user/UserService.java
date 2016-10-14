package com.icaikee.kline.biz.user;

import org.springframework.stereotype.Service;

import com.icaikee.kline.http.HttpHandler;
import com.icaikee.kline.util.StringUtils;

import net.sf.json.JSONObject;

@Service
public class UserService {

	private static final String PREFIX = "http://api.test.icaikee.com/";

	private static final String REG_URL = "api/user/v1/member/reguser";

	private static final String LOGIN_URL = "api/user/v1/member/login";

	private static final String CREATE_URL = "api/chanlun/v1/optional/create";

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
		JSONObject result = HttpHandler.httpGet(PREFIX + REG_URL, jsonParam);
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
		JSONObject result = HttpHandler.httpGet(PREFIX + LOGIN_URL, jsonParam);
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

	public String create(String uid, String code) {
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("appId", "icaikeeApp");
		jsonParam.put("code", code);
		jsonParam.put("u_id", uid);
		jsonParam.put("token", getCreateToken(code, uid));
		JSONObject result = HttpHandler.httpGet(PREFIX + CREATE_URL, jsonParam);
		if (result == null)
			return "error";
		String status = result.getString("status");
		if ("200".equals(status)) {
			return "添加成功";
		} else
			return "error";
	}

	public String getVerify(String mobile) {
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("mobile", mobile);
		jsonParam.put("token", getVerifyToken(mobile));
		JSONObject result = HttpHandler.httpGet(PREFIX + VERIFY_URL, jsonParam);
		if (result == null)
			return "error";
		String status = result.getString("status");
		if ("200".equals(status)) {
			return "添加成功";
		} else
			return "error";
	}

	private static final String TOKEN_PREFIX = "appId=icaikeeApp&appSecret=icaikee2016&";

	public static String getLoginToken(String loginName, String loginPassword) {
		return StringUtils.MD5(TOKEN_PREFIX + "login_name=" + loginName + "&login_password=" + loginPassword)
				.toLowerCase();
	}

	public static String getRegisterToken(String loginName, String loginPassword, String userform, String userType,
			String verify) {
		return StringUtils.MD5(TOKEN_PREFIX + "login_name=" + loginName + "&login_password=" + loginPassword + "&mcode="
				+ verify + "&user_form=" + userform + "&user_type=" + userType).toLowerCase();
	}

	public static String getCreateToken(String code, String uid) {
		return StringUtils.MD5(TOKEN_PREFIX + "code=" + code + "&u_id=" + uid).toLowerCase();
	}

	public static String getVerifyToken(String mobile) {
		return StringUtils.MD5(TOKEN_PREFIX + "mobile=" + mobile).toLowerCase();
	}

}
