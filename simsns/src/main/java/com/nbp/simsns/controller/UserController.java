package com.nbp.simsns.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nbp.simsns.dao.UserDAO;
import com.nbp.simsns.serviceimpl.UserServiceImpl;
import com.nbp.simsns.vo.UserVO;

@Controller
public class UserController {
	@Autowired
	private UserServiceImpl userService;
	@Autowired
	private UserDAO userDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@RequestMapping(value = "/signupValidate", method = RequestMethod.POST)
	public String signupValidate(@ModelAttribute UserVO user, BindingResult result, Model model) {
		userService.signupValidate(user, result);
		
		if(result.hasErrors()) {
			return "signupForm";
		} else {
			userDAO.insertUser(user);
			return "loginForm";
		}
	}
}
