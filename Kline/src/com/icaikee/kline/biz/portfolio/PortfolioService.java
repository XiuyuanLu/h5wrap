package com.icaikee.kline.biz.portfolio;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.icaikee.kline.biz.UrlConstants;
import com.icaikee.kline.http.HttpHandler;
import com.icaikee.kline.util.StringUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class PortfolioService {

	private static final String CREATE_URL = "api/chanlun/v1/optional/create";

	private static final String QUERY_URL = "api/chanlun/v1/optional/query";

	public String create(String uid, String code) {
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("appId", "icaikeeApp");
		jsonParam.put("code", code);
		jsonParam.put("u_id", uid);
		jsonParam.put("token", getCreateToken(code, uid));
		JSONObject result = HttpHandler.httpGet(UrlConstants.PREFIX + CREATE_URL, jsonParam);
		if (result == null)
			return "error";
		String status = result.getString("status");
		if ("200".equals(status)) {
			return "Ìí¼Ó³É¹¦";
		} else
			return "error";
	}

	public List<PortfolioDto> query(String uid) {
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("appId", "icaikeeApp");
		jsonParam.put("u_id", uid);
		jsonParam.put("token", getQueryToken(uid));
		JSONObject result = HttpHandler.httpGet(UrlConstants.PREFIX + QUERY_URL, jsonParam);
		List<PortfolioDto> portfolio = new ArrayList<PortfolioDto>();
		if (result == null)
			return portfolio;
		String status = result.getString("status");
		if ("200".equals(status)) {
			JSONArray data = result.getJSONArray("data");
			if (data != null && data.size() > 0) {
				for (int i = 0; i < data.size(); i++) {
					JSONObject x = (JSONObject) data.get(i);
					PortfolioDto item = new PortfolioDto();
					item.setCode(x.getString("code"));
					portfolio.add(item);
				}
			}
		}
		return portfolio;
	}

	public static String getCreateToken(String code, String uid) {
		return StringUtils.MD5(UrlConstants.TOKEN_PREFIX + "code=" + code + "&u_id=" + uid).toLowerCase();
	}

	public static String getQueryToken(String uid) {
		return StringUtils.MD5(UrlConstants.TOKEN_PREFIX + "u_id=" + uid).toLowerCase();
	}

}
