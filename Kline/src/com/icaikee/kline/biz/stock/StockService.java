package com.icaikee.kline.biz.stock;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class StockService {

	public List<String> fuzzyQuery() {
		List<String> result = new ArrayList<String>();
		result.add("000001 ƽ���y��");
		result.add("000002 ��֪����ʲ�N");
		return result;
	}

}
