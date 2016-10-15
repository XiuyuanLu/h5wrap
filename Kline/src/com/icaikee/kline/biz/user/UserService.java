package com.icaikee.kline.biz.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icaikee.kline.biz.UrlConstants;
import com.icaikee.kline.biz.portfolio.PortfolioDto;
import com.icaikee.kline.biz.portfolio.PortfolioService;
import com.icaikee.kline.http.HttpHandler;
import com.icaikee.kline.util.StringUtils;

import net.sf.json.JSONObject;

@Service
public class UserService {

	private static final String REG_URL = "api/user/v1/member/reguser";

	private static final String LOGIN_URL = "api/user/v1/member/login";

	private static final String VERIFY_URL = "api/service/v1/sms/sendReg";

	@Autowired
	private PortfolioService portfolioService;

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

	public UserDto login(String username, String password) {
		UserDto user = new UserDto();
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("appId", "icaikeeApp");
		jsonParam.put("login_name", username);
		jsonParam.put("login_password", password);
		jsonParam.put("token", getLoginToken(username, password));
		JSONObject result = HttpHandler.httpGet(UrlConstants.PREFIX + LOGIN_URL, jsonParam);
		if (result == null)
			return user;
		String status = result.getString("status");
		if ("200".equals(status)) {
			JSONObject data = result.getJSONObject("data");
			if (data == null)
				return user;
			user.setUid(data.getString("u_id"));
			user.setLoginName(data.getString("login_name"));
			user.setVipEnddate(data.getString("vip_enddate"));
			user.setNickname(data.getString("nickname"));
			List<PortfolioDto> portfolio = portfolioService.query(user.getUid());
			user.setStockCount(portfolio.size());
		}
		return user;
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
