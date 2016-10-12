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

	private static final String PAGE_LOGIN = "home/login";

	private static final String PAGE_REGISTER = "home/register";

	private static final String PAGE_PERSON = "home/person";

	@RequestMapping
	public ModelAndView home(@RequestParam(name = "stockcode", required = false) String code) {
		if (code == null || "".equals(code))
			code = "000001";
		ModelAndView mv = new ModelAndView(PAGE_HOME);
		mv.addObject("code", code);
		return mv;
	}

	@RequestMapping("/login")
	public ModelAndView login() {
		ModelAndView mv = new ModelAndView(PAGE_LOGIN);
		return mv;
	}

	@RequestMapping("/register")
	public ModelAndView register() {
		ModelAndView mv = new ModelAndView(PAGE_REGISTER);
		return mv;
	}

	@RequestMapping("/person")
	public ModelAndView person() {
		ModelAndView mv = new ModelAndView(PAGE_PERSON);
		return mv;
	}

}
