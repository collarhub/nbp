package com.nbp.simsns.serviceinterface;

import org.springframework.validation.Errors;

public interface UserServiceInter {
	public void signupValidate(Object object, Errors errors);
}
