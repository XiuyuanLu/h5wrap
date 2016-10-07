package com.icaikee.kline.web.controller.page;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.icaikee.kline.WebConstants;

@Controller
@RequestMapping(WebConstants.PAGE + "/pool")
public class PoolController {

	private static final String PAGE_POOL = "pool/pool";

	@RequestMapping("/pool")
	public ModelAndView pool() {
		ModelAndView mv = new ModelAndView(PAGE_POOL);
		return mv;
	}

}
