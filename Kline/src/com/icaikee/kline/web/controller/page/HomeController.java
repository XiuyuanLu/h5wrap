package com.icaikee.kline.web.controller.page;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.icaikee.kline.WebConstants;
import com.icaikee.kline.biz.common.CommonService;

@Controller
@RequestMapping(WebConstants.PAGE + "/home")
public class HomeController {

	private static final String PAGE_HOME = "home/home";

	@Autowired
	private CommonService commonService;

	@RequestMapping
	public ModelAndView home() {
		ModelAndView mv = new ModelAndView(PAGE_HOME);
		mv.addObject("tradeTime", commonService.getTradeTime());
		return mv;
	}

}
