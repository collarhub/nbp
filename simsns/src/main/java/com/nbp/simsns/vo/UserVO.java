package com.nbp.simsns.vo;

public class UserVO {
	private String userEmail;
	private String userPassword;
	private String userPasswordConfirm;
	private String userName;
	private String userPhone;
	private String userAddress;
	
	public UserVO() {}
	
	public UserVO(String userEmail, String userPassword, String userPasswordConfirm, String userName, String userPhone, String userAddress) {
		super();
		this.userEmail = userEmail;
		this.userPassword = userPassword;
		this.userPasswordConfirm = userPasswordConfirm;
		this.userName = userName;
		this.userPhone = userPhone;
		this.userAddress = userAddress;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	
	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getUserPasswordConfirm() {
		return userPasswordConfirm;
	}

	public void setUserPasswordConfirm(String userPasswordConfirm) {
		this.userPasswordConfirm = userPasswordConfirm;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getUserAddress() {
		return userAddress;
	}

	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}
	
}
