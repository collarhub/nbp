package com.nbp.simsns.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nbp.simsns.serviceimpl.UserServiceImpl;
import com.nbp.simsns.vo.UserVO;

@Controller
public class UserController {
	@Autowired
	private UserServiceImpl userService;
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@RequestMapping(value = "/signupValidate", method = RequestMethod.POST)
	public String signupValidate(@ModelAttribute UserVO user, BindingResult result, Model model) {
		userService.signupValidate(user, result);
		
		if(result.hasErrors()) {
			model.addAttribute("isSignupSuccess", "false");
			return "signupForm";
		} else {
			model.addAttribute("isSignupSuccess", "true");
			return "loginForm";
		}
	}
	
	@RequestMapping(value = "/loginValidate", method = RequestMethod.POST)
	public String loginValidate(@ModelAttribute UserVO user, BindingResult result, Model model, HttpSession session) {
		userService.loginValidate(user, result);
		if(result.hasErrors()) {
			return "loginForm";
		} else {
			session.setAttribute("userID", user.getUserEmail());
			return "mainBoard";
		}
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		if(session.getAttribute("userID") == null) {
			return "notAccessible";
		} else {
			session.invalidate();
			return "loginForm";
		}
	}
}
