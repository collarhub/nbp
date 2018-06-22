package com.nbp.simsns.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nbp.simsns.dao.PostDAO;
import com.nbp.simsns.vo.PostVO;
import com.nbp.simsns.vo.UserVO;

@Controller
public class MainTestController {
	
	@Autowired
	private PostDAO postDAO;
	
	@RequestMapping(value = "/getPost", method = RequestMethod.GET)
	@ResponseBody
	public List<PostVO> getPost() {
		UserVO user = new UserVO();
		user.setUserEmail("test4");
		List<PostVO> list = postDAO.getAllPost(user); 
		return list;
	}
	
	@RequestMapping(value = "/mainTest", method = RequestMethod.GET)
	public String mainTest() {
		return "mainTest";
	}
}
