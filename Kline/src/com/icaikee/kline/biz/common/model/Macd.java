package com.icaikee.kline.biz.common.model;

public class Macd {

	private String timeStamp;

	private Double dif;

	private Double dea;

	private Double bar;

	public Double getDif() {
		return dif;
	}

	public void setDif(Double dif) {
		this.dif = dif;
	}

	public Double getDea() {
		return dea;
	}

	public void setDea(Double dea) {
		this.dea = dea;
	}

	public Double getBar() {
		return bar;
	}

	public void setBar(Double bar) {
		this.bar = bar;
	}

	public String getTimeStamp() {
		return timeStamp;
	}

	public void setTimeStamp(String timeStamp) {
		this.timeStamp = timeStamp;
	}

}
