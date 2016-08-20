package com.icaikee.kline.http;

import java.io.IOException;
import java.net.URLDecoder;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import net.sf.json.JSONObject;

public class HttpHandler {
	private static Logger logger = LoggerFactory.getLogger(HttpHandler.class); // ��־��¼

	/**
	 * httpPost
	 * 
	 * @param url
	 *            ·��
	 * @param jsonParam
	 *            ����
	 * @return
	 */
	public static JSONObject httpPost(String url, JSONObject jsonParam) {
		return httpPost(url, jsonParam, false);
	}

	/**
	 * post����
	 * 
	 * @param url
	 *            url��ַ
	 * @param jsonParam
	 *            ����
	 * @param noNeedResponse
	 *            ����Ҫ���ؽ��
	 * @return
	 */
	public static JSONObject httpPost(String url, JSONObject jsonParam, boolean noNeedResponse) {
		// post���󷵻ؽ��
		CloseableHttpClient httpClient = HttpClientBuilder.create().build();
		JSONObject jsonResult = null;
		HttpPost method = new HttpPost(url);
		try {
			if (null != jsonParam) {
				// ���������������
				StringEntity entity = new StringEntity(jsonParam.toString(), "utf-8");
				entity.setContentEncoding("UTF-8");
				entity.setContentType("application/json");
				method.setEntity(entity);
			}
			HttpResponse result = httpClient.execute(method);
			url = URLDecoder.decode(url, "UTF-8");
			/** �����ͳɹ������õ���Ӧ **/
			if (result.getStatusLine().getStatusCode() == 200) {
				String str = "";
				try {
					/** ��ȡ���������ع�����json�ַ������� **/
					str = EntityUtils.toString(result.getEntity());
					if (noNeedResponse) {
						return null;
					}
					/** ��json�ַ���ת����json���� **/
					jsonResult = JSONObject.fromObject(str);
				} catch (Exception e) {
					logger.error("post�����ύʧ��:" + url, e);
				}
			}
		} catch (IOException e) {
			logger.error("post�����ύʧ��:" + url, e);
		}
		return jsonResult;
	}

	/**
	 * ����get����
	 * 
	 * @param url
	 *            ·��
	 * @return
	 */
	public static JSONObject httpGet(String url) {
		// get���󷵻ؽ��
		JSONObject jsonResult = null;
		try {
			CloseableHttpClient client = HttpClientBuilder.create().build();
			// ����get����
			HttpGet request = new HttpGet(url);
			HttpResponse response = client.execute(request);

			/** �����ͳɹ������õ���Ӧ **/
			if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
				/** ��ȡ���������ع�����json�ַ������� **/
				String strResult = EntityUtils.toString(response.getEntity());
				/** ��json�ַ���ת����json���� **/
				jsonResult = JSONObject.fromObject(strResult);
				url = URLDecoder.decode(url, "UTF-8");
			} else {
				logger.error("get�����ύʧ��:" + url);
			}
		} catch (IOException e) {
			logger.error("get�����ύʧ��:" + url, e);
		}
		return jsonResult;
	}
}
