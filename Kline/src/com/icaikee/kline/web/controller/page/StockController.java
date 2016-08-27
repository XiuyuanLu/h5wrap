package com.icaikee.kline.web.controller.page;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.icaikee.kline.WebConstants;

@Controller
@RequestMapping(WebConstants.PAGE + "/stock")
public class StockController {

	private static final String PAGE_STOCK = "stock/stock";

	private static final String PAGE_STOCK_KLINE = "stock/kline";

	private static final String PAGE_STOCK_SEARCH = "stock/search";

	@RequestMapping
	public ModelAndView stock(@RequestParam(name = "stockcode") String code) {
		ModelAndView mv = new ModelAndView(PAGE_STOCK);
		mv.addObject("code", code);
		return mv;
	}

	@RequestMapping("/search")
	public ModelAndView search() {
		ModelAndView mv = new ModelAndView(PAGE_STOCK_SEARCH);
		return mv;
	}

	@RequestMapping("/kline")
	public ModelAndView kline(@RequestParam(name = "stockcode") String code, @RequestParam(name = "type") String type) {
		ModelAndView mv = new ModelAndView(PAGE_STOCK_KLINE);
		mv.addObject("code", code);
		mv.addObject("type", type);
		return mv;
	}

}
