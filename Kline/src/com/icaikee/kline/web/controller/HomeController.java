package com.icaikee.kline.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.icaikee.kline.WebConstants;

@Controller
@RequestMapping(WebConstants.PAGE + "/home")
public class HomeController {

	private static final String PAGE_HOME = "home/home";

	@RequestMapping
	public ModelAndView home() {
		return new ModelAndView(PAGE_HOME);
	}

}
