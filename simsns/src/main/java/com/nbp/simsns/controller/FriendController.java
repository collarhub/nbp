package com.nbp.simsns.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nbp.simsns.serviceimpl.UserServiceImpl;
import com.nbp.simsns.vo.UserVO;

@Controller
public class FriendController {
	@Autowired
	private UserServiceImpl userService;
	
	@RequestMapping(value = "/friend", method = RequestMethod.GET)
	public String frined(HttpSession session) {
		return "friendForm";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getFriend", method = RequestMethod.GET)
	public List<UserVO> getFriend(HttpSession session) {
		return userService.getAllUser();
	}
}
