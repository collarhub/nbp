package com.nbp.simsns.controller;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String login(HttpServletResponse response) {
		response.setHeader("Cache-Control","no-store");
		return "loginForm";
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signup(HttpServletResponse response) {
		response.setHeader("Cache-Control","no-store");
		return "signupForm";
	}
	
	@RequestMapping(value = "/signupValidate", method = RequestMethod.GET)
	public String signupValidate() {
		return "notAccessible";
	}
	
	@RequestMapping(value = "/loginValidate", method = RequestMethod.GET)
	public String loginValidate() {
		return "notAccessible";
	}
	
}
