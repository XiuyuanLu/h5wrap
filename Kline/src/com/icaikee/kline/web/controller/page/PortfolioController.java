package com.icaikee.kline.web.controller.page;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.icaikee.kline.WebConstants;

@Controller
@RequestMapping(WebConstants.PAGE + "/portfolio")
public class PortfolioController {

	private static final String PAGE_PORTFOLIO = "portfolio/portfolio";

	@RequestMapping("/portfolio")
	public ModelAndView portfolio() {
		ModelAndView mv = new ModelAndView(PAGE_PORTFOLIO);
		return mv;
	}
}
