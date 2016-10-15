package com.icaikee.kline.biz.portfolio;

public class PortfolioDto {

	private String code;

	private String codeDisplay;

	private String name;

	private Double price;

	private String priceDisplay;

	public void init() {

	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getCodeDisplay() {
		return codeDisplay;
	}

	public void setCodeDisplay(String codeDisplay) {
		this.codeDisplay = codeDisplay;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getPriceDisplay() {
		return priceDisplay;
	}

	public void setPriceDisplay(String priceDisplay) {
		this.priceDisplay = priceDisplay;
	}
}
