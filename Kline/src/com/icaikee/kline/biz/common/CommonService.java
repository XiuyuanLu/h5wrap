package com.icaikee.kline.biz.common;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Service;

@Service
public class CommonService {

	private List<String> dailyTradeTime = new ArrayList<String>();

	@PostConstruct
	private void init() {
		int minite = 30;
		int hour = 9;

		for (int i = 9; i <= 14; i++) {
			for (int j = 0; j <= 59; j++) {
				if (minite > 59 || (hour == 11 && minite > 30) || (hour == 12))
					break;
				String time = hour + ":" + ((minite < 10) ? ("0" + minite) : minite);
				dailyTradeTime.add(time);
				minite += 1;
			}
			hour = i + 1;
			minite = 0;
		}
		dailyTradeTime.add("15:00");
	}

	public List<String> getTradeTime() {
		return dailyTradeTime;
	}

	public static List<String> splitGrp(String grp) {
		List<String> result = new ArrayList<String>();
		if (grp == null || "".equals(grp))
			return result;
		String[] strs = grp.split(",");
		for (String s : strs)
			result.add(s);
		return result;
	}

}
