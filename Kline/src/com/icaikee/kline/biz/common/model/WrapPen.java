package com.icaikee.kline.biz.common.model;

public class WrapPen {

	private String timeStamp;

	private String mode;

	private Double value;

	private Double momentum;

	private String kind;

	public String getTimeStamp() {
		return timeStamp;
	}

	public void setTimeStamp(String timeStamp) {
		this.timeStamp = timeStamp;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public Double getValue() {
		return value;
	}

	public void setValue(Double value) {
		this.value = value;
	}

	public Double getMomentum() {
		return momentum;
	}

	public void setMomentum(Double momentum) {
		this.momentum = momentum;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

}
