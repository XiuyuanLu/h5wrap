package com.icaikee.kline.biz.user;

import org.springframework.stereotype.Service;

import com.icaikee.kline.http.HttpHandler;

import net.sf.json.JSONObject;

@Service
public class UserService {

	private static final String REG_URL = "http://api.test.icaikee.com/api/user/v1/member/reguser";

	private static final String LOGIN_URL = "http://api.test.icaikee.com/api/user/v1/member/login";

	public void register(String username, String password, String mobile, String verify) {
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("login_name", username);
		jsonParam.put("login_type", "mobile");
		jsonParam.put("login_password", password);
		jsonParam.put("nickname", username);
		JSONObject result = HttpHandler.httpPost(REG_URL, jsonParam);
		System.out.println(result);
	}

	public void login(String username, String password) {
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("login_name", username);
		jsonParam.put("login_type", "mobile");
		jsonParam.put("login_password", password);
		JSONObject result = HttpHandler.httpPost(LOGIN_URL, jsonParam);
		System.out.println(result);
	}

}
