package com.nbp.simsns.serviceimpl;

import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;

import com.nbp.simsns.etc.SignupValidator;
import com.nbp.simsns.serviceinterface.UserServiceInter;

@Service("userService")
public class UserServiceImpl implements UserServiceInter {

	@Override
	public void signupValidate(Object object, Errors errors) {
		new SignupValidator().validate(object, errors);
	}
	
}
