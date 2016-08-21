package com.icaikee.kline.biz.common.model;

public class SalePoints {

	private String stockCode;

	private boolean buySale;

	private String nth;

	private String timeStamp;

	public String getStockCode() {
		return stockCode;
	}

	public void setStockCode(String stockCode) {
		this.stockCode = stockCode;
	}

	public boolean isBuySale() {
		return buySale;
	}

	public void setBuySale(boolean buySale) {
		this.buySale = buySale;
	}

	public String getNth() {
		return nth;
	}

	public void setNth(String nth) {
		this.nth = nth;
	}

	public String getTimeStamp() {
		return timeStamp;
	}

	public void setTimeStamp(String timeStamp) {
		this.timeStamp = timeStamp;
	}

}
