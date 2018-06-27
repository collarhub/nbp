package com.nbp.simsns.vo;

public class CommentVO {
	private String userEmailHost;
	private String postNo;
	private String postTimestamp;
	private String commentNo;
	private String commentTimestamp;
	private String commentNoParent;
	private String commentTimestampParent;
	private String userEmailGuest;
	private String commentContent;
	private String commentDepth;
	private String userNameGuest;
	
	public CommentVO() {
		super();
	}
	
	public CommentVO(String userEmailHost, String postNo, String postTimestamp, String commentNo,
						String commentTimestamp, String commentNoParent, String commentTimestampParent,
						String userEmailGuest, String commentContent, String commentDepth, String userNameGuest) {
		super();
		this.userEmailHost = userEmailHost;
		this.postNo = postNo;
		this.postTimestamp = postTimestamp;
		this.commentNo = commentNo;
		this.commentTimestamp = commentTimestamp;
		this.commentNoParent = commentNoParent;
		this.commentTimestampParent = commentTimestampParent;
		this.userEmailGuest = userEmailGuest;
		this.commentContent = commentContent;
		this.commentDepth = commentDepth;
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

	public String getPostTimestamp() {
		return postTimestamp;
	}

	public void setPostTimestamp(String postTimestamp) {
		this.postTimestamp = postTimestamp;
	}

	public String getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(String commentNo) {
		this.commentNo = commentNo;
	}

	public String getCommentTimestamp() {
		return commentTimestamp;
	}

	public void setCommentTimestamp(String commentTimestamp) {
		this.commentTimestamp = commentTimestamp;
	}

	public String getCommentNoParent() {
		return commentNoParent;
	}

	public void setCommentNoParent(String commentNoParent) {
		this.commentNoParent = commentNoParent;
	}

	public String getCommentTimestampParent() {
		return commentTimestampParent;
	}

	public void setCommentTimestampParent(String commentTimestampParent) {
		this.commentTimestampParent = commentTimestampParent;
	}

	public String getUserEmailGuest() {
		return userEmailGuest;
	}

	public void setUserEmailGuest(String userEmailGuest) {
		this.userEmailGuest = userEmailGuest;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public String getCommentDepth() {
		return commentDepth;
	}

	public void setCommentDepth(String commentDepth) {
		this.commentDepth = commentDepth;
	}

	public String getUserNameGuest() {
		return userNameGuest;
	}

	public void setUserNameGuest(String userNameGuest) {
		this.userNameGuest = userNameGuest;
	}
}
