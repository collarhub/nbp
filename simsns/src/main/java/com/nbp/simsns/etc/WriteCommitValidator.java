package com.nbp.simsns.etc;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.nbp.simsns.vo.PostVO;

public class WriteCommitValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void validate(Object object, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "postTitle", "required", "제목을 입력하세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "postContent", "required", "내용을 입력하세요.");
	}

}
