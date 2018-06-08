package com.nbp.simsns.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;

import com.nbp.simsns.dao.UserDAO;
import com.nbp.simsns.etc.LoginValidator;
import com.nbp.simsns.etc.SignupValidator;
import com.nbp.simsns.serviceinterface.UserServiceInter;
import com.nbp.simsns.vo.UserVO;

@Service("userService")
public class UserServiceImpl implements UserServiceInter {
	
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private SignupValidator signupValidator;
	@Autowired
	private LoginValidator loginValidator;

	@Override
	public void signupValidate(Object object, Errors errors) {
		UserVO user = (UserVO)object;
		signupValidator.validate(object, errors);
		if(!errors.hasErrors()) {
			userDAO.insertUser(user);
		}
	}

	@Override
	public void loginValidate(Object object, Errors errors) {
		loginValidator.validate(object, errors);
	}

	@Override
	public List<UserVO> selectUser(String userEmail) {
		UserVO user = new UserVO();
		user.setUserEmail(userEmail);
		return userDAO.selectUser(user);
	}
}
