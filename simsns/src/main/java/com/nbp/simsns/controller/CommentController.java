package com.nbp.simsns.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
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
import com.nbp.simsns.vo.CommentVO;
import com.nbp.simsns.vo.UserVO;

@Controller
public class CommentController {
	@Autowired
	private CommentServiceImpl commentService;
	@Autowired
	private PostServiceImpl postService;
	@Autowired
	private LikeServiceImpl likeService;
	@Autowired
	private PictureServiceImpl pictureService;
	
	private static final Logger logger = LoggerFactory.getLogger(CommentController.class);

	@RequestMapping(value = "/writeComment", method = RequestMethod.POST)
	public String writeComment(Locale locale, Model model, @ModelAttribute CommentVO commentVO,
									BindingResult result, HttpSession session, HttpServletRequest request) {
		commentVO.setUserEmailGuest(session.getAttribute("userID").toString());
		commentService.writeComment(commentVO, result);
		if(!result.hasErrors()) {
			UserVO userVO = new UserVO();
			userVO.setUserEmail(commentVO.getUserEmailHost());
			model.addAttribute("id", commentVO.getUserEmailHost());
			model.addAttribute("postList", new Gson().toJson(postService.getAllPost(userVO)));
			model.addAttribute("commentList", new Gson().toJson(commentService.getAllComment(userVO)));
			model.addAttribute("likeList", new Gson().toJson(likeService.getAllLike(userVO)));
			model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPicture(userVO)));
			return "mainBoard";
		} else {
			UserVO userVO = new UserVO();
			userVO.setUserEmail(commentVO.getUserEmailHost());
			model.addAttribute("id", commentVO.getUserEmailHost());
			model.addAttribute("postList", new Gson().toJson(postService.getAllPost(userVO)));
			model.addAttribute("commentList", new Gson().toJson(commentService.getAllComment(userVO)));
			model.addAttribute("likeList", new Gson().toJson(likeService.getAllLike(userVO)));
			model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPicture(userVO)));
			return "mainBoard";
		}
	}
	
	@RequestMapping(value = "/deleteComment", method = RequestMethod.POST)
	public String deleteComment(@ModelAttribute CommentVO commentVO, HttpSession session, Model model) {
		commentVO.setUserEmailGuest(session.getAttribute("userID").toString());
		commentService.deleteComment(commentVO);
		UserVO userVO = new UserVO();
		userVO.setUserEmail(commentVO.getUserEmailHost());
		model.addAttribute("id", commentVO.getUserEmailHost());
		model.addAttribute("postList", new Gson().toJson(postService.getAllPost(userVO)));
		model.addAttribute("commentList", new Gson().toJson(commentService.getAllComment(userVO)));
		model.addAttribute("likeList", new Gson().toJson(likeService.getAllLike(userVO)));
		model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPicture(userVO)));
		return "mainBoard";
	}
	
	@RequestMapping(value = "/updateComment", method = RequestMethod.POST)
	public String updateComment(@ModelAttribute CommentVO commentVO, HttpSession session, Model model, BindingResult result) {
		commentVO.setUserEmailGuest(session.getAttribute("userID").toString());
		commentService.updateComment(commentVO, result);
		if(!result.hasErrors()) {
			UserVO userVO = new UserVO();
			userVO.setUserEmail(commentVO.getUserEmailHost());
			model.addAttribute("id", commentVO.getUserEmailHost());
			model.addAttribute("postList", new Gson().toJson(postService.getAllPost(userVO)));
			model.addAttribute("commentList", new Gson().toJson(commentService.getAllComment(userVO)));
			model.addAttribute("likeList", new Gson().toJson(likeService.getAllLike(userVO)));
			model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPicture(userVO)));
			return "mainBoard";
		} else {
			UserVO userVO = new UserVO();
			userVO.setUserEmail(commentVO.getUserEmailHost());
			model.addAttribute("id", commentVO.getUserEmailHost());
			model.addAttribute("postList", new Gson().toJson(postService.getAllPost(userVO)));
			model.addAttribute("commentList", new Gson().toJson(commentService.getAllComment(userVO)));
			model.addAttribute("likeList", new Gson().toJson(likeService.getAllLike(userVO)));
			model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPicture(userVO)));
			return "mainBoard";
		}
	}
}
