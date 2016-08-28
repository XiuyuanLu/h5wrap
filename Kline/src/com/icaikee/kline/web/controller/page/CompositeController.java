package com.icaikee.kline.web.controller.page;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.PostConstruct;

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

	private static final Map<String, String> names = new HashMap<String, String>();

	@PostConstruct
	public void init() {
		names.put("000001", "上证综指");
		names.put("399001", "深证成指");
		names.put("399006", "创业板指");
	}

	@RequestMapping
	public ModelAndView composite(@RequestParam(name = "stockcode", required = false) String code) {
		if (code == null || "".equals(code))
			code = "000001";
		ModelAndView mv = new ModelAndView(PAGE_COMPOSITE);
		mv.addObject("name", names.get(code));
		mv.addObject("code", code);
		return mv;
	}

	@RequestMapping("/kline")
	public ModelAndView kline(@RequestParam(name = "stockcode") String code, @RequestParam(name = "type") String type) {
		ModelAndView mv = new ModelAndView(PAGE_KLINE);
		mv.addObject("code", code);
		mv.addObject("name", names.get(code));
		mv.addObject("type", type);
		return mv;
	}

}
