package com.icaikee.kline.web.controller.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icaikee.kline.WebConstants;
import com.icaikee.kline.biz.stock.StockService;

@ResponseBody
@RequestMapping(WebConstants.API + "/stock")
@Controller
public class StockDataController {

	@Autowired
	private StockService stockService;

	@RequestMapping("/fuzzyQuery")
	public List<String> fuzzyQuery() {
		List<String> result = stockService.fuzzyQuery();
		return result;
	}

}
