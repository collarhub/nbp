package com.nbp.simsns.etc;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

public class SignupValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void validate(Object object, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userEmail", "required", "필수입력 사항입니다.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userName", "required", "필수입력 사항입니다.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userPhone", "required", "필수입력 사항입니다.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userAddress", "required", "필수입력 사항입니다.");
	}
	
}
