package com.icaikee.kline.web.controller.page;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

	private static final String PAGE_PASSWORD = "home/password";

	private static final String PAGE_SHOPPING = "home/shopping";

	private static final String PAGE_MESSAGE = "home/message";

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
	public ModelAndView person(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView(PAGE_PERSON);
		HttpSession session = request.getSession();
		mv.addObject(WebConstants.LOGIN_NAME, session.getAttribute(WebConstants.LOGIN_NAME));
		mv.addObject(WebConstants.STOCK_COUNT, session.getAttribute(WebConstants.STOCK_COUNT));
		mv.addObject(WebConstants.VIP_ENDDATE, session.getAttribute(WebConstants.VIP_ENDDATE));
		return mv;
	}

	@RequestMapping("/password")
	public ModelAndView password(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView(PAGE_PASSWORD);
		return mv;
	}

	@RequestMapping("/shopping")
	public ModelAndView shopping(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView(PAGE_SHOPPING);
		return mv;
	}

	@RequestMapping("/message")
	public ModelAndView message(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView(PAGE_MESSAGE);
		return mv;
	}

}
