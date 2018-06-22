package com.nbp.simsns.vo;

public class SearchVO {
	private String userEmailHost;
	private String searchRange;
	private String searchKeyword;
	
	public SearchVO() {
		super();
	}
	
	public SearchVO(String userEmailHost, String searchRange, String searchKeyword) {
		super();
		this.userEmailHost = userEmailHost;
		this.searchRange = searchRange;
		this.searchKeyword = searchKeyword;
	}

	public String getUserEmailHost() {
		return userEmailHost;
	}

	public void setUserEmailHost(String userEmailHost) {
		this.userEmailHost = userEmailHost;
	}

	public String getSearchRange() {
		return searchRange;
	}

	public void setSearchRange(String searchRange) {
		this.searchRange = searchRange;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
}
