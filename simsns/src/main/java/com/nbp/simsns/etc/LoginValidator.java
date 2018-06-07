package com.nbp.simsns.etc;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.nbp.simsns.dao.UserDAO;
import com.nbp.simsns.vo.UserVO;

public class LoginValidator implements Validator {
	
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
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userEmail", "required", "아이디를 입력하세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userPassword", "required", "비밀번호를 입력하세요.");
		List<UserVO> outputs = userDAO.selectUser(user);
		if(outputs.isEmpty() || user.getUserPassword().equals("")
				|| !outputs.get(0).getUserPassword().equals(userDAO.getHash(user.getUserPassword()))) {
			errors.rejectValue("userPasswordConfirm", "select", "아이디 또는 비밀번호를 확인해주세요.");
		}
	}

}
