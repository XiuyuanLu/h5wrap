package com.icaikee.kline.biz.common.model;

public class WrapStructures {

	private String stockCode;

	private WrapPen pen;

	private WrapSegment segment;

	private WrapCenter penCenter;

	private WrapCenter segmentCenter;

	public String getStockCode() {
		return stockCode;
	}

	public void setStockCode(String stockCode) {
		this.stockCode = stockCode;
	}

	public WrapPen getPen() {
		return pen;
	}

	public void setPen(WrapPen pen) {
		this.pen = pen;
	}

	public WrapSegment getSegment() {
		return segment;
	}

	public void setSegment(WrapSegment segment) {
		this.segment = segment;
	}

	public WrapCenter getPenCenter() {
		return penCenter;
	}

	public void setPenCenter(WrapCenter penCenter) {
		this.penCenter = penCenter;
	}

	public WrapCenter getSegmentCenter() {
		return segmentCenter;
	}

	public void setSegmentCenter(WrapCenter segmentCenter) {
		this.segmentCenter = segmentCenter;
	}

}
