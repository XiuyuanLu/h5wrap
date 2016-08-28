package com.icaikee.kline.biz.common.model;

import java.util.List;

public class WrapStructures {

	private String stockCode;

	private List<WrapPen> pen;

	private List<WrapSegment> segment;

	private List<WrapCenter> penCenter;

	private List<WrapCenter> segmentCenter;

	public String getStockCode() {
		return stockCode;
	}

	public void setStockCode(String stockCode) {
		this.stockCode = stockCode;
	}

	public List<WrapPen> getPen() {
		return pen;
	}

	public void setPen(List<WrapPen> pen) {
		this.pen = pen;
	}

	public List<WrapSegment> getSegment() {
		return segment;
	}

	public void setSegment(List<WrapSegment> segment) {
		this.segment = segment;
	}

	public List<WrapCenter> getPenCenter() {
		return penCenter;
	}

	public void setPenCenter(List<WrapCenter> penCenter) {
		this.penCenter = penCenter;
	}

	public List<WrapCenter> getSegmentCenter() {
		return segmentCenter;
	}

	public void setSegmentCenter(List<WrapCenter> segmentCenter) {
		this.segmentCenter = segmentCenter;
	}

}
