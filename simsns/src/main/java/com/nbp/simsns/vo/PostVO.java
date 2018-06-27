package com.nbp.simsns.vo;

public class PostVO {
	private String userEmailHost;
	private String postNo;
	private String postTitle;
	private String postContent;
	private String postTimestamp;
	private String userEmailGuest;
	private String userNameGuest;
	
	public PostVO() {
		super();
	}

	public PostVO(String userEmailHost, String postNo, String postTitle, String postContent,
			String postTimestamp, String userEmailGuest, String userNameGuest) {
		super();
		this.userEmailHost = userEmailHost;
		this.postNo = postNo;
		this.postTitle = postTitle;
		this.postContent = postContent;
		this.postTimestamp = postTimestamp;
		this.userEmailGuest = userEmailGuest;
		this.userNameGuest = userNameGuest;
	}

	public String getUserEmailHost() {
		return userEmailHost;
	}

	public void setUserEmailHost(String userEmailHost) {
		this.userEmailHost = userEmailHost;
	}

	public String getPostNo() {
		return postNo;
	}

	public void setPostNo(String postNo) {
		this.postNo = postNo;
	}

	public String getPostTitle() {
		return postTitle;
	}

	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}

	public String getPostContent() {
		return postContent;
	}

	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}

	public String getPostTimestamp() {
		return postTimestamp;
	}

	public void setPostTimestamp(String postTimestamp) {
		this.postTimestamp = postTimestamp;
	}

	public String getUserEmailGuest() {
		return userEmailGuest;
	}

	public void setUserEmailGuest(String userEmailGuest) {
		this.userEmailGuest = userEmailGuest;
	}

	public String getUserNameGuest() {
		return userNameGuest;
	}

	public void setUserNameGuest(String userNameGuest) {
		this.userNameGuest = userNameGuest;
	}
}
