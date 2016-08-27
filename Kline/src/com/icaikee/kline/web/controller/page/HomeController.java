package com.icaikee.kline.web.controller.page;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.icaikee.kline.WebConstants;

@Controller
@RequestMapping(WebConstants.PAGE + "/home")
public class HomeController {

	private static final String PAGE_HOME = "home/home";

	@RequestMapping
	public ModelAndView home(@RequestParam(name = "stockcode", required = false) String code) {
		if (code == null || "".equals(code))
			code = "000001";
		ModelAndView mv = new ModelAndView(PAGE_HOME);
		mv.addObject("code", code);
		return mv;
	}

}
