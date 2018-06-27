package com.nbp.simsns.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String login(Locale locale, Model model, HttpServletResponse response) {
		response.setHeader("Cache-Control","no-store");
		return "loginForm";
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signup(Locale locale, Model model, HttpServletResponse response) {
		response.setHeader("Cache-Control","no-store");
		return "signupForm";
	}
	
	@RequestMapping(value = "/signupValidate", method = RequestMethod.GET)
	public String signupValidate(Locale locale, Model model) {
		return "notAccessible";
	}
	
	@RequestMapping(value = "/loginValidate", method = RequestMethod.GET)
	public String loginValidate(Locale locale, Model model) {
		return "notAccessible";
	}
	
}
