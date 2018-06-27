package com.nbp.simsns.etc;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;


public class WritePictureCommitValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void validate(Object object, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pictureTitle", "required", "제목을 입력하세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "picturePath", "required", "사진을 등록하세요.");
	}
	
}
