package com.nbp.simsns.vo;

public class SearchResultVO {
	private int total;
	private Object result;
	private int index;
	
	public SearchResultVO() {
		super();
	}
	
	public SearchResultVO(int total, Object result, int index) {
		super();
		this.total = total;
		this.result = result;
		this.index = index;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public Object getResult() {
		return result;
	}

	public void setResult(Object result) {
		this.result = result;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}
}
