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
	public String writeComment(Model model, @ModelAttribute CommentVO comment,
									BindingResult result, HttpSession session, RedirectAttributes redirectAttributes) {
		comment.setUserEmailHost(session.getAttribute("hostID").toString());
		comment.setUserEmailGuest(session.getAttribute("userID").toString());
		comment.setUserNameGuest(session.getAttribute("userName").toString());
		commentService.writeComment(comment, result);
		if(!result.hasErrors()) {
			redirectAttributes.addFlashAttribute("goToPostTimestamp", comment.getPostTimestamp());
			redirectAttributes.addFlashAttribute("goToPostNo", comment.getPostNo());
			return "redirect:/board";
		} else {
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.commentVO", result);
			redirectAttributes.addFlashAttribute("comment", comment);
			redirectAttributes.addFlashAttribute("goToPostTimestamp", comment.getPostTimestamp());
			redirectAttributes.addFlashAttribute("goToPostNo", comment.getPostNo());
			return "redirect:/board";
		}
	}
	
	@RequestMapping(value = "/deleteComment", method = RequestMethod.POST)
	public String deleteComment(@ModelAttribute CommentVO comment, HttpSession session, Model model) {
		comment.setUserEmailHost(session.getAttribute("hostID").toString());
		comment.setUserEmailGuest(session.getAttribute("userID").toString());
		comment.setUserNameGuest(session.getAttribute("userName").toString());
		commentService.deleteComment(comment);
		return "redirect:/board";
	}
	
	@RequestMapping(value = "/updateComment", method = RequestMethod.POST)
	public String updateComment(@ModelAttribute CommentVO comment, HttpSession session, BindingResult result, RedirectAttributes redirectAttributes) {
		comment.setUserEmailHost(session.getAttribute("hostID").toString());
		comment.setUserEmailGuest(session.getAttribute("userID").toString());
		comment.setUserNameGuest(session.getAttribute("userName").toString());
		commentService.updateComment(comment, result);
		if(!result.hasErrors()) {
			redirectAttributes.addFlashAttribute("goToPostTimestamp", comment.getPostTimestamp());
			redirectAttributes.addFlashAttribute("goToPostNo", comment.getPostNo());
			return "redirect:/board";
		} else {
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.commentVO", result);
			redirectAttributes.addFlashAttribute("comment", comment);
			redirectAttributes.addFlashAttribute("goToPostTimestamp", comment.getPostTimestamp());
			redirectAttributes.addFlashAttribute("goToPostNo", comment.getPostNo());
			redirectAttributes.addFlashAttribute("commentUpdateError", "true");
			return "redirect:/board";
		}
	}
}
