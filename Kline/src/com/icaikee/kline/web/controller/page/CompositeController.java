package com.icaikee.kline.web.controller.page;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.icaikee.kline.WebConstants;

@Controller
@RequestMapping(WebConstants.PAGE + "/composite")
public class CompositeController {

	private static final String PAGE_COMPOSITE = "composite/composite";

	private static final String PAGE_KLINE = "composite/kline";

	@RequestMapping
	public ModelAndView composite(@RequestParam(name = "stockcode", required = false) String code) {
		if (code == null || "".equals(code))
			code = "000001";
		ModelAndView mv = new ModelAndView(PAGE_COMPOSITE);
		mv.addObject("code", code);
		return mv;
	}

	@RequestMapping("/kline")
	public ModelAndView kline(@RequestParam(name = "stockcode") String code, @RequestParam(name = "type") String type) {
		ModelAndView mv = new ModelAndView(PAGE_KLINE);
		mv.addObject("code", code);
		mv.addObject("type", type);
		return mv;
	}

}
