package com.nbp.simsns.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.nbp.simsns.serviceimpl.PostServiceImpl;
import com.nbp.simsns.vo.PostVO;
import com.nbp.simsns.vo.UserVO;

@Controller
public class PostController {
	@Autowired
	private PostServiceImpl postService;
	private static final Logger logger = LoggerFactory.getLogger(PostController.class);

	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public String login(Locale locale, Model model, HttpSession session, HttpServletRequest request) {
		UserVO user = new UserVO();
		//user.setUserEmail(session.getAttribute("userID").toString());
		if(session.getAttribute("userID") != null) {
			if(request.getParameter("id") == null) {
				return "redirect:/board?id=" + session.getAttribute("userID").toString();
			}
			user.setUserEmail(request.getParameter("id").toString());
			model.addAttribute("postList", new Gson().toJson(postService.getAllPost(user)));
		}
		return "mainBoard";
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String write(Locale locale, Model model) {
		return "writeForm";
	}
	
	@RequestMapping(value = "/writeCommit", method = RequestMethod.POST)
	public String writeCommit(@ModelAttribute PostVO postVO, @RequestPart(required=true)List<MultipartFile> fileupload,
			 BindingResult result, HttpSession session, HttpServletRequest request) {
		postVO.setUserEmailGuest(session.getAttribute("userID").toString());
		postService.writeCommit(postVO, result);
		if(!result.hasErrors()) {
			return "redirect:/board?id=" + postVO.getUserEmailHost();
		} else {
			return "writeForm";
		}
	}
	
	@RequestMapping(value = "/deletePost", method = RequestMethod.POST)
	public String deletePost(@ModelAttribute PostVO postVO, BindingResult result, HttpSession session) {
		postVO.setUserEmailGuest(session.getAttribute("userID").toString());
		postService.deletePost(postVO);
		return "redirect:/board?id=" + postVO.getUserEmailHost();
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(@ModelAttribute PostVO postVO, BindingResult result, HttpSession session) {
		postVO.setUserEmailGuest(session.getAttribute("userID").toString());
		PostVO tmpPost = postService.selectPost(postVO);
		postVO.setPostTitle(tmpPost.getPostTitle());
		postVO.setPostContent(tmpPost.getPostContent());
		return "updateForm";
	}
	
	@RequestMapping(value = "/updateCommit", method = RequestMethod.POST)
	public String updateCommit(@ModelAttribute PostVO postVO, @RequestPart(required=true)List<MultipartFile> fileupload,
			 BindingResult result, HttpSession session) {
		postVO.setUserEmailGuest(session.getAttribute("userID").toString());
		postService.updateCommit(postVO, result);
		if(!result.hasErrors()) {
			return "redirect:/board?id=" + postVO.getUserEmailHost();
		} else {
			return "updateForm";
		}
	}
}
