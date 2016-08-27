package com.icaikee.kline.biz.stock;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class StockService {

	public List<String> fuzzyQuery() {
		List<String> result = new ArrayList<String>();
		result.add("000001 平安銀行");
		result.add("000002 不知道是什麼");
		return result;
	}

}
