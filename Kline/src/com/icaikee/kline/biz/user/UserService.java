package com.icaikee.kline.biz.user;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.icaikee.kline.biz.UrlConstants;
import com.icaikee.kline.http.HttpHandler;
import com.icaikee.kline.util.StringUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class UserService {

	private static final String REG_URL = "api/user/v1/member/reguser";

	private static final String LOGIN_URL = "api/user/v1/member/login";

	private static final String VERIFY_URL = "api/service/v1/sms/sendReg";

	private static final String INFO_URL = "api/user/v1/member/myinfo";

	private static final String SHOPPING_URL = "api/user/v1/order/myorder";

	private static final String MESSAGE_URL = "api/sys/v1/sys/getsysmsg";

	private static final String PASSWORD_URL = "api/user/v1/member/updatePassword";

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
			return data.getString("u_id");
		}
		return "error";
	}

	public UserDto getUserInfo(String uid) {
		UserDto user = new UserDto();
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("appId", "icaikeeApp");
		jsonParam.put("u_id", uid);
		jsonParam.put("token", getInfoToken(uid));
		JSONObject result = HttpHandler.httpGet(UrlConstants.PREFIX + INFO_URL, jsonParam);
		if (result == null)
			return user;
		String status = result.getString("status");
		if ("200".equals(status)) {
			JSONObject data = result.getJSONObject("data");
			if (data != null) {
				user.setStockCount(data.getInt("mystockcount"));
				user.setVipEnddate(data.getString("vip_end_date"));
			}
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

	public List<UserMsgDto> getMessages(String uid) {
		List<UserMsgDto> messages = new ArrayList<UserMsgDto>();
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("appId", "icaikeeApp");
		jsonParam.put("u_id", uid);
		jsonParam.put("token", getInfoToken(uid));
		JSONObject result = HttpHandler.httpGet(UrlConstants.PREFIX + MESSAGE_URL, jsonParam);
		if (result == null)
			return messages;
		String status = result.getString("status");
		if ("200".equals(status)) {
			JSONArray array = result.getJSONArray("data");
			if (array != null && array.size() > 0) {
				for (int i = 0; i < array.size(); i++) {
					JSONObject data = array.getJSONObject(i);
					UserMsgDto message = new UserMsgDto();
					message.setContent(data.getString("content"));
					messages.add(message);
				}
			}
		}
		return messages;
	}

	public List<ShoppingDto> getShopping(String uid) {
		List<ShoppingDto> shoppings = new ArrayList<ShoppingDto>();
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("appId", "icaikeeApp");
		jsonParam.put("u_id", uid);
		jsonParam.put("token", getInfoToken(uid));
		JSONObject result = HttpHandler.httpGet(UrlConstants.PREFIX + SHOPPING_URL, jsonParam);
		if (result == null)
			return shoppings;
		String status = result.getString("status");
		if ("200".equals(status)) {
			JSONArray array = result.getJSONArray("data");
			if (array != null && array.size() > 0) {
				for (int i = 0; i < array.size(); i++) {
					JSONObject data = array.getJSONObject(i);
					ShoppingDto shopping = new ShoppingDto();
					shopping.setName(data.getString("name"));
					shopping.setBuyDate(data.getString("buy_date"));
					shopping.setBuyMoney(data.getString("buy_money"));
					shoppings.add(shopping);
				}
			}
		}
		return shoppings;
	}

	public String modifyPassword(String uid, String oldPassword, String newPassword) {
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("appId", "icaikeeApp");
		jsonParam.put("newpwd", newPassword);
		jsonParam.put("oldpwd", oldPassword);
		jsonParam.put("u_id", uid);
		jsonParam.put("token", getPwdToken(uid, newPassword, oldPassword));
		JSONObject result = HttpHandler.httpGet(UrlConstants.PREFIX + PASSWORD_URL, jsonParam);
		if (result == null)
			return "error";
		String status = result.getString("status");
		if ("200".equals(status)) {
			JSONObject data = result.getJSONObject("data");
			if (data != null) {
				return data.getString("msg");
			}
		}
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

	public static String getInfoToken(String uid) {
		return StringUtils.MD5(UrlConstants.TOKEN_PREFIX + "u_id=" + uid).toLowerCase();
	}

	public static String getPwdToken(String uid, String newPassword, String oldPassword) {
		return StringUtils
				.MD5(UrlConstants.TOKEN_PREFIX + "newpwd=" + newPassword + "&oldpwd=" + oldPassword + "&u_id=" + uid)
				.toLowerCase();
	}

}
