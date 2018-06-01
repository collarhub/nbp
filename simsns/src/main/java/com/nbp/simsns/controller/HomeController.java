package com.nbp.simsns.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nbp.simsns.serviceimpl.UserServiceImpl;
import com.nbp.simsns.vo.UserVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private UserServiceImpl userService;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String login(Locale locale, Model model) {
		HashMap<String, String> input = new HashMap<String, String>();
        /*input.put("user_email", "test2@test.com");
        input.put("user_name", "test2");
        input.put("user_phone", "111-111-111");
        input.put("user_address", "test2");*/
		input.put("user_phone", "111-111-111");
        List<HashMap<String, String>> outputs = sqlSession.selectList("userControlMapper.select", input); 
        //sqlSession.insert("userControlMapper.insert", input);
        for(HashMap<String, String> out : outputs) {
        	for(String key : out.keySet()) {
        		logger.info(out.get(key));
        	}
        }
		return "loginForm";
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signup(Locale locale, Model model) {
		return "signupForm";
	}
	
	@RequestMapping(value = "/signupValidate", method = RequestMethod.POST)
	public String signupValidate(UserVO user) {
		boolean result;
		result = userService.signupValidate(user);
		logger.info(user.getUserEmail() + " " + user.getUserName());
		if(result) {
			return "loginForm";
		} else {
			return "signupForm";
		}
	}
	
}
