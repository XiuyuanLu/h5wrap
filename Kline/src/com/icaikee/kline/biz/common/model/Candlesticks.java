package com.icaikee.kline.biz.common.model;

public class Candlesticks {

	private String stockCode;

	private String stockName;

	private String timeStamp;

	private Double openPrice;

	private Double highPrice;

	private Double lowPrice;

	private Double closePrice;

	private Double businessAmount;

	private Double businessBalance;

	private Double turnoverRatio;

	public String getStockCode() {
		return stockCode;
	}

	public void setStockCode(String stockCode) {
		this.stockCode = stockCode;
	}

	public String getStockName() {
		return stockName;
	}

	public void setStockName(String stockName) {
		this.stockName = stockName;
	}

	public String getTimeStamp() {
		return timeStamp;
	}

	public void setTimeStamp(String timeStamp) {
		this.timeStamp = timeStamp;
	}

	public Double getOpenPrice() {
		return openPrice;
	}

	public void setOpenPrice(Double openPrice) {
		this.openPrice = openPrice;
	}

	public Double getHighPrice() {
		return highPrice;
	}

	public void setHighPrice(Double highPrice) {
		this.highPrice = highPrice;
	}

	public Double getLowPrice() {
		return lowPrice;
	}

	public void setLowPrice(Double lowPrice) {
		this.lowPrice = lowPrice;
	}

	public Double getClosePrice() {
		return closePrice;
	}

	public void setClosePrice(Double closePrice) {
		this.closePrice = closePrice;
	}

	public Double getBusinessAmount() {
		return businessAmount;
	}

	public void setBusinessAmount(Double businessAmount) {
		this.businessAmount = businessAmount;
	}

	public Double getBusinessBalance() {
		return businessBalance;
	}

	public void setBusinessBalance(Double businessBalance) {
		this.businessBalance = businessBalance;
	}

	public Double getTurnoverRatio() {
		return turnoverRatio;
	}

	public void setTurnoverRatio(Double turnoverRatio) {
		this.turnoverRatio = turnoverRatio;
	}

}
