package com.nbp.simsns.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nbp.simsns.serviceimpl.LikeServiceImpl;
import com.nbp.simsns.vo.LikeVO;

@Controller
public class LikeController {
	@Autowired
	private LikeServiceImpl likeService;
	private static final Logger logger = LoggerFactory.getLogger(LikeController.class);
	
	@ResponseBody
	@RequestMapping(value = "/addLike", method = RequestMethod.GET)
	public HashMap<String, String> addLikeGet(@ModelAttribute LikeVO likeVO, HttpSession session, BindingResult result) {
		likeVO.setUserEmailGuest(session.getAttribute("userID").toString());
		likeVO.setUserNameGuest(session.getAttribute("userName").toString());
		likeVO.setUserEmailHost(session.getAttribute("hostID").toString());
		likeService.addLike(likeVO, result);
		HashMap<String, String> data = new HashMap<String, String>();
		data.put("response", "success");
		if(!result.hasErrors()) {
			data.put("response", "success");
			return data;
		} else {
			data.put("response", "fail");
			return data;
		}
	}
}
