package com.icaikee.kline.biz.user;

public class UserDto {

	private String loginName;

	private String vipEnddate;

	private String uid;

	private String nickname;

	private int stockCount = 0;

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getVipEnddate() {
		return vipEnddate;
	}

	public void setVipEnddate(String vipEnddate) {
		this.vipEnddate = vipEnddate;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getStockCount() {
		return stockCount;
	}

	public void setStockCount(int stockCount) {
		this.stockCount = stockCount;
	}

}
