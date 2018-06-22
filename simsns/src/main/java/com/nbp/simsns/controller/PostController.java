package com.nbp.simsns.controller;

import java.util.List;
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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.nbp.simsns.serviceimpl.CommentServiceImpl;
import com.nbp.simsns.serviceimpl.LikeServiceImpl;
import com.nbp.simsns.serviceimpl.PictureServiceImpl;
import com.nbp.simsns.serviceimpl.PostServiceImpl;
import com.nbp.simsns.serviceimpl.UserServiceImpl;
import com.nbp.simsns.vo.PictureVO;
import com.nbp.simsns.vo.PostVO;
import com.nbp.simsns.vo.UserVO;

@Controller
public class PostController {
	@Autowired
	private PostServiceImpl postService;
	@Autowired
	private UserServiceImpl userService;
	@Autowired
	private CommentServiceImpl commentService;
	@Autowired
	private LikeServiceImpl likeService;
	@Autowired
	private PictureServiceImpl pictureService;
	private static final Logger logger = LoggerFactory.getLogger(PostController.class);
	
	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public String mainBoardGet(Locale locale, Model model, HttpSession session, HttpServletRequest request) {
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
	
	@RequestMapping(value = "/board", method = RequestMethod.POST)
	public String mainBoard(@ModelAttribute PostVO postVO, @ModelAttribute PictureVO pictureVO, Locale locale, Model model, HttpSession session, HttpServletRequest request) {
		UserVO userVO = new UserVO();
		userVO.setUserEmail(postVO.getUserEmailHost());
		if(session.getAttribute("userID") == null) {
			return "mainBoard";
		} else {
			model.addAttribute("postList", new Gson().toJson(postService.getAllPost(userVO)));
			model.addAttribute("commentList", new Gson().toJson(commentService.getAllComment(userVO)));
			model.addAttribute("likeList", new Gson().toJson(likeService.getAllLike(userVO)));
			model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPicture(userVO)));
			model.addAttribute("id", userVO.getUserEmail());
			return "mainBoard";
		}
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String write(@ModelAttribute PostVO postVO, Locale locale, Model model) {
		model.addAttribute("id", postVO.getUserEmailHost());
		return "writeForm";
	}
	
	@RequestMapping(value = "/writeCommit", method = RequestMethod.POST)
	public String writeCommit(@ModelAttribute PostVO postVO, @RequestPart(required=true)List<MultipartFile> fileUpload,
			 BindingResult result, HttpSession session, Model model, HttpServletRequest request) {
		final String ROOT_PATH = request.getSession().getServletContext().getRealPath("/");
		postVO.setUserEmailGuest(session.getAttribute("userID").toString());
		postService.writeCommit(postVO, fileUpload.get(0), result, ROOT_PATH);
		if(!result.hasErrors()) {
			UserVO userVO = new UserVO();
			userVO.setUserEmail(postVO.getUserEmailHost());
			model.addAttribute("id", postVO.getUserEmailHost());
			model.addAttribute("postList", new Gson().toJson(postService.getAllPost(userVO)));
			model.addAttribute("commentList", new Gson().toJson(commentService.getAllComment(userVO)));
			model.addAttribute("likeList", new Gson().toJson(likeService.getAllLike(userVO)));
			model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPicture(userVO)));
			return "mainBoard";
		} else {
			model.addAttribute("id", postVO.getUserEmailHost());
			return "writeForm";
		}
	}
	
	@RequestMapping(value = "/deletePost", method = RequestMethod.POST)
	public String deletePost(@ModelAttribute PostVO postVO, BindingResult result,
			HttpSession session, Model model, HttpServletRequest request) {
		final String ROOT_PATH = request.getSession().getServletContext().getRealPath("/");
		postVO.setUserEmailGuest(session.getAttribute("userID").toString());
		postService.deletePost(postVO, ROOT_PATH);
		UserVO userVO = new UserVO();
		userVO.setUserEmail(postVO.getUserEmailHost());
		model.addAttribute("id", postVO.getUserEmailHost());
		model.addAttribute("postList", new Gson().toJson(postService.getAllPost(userVO)));
		model.addAttribute("commentList", new Gson().toJson(commentService.getAllComment(userVO)));
		model.addAttribute("likeList", new Gson().toJson(likeService.getAllLike(userVO)));
		model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPicture(userVO)));
		return "mainBoard";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(@ModelAttribute PostVO postVO, BindingResult result, HttpSession session, Model model) {
		postVO.setUserEmailGuest(session.getAttribute("userID").toString());
		PostVO tmpPost = postService.selectPost(postVO);
		postVO.setPostTitle(tmpPost.getPostTitle());
		postVO.setPostContent(tmpPost.getPostContent());
		PictureVO picture = pictureService.getPicture(postVO);
		if(picture != null) {
			model.addAttribute("picture", "resources/picture/" + picture.getPicturePath());
		} else {
			model.addAttribute("picture", "");
		}
		return "updateForm";
	}
	
	@RequestMapping(value = "/updateCommit", method = RequestMethod.POST)
	public String updateCommit(@ModelAttribute PostVO postVO, @RequestPart(required=true)List<MultipartFile> fileUpload,
			 BindingResult result, HttpSession session, Model model, HttpServletRequest request) {
		String deleted = request.getParameter("deleted");
		final String ROOT_PATH = request.getSession().getServletContext().getRealPath("/");
		postVO.setUserEmailGuest(session.getAttribute("userID").toString());
		postService.updateCommit(postVO, fileUpload.get(0), result, ROOT_PATH, deleted);
		if(!result.hasErrors()) {
			UserVO userVO = new UserVO();
			userVO.setUserEmail(postVO.getUserEmailHost());
			model.addAttribute("id", postVO.getUserEmailHost());
			model.addAttribute("postList", new Gson().toJson(postService.getAllPost(userVO)));
			model.addAttribute("commentList", new Gson().toJson(commentService.getAllComment(userVO)));
			model.addAttribute("likeList", new Gson().toJson(likeService.getAllLike(userVO)));
			model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPicture(userVO)));
			return "mainBoard";
		} else {
			PictureVO picture = pictureService.getPicture(postVO);
			if(picture != null) {
				model.addAttribute("picture", "resources/picture/" + picture.getPicturePath());
			} else {
				model.addAttribute("picture", "");
			}
			model.addAttribute("id", postVO.getUserEmailHost());
			return "updateForm";
		}
	}
}
