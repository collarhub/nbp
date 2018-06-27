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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.nbp.simsns.serviceimpl.UserServiceImpl;
import com.nbp.simsns.vo.UserVO;

@Controller
public class UserController {
	@Autowired
	private UserServiceImpl userService;
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@RequestMapping(value = "/signupValidate", method = RequestMethod.POST)
	public String signupValidate(@ModelAttribute UserVO user, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
		userService.signupValidate(user, result);
		if(result.hasErrors()) {
			model.addAttribute("isSignupSuccess", "false");
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.userVO", result);
		    redirectAttributes.addFlashAttribute("userVO", user);
			return "redirect:/signup";
		} else {
			redirectAttributes.addFlashAttribute("isSignupSuccess", "true");
			return "redirect:/";
		}
	}
	
	@RequestMapping(value = "/loginValidate", method = RequestMethod.POST)
	public String loginValidate(@ModelAttribute UserVO user, final BindingResult result,
			Model model, HttpSession session, RedirectAttributes redirectAttributes) {
		userService.loginValidate(user, result);
		if(result.hasErrors()) {
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.userVO", result);
		    redirectAttributes.addFlashAttribute("userVO", user);
			return "redirect:/";
		} else {
			String id = user.getUserEmail();
			String name = userService.selectUser(user.getUserEmail()).get(0).getUserName();
			session.setAttribute("userID", id);
			session.setAttribute("userName", name);
			session.setAttribute("hostID", id);
			session.setAttribute("hostName", name);
			return "redirect:/board";
		}
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		if(session.getAttribute("userID") == null) {
			return "notAccessible";
		} else {
			session.invalidate();
			return "redirect:/";
		}
	}
}
