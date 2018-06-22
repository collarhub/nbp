package com.nbp.simsns.vo;

public class SearchVO2 {
	private String userEmailHost;
	private String searchKeyword;
	private int searchIndex;
	
	public SearchVO2() {
		super();
	}

	public SearchVO2(String userEmailHost, String searchKeyword, int searchIndex) {
		super();
		this.userEmailHost = userEmailHost;
		this.searchKeyword = searchKeyword;
		this.searchIndex = searchIndex;
	}
	
	public String getUserEmailHost() {
		return userEmailHost;
	}

	public void setUserEmailHost(String userEmailHost) {
		this.userEmailHost = userEmailHost;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public int getSearchIndex() {
		return searchIndex;
	}

	public void setSearchIndex(int searchIndex) {
		this.searchIndex = searchIndex;
	}
	
	
}
