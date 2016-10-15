package com.icaikee.kline.web.controller.api;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icaikee.kline.WebConstants;
import com.icaikee.kline.biz.pool.PoolService;
import com.icaikee.kline.core.message.Message;

@ResponseBody
@RequestMapping(WebConstants.API + "/pool")
@Controller
public class PoolDataController {

	@Autowired
	private PoolService poolService;

	@RequestMapping("/query")
	public Message query(HttpServletRequest request, @RequestParam(name = "candleMode") String candleMode,
			@RequestParam(name = "candlePeriod") String candlePeriod,
			@RequestParam(name = "tradeType") String tradeType) {
		HttpSession session = request.getSession();
		String uid = (String) session.getAttribute(WebConstants.USER_ID);
		return new Message(poolService.getPool(uid, tradeType, candlePeriod, candleMode));
	}

}
