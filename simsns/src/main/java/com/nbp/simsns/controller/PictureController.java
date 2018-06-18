package com.nbp.simsns.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.nbp.simsns.serviceimpl.CommentServiceImpl;
import com.nbp.simsns.serviceimpl.LikeServiceImpl;
import com.nbp.simsns.serviceimpl.PictureServiceImpl;
import com.nbp.simsns.serviceimpl.PostServiceImpl;
import com.nbp.simsns.vo.PictureVO;
import com.nbp.simsns.vo.UserVO;

@Controller
public class PictureController {
	@Autowired
	private PictureServiceImpl pictureService;
	@Autowired
	private PostServiceImpl postService;
	@Autowired
	private CommentServiceImpl commentService;
	@Autowired
	private LikeServiceImpl likeService;
	
	@RequestMapping(value = "/picture", method = RequestMethod.POST)
	public String picture(@ModelAttribute PictureVO pictureVO, Locale locale, Model model) {
		UserVO user = new UserVO();
		user.setUserEmail(pictureVO.getUserEmailHost());
		model.addAttribute("id", pictureVO.getUserEmailHost());
		model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPicture(user)));
		return "pictureForm";
	}
	
	@RequestMapping(value = "/goToPost", method = RequestMethod.POST)
	public String goToPost(@ModelAttribute PictureVO pictureVO, Model model, HttpSession session) {
		UserVO user = new UserVO();
		if(session.getAttribute("userID") == null) {
			return "mainBoard";
		} else {
			user.setUserEmail(session.getAttribute("userID").toString());
			model.addAttribute("postList", new Gson().toJson(postService.getAllPost(user)));
			model.addAttribute("commentList", new Gson().toJson(commentService.getAllComment(user)));
			model.addAttribute("likeList", new Gson().toJson(likeService.getAllLike(user)));
			model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPicture(user)));
			model.addAttribute("id", session.getAttribute("userID"));
			return "mainBoard";
		}
	}
	
	@RequestMapping(value = "/postPicture", method = RequestMethod.POST)
	public String postPicture(@ModelAttribute PictureVO pictureVO, Locale locale, Model model) {
		UserVO user = new UserVO();
		user.setUserEmail(pictureVO.getUserEmailHost());
		model.addAttribute("id", pictureVO.getUserEmailHost());
		model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPostPicture(user)));
		return "postPictureForm";
	}
	
	@RequestMapping(value = "/writePicture", method = RequestMethod.POST)
	public String writePicture(@ModelAttribute PictureVO pictureVO, Locale locale, Model model, HttpServletRequest request) {
		model.addAttribute("writePictureCancel", request.getParameter("writePictureCancel"));
		model.addAttribute("id", pictureVO.getUserEmailHost());
		return "writePictureForm";
	}
	
	@RequestMapping(value = "/writePictureCommit", method = RequestMethod.POST)
	public String writePictureCommit(@ModelAttribute PictureVO pictureVO, Model model, BindingResult result, HttpSession session,
			@RequestPart(required=true)List<MultipartFile> fileUpload, HttpServletRequest request) {
		final String ROOT_PATH = request.getSession().getServletContext().getRealPath("/");
		pictureVO.setUserEmailGuest(session.getAttribute("userID").toString());
		pictureService.writePictureCommit(pictureVO, fileUpload.get(0), result, ROOT_PATH);
		if(!result.hasErrors()) {
			UserVO userVO = new UserVO();
			userVO.setUserEmail(pictureVO.getUserEmailHost());
			model.addAttribute("id", pictureVO.getUserEmailHost());
			model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPicturePicture(userVO)));
			return "picturePictureForm";
		} else {
			model.addAttribute("id", pictureVO.getUserEmailHost());
			model.addAttribute("writePictureCancel", request.getParameter("writePictureCancel"));
			return "writePictureForm";
		}
	}
	
	@RequestMapping(value = "/picturePicture", method = RequestMethod.POST)
	public String picturePicture(@ModelAttribute PictureVO pictureVO, Locale locale, Model model) {
		UserVO user = new UserVO();
		user.setUserEmail(pictureVO.getUserEmailHost());
		model.addAttribute("id", pictureVO.getUserEmailHost());
		model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPicturePicture(user)));
		return "picturePictureForm";
	}
}
