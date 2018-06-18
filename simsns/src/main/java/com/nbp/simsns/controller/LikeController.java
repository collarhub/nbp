package com.nbp.simsns.controller;

import java.util.Locale;

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

import com.google.gson.Gson;
import com.nbp.simsns.serviceimpl.CommentServiceImpl;
import com.nbp.simsns.serviceimpl.LikeServiceImpl;
import com.nbp.simsns.serviceimpl.PictureServiceImpl;
import com.nbp.simsns.serviceimpl.PostServiceImpl;
import com.nbp.simsns.vo.LikeVO;
import com.nbp.simsns.vo.UserVO;

@Controller
public class LikeController {
	@Autowired
	private LikeServiceImpl likeService;
	@Autowired
	private PostServiceImpl postService;
	@Autowired
	private CommentServiceImpl commentService;
	@Autowired
	private PictureServiceImpl pictureService;
	private static final Logger logger = LoggerFactory.getLogger(LikeController.class);
	
	@RequestMapping(value = "/addLike", method = RequestMethod.POST)
	public String addLike(Locale locale, Model model, @ModelAttribute LikeVO likeVO, HttpSession session, BindingResult result) {
		likeVO.setUserEmailGuest(session.getAttribute("userID").toString());
		likeService.addLike(likeVO, result);
		UserVO userVO = new UserVO();
		userVO.setUserEmail(likeVO.getUserEmailHost());
		model.addAttribute("id", likeVO.getUserEmailHost());
		model.addAttribute("postList", new Gson().toJson(postService.getAllPost(userVO)));
		model.addAttribute("commentList", new Gson().toJson(commentService.getAllComment(userVO)));
		model.addAttribute("likeList", new Gson().toJson(likeService.getAllLike(userVO)));
		model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPicture(userVO)));
		return "mainBoard";
	}
}
