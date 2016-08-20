package com.icaikee.kline.web.controller.page;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.icaikee.kline.WebConstants;

@Controller
@RequestMapping(WebConstants.PAGE + "/composite")
public class CompositeController {

	private static final String PAGE_COMPOSITE = "composite/composite";

	private static final String PAGE_KLINE = "composite/kline";

	@RequestMapping
	public ModelAndView composite() {
		ModelAndView mv = new ModelAndView(PAGE_COMPOSITE);
		return mv;
	}

	@RequestMapping("/kline")
	public ModelAndView kline() {
		ModelAndView mv = new ModelAndView(PAGE_KLINE);
		return mv;
	}

}
