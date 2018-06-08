package com.nbp.simsns.serviceinterface;

import java.util.List;

import org.springframework.validation.Errors;

import com.nbp.simsns.vo.UserVO;

public interface UserServiceInter {
	public void signupValidate(Object object, Errors errors);
	public void loginValidate(Object object, Errors errors);
	public List<UserVO> selectUser(String userEmail);
}
