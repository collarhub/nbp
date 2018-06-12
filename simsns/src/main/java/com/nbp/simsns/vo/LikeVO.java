package com.nbp.simsns.vo;

public class LikeVO {
	private String userEmailHost;
	private String postNo;
	private String postTimestamp;
	private String commentNo;
	private String commentTimestamp;
	private String likeNo;
	private String likeTimestamp;
	private String userEmailGuest;
	private String commentDepth;
	
	public LikeVO() {
		super();
	}
	
	public LikeVO(String userEmailHost, String postNo, String postTimestamp, String commentNo, String commentTimestamp,
			String likeNo, String likeTimestamp, String userEmailGuest, String commentDepth) {
		super();
		this.userEmailHost = userEmailHost;
		this.postNo = postNo;
		this.postTimestamp = postTimestamp;
		this.commentNo = commentNo;
		this.commentTimestamp = commentTimestamp;
		this.likeNo = likeNo;
		this.likeTimestamp = likeTimestamp;
		this.userEmailGuest = userEmailGuest;
		this.commentDepth = commentDepth;
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

	public String getLikeNo() {
		return likeNo;
	}

	public void setLikeNo(String likeNo) {
		this.likeNo = likeNo;
	}

	public String getLikeTimestamp() {
		return likeTimestamp;
	}

	public void setLikeTimestamp(String likeTimestamp) {
		this.likeTimestamp = likeTimestamp;
	}

	public String getUserEmailGuest() {
		return userEmailGuest;
	}

	public void setUserEmailGuest(String userEmailGuest) {
		this.userEmailGuest = userEmailGuest;
	}

	public String getCommentDepth() {
		return commentDepth;
	}

	public void setCommentDepth(String commentDepth) {
		this.commentDepth = commentDepth;
	}
}
