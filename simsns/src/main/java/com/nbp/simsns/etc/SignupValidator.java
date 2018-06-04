package com.nbp.simsns.etc;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.nbp.simsns.dao.UserDAO;
import com.nbp.simsns.vo.UserVO;

public class SignupValidator implements Validator {
	
	@Autowired
	private UserDAO userDAO;

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void validate(Object object, Errors errors) {
		UserVO user = (UserVO)object;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userEmail", "required", "필수입력 사항입니다.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userPassword", "required", "필수입력 사항입니다.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userPasswordConfirm", "required", "필수입력 사항입니다.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userName", "required", "필수입력 사항입니다.");
        
        if(!userDAO.selectUser(user.getUserEmail()).isEmpty()) {
        	errors.rejectValue("userEmail", "select", "이미 가입된 이메일입니다.");
        }
        
        Pattern passwordPatter = Pattern.compile("[\\w\\~\\-\\.]+@[\\w\\~\\-]+(\\.[\\w\\~\\-]+)+");
        Matcher passowrdMatcher = passwordPatter.matcher(user.getUserEmail());
        if(!passowrdMatcher.find()) {
        	errors.rejectValue("userEmail", "select", "잘못된 이메일 형식입니다.");
        }
        
        passwordPatter = Pattern.compile("([a-zA-Z].*[0-9].*[!,@,#,$,%,^,&,*,?,_,~])"
        		+ "|([a-zA-Z].*[!,@,#,$,%,^,&,*,?,_,~].*[0-9])"
        		+ "|([0-9].*[a-zA-Z].*[!,@,#,$,%,^,&,*,?,_,~])"
        		+ "|([0-9].*[!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z])"
        		+ "|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z].*[0-9])"
        		+ "|([!,@,#,$,%,^,&,*,?,_,~].*[0-9].*[a-zA-Z])");
        passowrdMatcher = passwordPatter.matcher(user.getUserPassword());
        if(!passowrdMatcher.find() || user.getUserPassword().length() < 8 || user.getUserPassword().length() > 20) {
        	errors.rejectValue("userPassword", "select", "비밀번호는 영문 대소문자, 숫자, 특수문자를 혼합하여 8자리 이상 20자리 이하로 입력해주세요.");
        }
        
        if(!user.getUserPassword().equals(user.getUserPasswordConfirm())) {
        	errors.rejectValue("userPasswordConfirm", "select", "비밀번호가 일치하지 않습니다.");
        }
	}
	
}
