package com.nbp.simsns.vo;

public class PictureVO {
	private String userEmailHost;
	private String pictureNo;
	private String pictureTimestamp;
	private String pictureTitle;
	private String picturePath;
	private String postNo;
	private String postTimestamp;
	private String userEmailGuest;
	
	public PictureVO() {
		super();
	}
	
	public PictureVO(String userEmailHost, String pictureNo, String pictureTimestamp, String pictureTitle,
			String picturePath, String postNo, String postTimestamp, String userEmailGuest) {
		super();
		this.userEmailHost = userEmailHost;
		this.pictureNo = pictureNo;
		this.pictureTimestamp = pictureTimestamp;
		this.pictureTitle = pictureTitle;
		this.picturePath = picturePath;
		this.postNo = postNo;
		this.postTimestamp = postTimestamp;
		this.userEmailGuest = userEmailGuest;
	}

	public String getUserEmailHost() {
		return userEmailHost;
	}

	public void setUserEmailHost(String userEmailHost) {
		this.userEmailHost = userEmailHost;
	}

	public String getPictureNo() {
		return pictureNo;
	}

	public void setPictureNo(String pictureNo) {
		this.pictureNo = pictureNo;
	}

	public String getPictureTimestamp() {
		return pictureTimestamp;
	}

	public void setPictureTimestamp(String pictureTimestamp) {
		this.pictureTimestamp = pictureTimestamp;
	}

	public String getPictureTitle() {
		return pictureTitle;
	}

	public void setPictureTitle(String pictureTitle) {
		this.pictureTitle = pictureTitle;
	}

	public String getPicturePath() {
		return picturePath;
	}

	public void setPicturePath(String picturePath) {
		this.picturePath = picturePath;
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

	public String getUserEmailGuest() {
		return userEmailGuest;
	}

	public void setUserEmailGuest(String userEmailGuest) {
		this.userEmailGuest = userEmailGuest;
	}
}
