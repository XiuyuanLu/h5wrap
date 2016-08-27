package com.icaikee.kline.web.controller.page;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.icaikee.kline.WebConstants;

@Controller
@RequestMapping(WebConstants.PAGE + "/stock")
public class StockController {

	private static final String PAGE_STOCK = "stock/stock";

	private static final String PAGE_STOCK_SEARCH = "stock/search";

	@RequestMapping
	public ModelAndView stock() {
		ModelAndView mv = new ModelAndView(PAGE_STOCK);
		return mv;
	}

	@RequestMapping("/search")
	public ModelAndView search() {
		ModelAndView mv = new ModelAndView(PAGE_STOCK_SEARCH);
		return mv;
	}

}
