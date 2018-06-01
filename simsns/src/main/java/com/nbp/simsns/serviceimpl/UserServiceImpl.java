package com.nbp.simsns.serviceimpl;

import org.springframework.stereotype.Service;

import com.nbp.simsns.serviceinterface.UserServiceInter;
import com.nbp.simsns.vo.UserVO;

@Service("userService")
public class UserServiceImpl implements UserServiceInter {

	@Override
	public boolean signupValidate(UserVO user) {
		if(user.getUserEmail().equals("1")) {
			return true;
		} else {
			return false;
		}
	}
	
}
