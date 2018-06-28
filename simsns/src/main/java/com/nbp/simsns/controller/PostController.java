package com.nbp.simsns.controller;

import java.util.HashMap;
import java.util.List;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	private CommentServiceImpl commentService;
	@Autowired
	private LikeServiceImpl likeService;
	@Autowired
	private PictureServiceImpl pictureService;
	private static final Logger logger = LoggerFactory.getLogger(PostController.class);
	
	@RequestMapping(value = "/board")
	public String mainBoardGet(Model model, HttpSession session) {
		if(session.getAttribute("userID") == null) {
			return "mainBoard";
		} else {
			UserVO user = new UserVO();
			user.setUserEmail(session.getAttribute("hostID").toString());
			model.addAttribute("postList", new Gson().toJson(postService.getAllPost(user)));
			model.addAttribute("commentList", new Gson().toJson(commentService.getAllComment(user)));
			model.addAttribute("likeList", new Gson().toJson(likeService.getAllLike(user)));
			model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPicture(user)));
			return "mainBoard";
		}
	}
	
	@RequestMapping(value = "/boardMove", method = RequestMethod.POST)
	public String boardMove(@ModelAttribute UserVO user, HttpSession session) {
		session.setAttribute("hostID", user.getUserEmail());
		session.setAttribute("hostName", user.getUserName());
		return "redirect:/board";
	}
	
	@RequestMapping(value = "/write")
	public String write(Model model, HttpServletResponse response) {
		response.setHeader("Cache-Control","no-store");
		return "writeForm";
	}
	
	@RequestMapping(value = "/writeCommit", method = RequestMethod.POST)
	public String writeCommit(@ModelAttribute PostVO post, BindingResult result, @RequestPart(required=true)List<MultipartFile> fileUpload,
			HttpSession session, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		/*final String ROOT_PATH = request.getSession().getServletContext().getRealPath("/");*/
		final String ROOT_PATH = "/home1/irteam/resources/picture";
		post.setUserEmailHost(session.getAttribute("hostID").toString());
		post.setUserEmailGuest(session.getAttribute("userID").toString());
		post.setUserNameGuest(session.getAttribute("userName").toString());
		postService.writeCommit(post, fileUpload.get(0), result, ROOT_PATH);
		System.out.println(result == null);
		if(!result.hasErrors()) {
			return "redirect:/board";
		} else {
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.postVO", result);
			redirectAttributes.addFlashAttribute("postTitle", post.getPostTitle());
			redirectAttributes.addFlashAttribute("postContent", post.getPostContent());
			return "redirect:/write";
		}
	}
	
	@RequestMapping(value = "/deletePost", method = RequestMethod.POST)
	public String deletePost(@ModelAttribute PostVO post, BindingResult result,
			HttpSession session, HttpServletRequest request) {
		/*final String ROOT_PATH = request.getSession().getServletContext().getRealPath("/");*/
		final String ROOT_PATH = "/home1/irteam/resources/picture";
		post.setUserEmailHost(session.getAttribute("hostID").toString());
		postService.deletePost(post, ROOT_PATH);
		return "redirect:/board";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String updateGet(@ModelAttribute PostVO post, BindingResult result, HttpSession session) {
		post.setUserEmailHost(session.getAttribute("hostID").toString());
		postService.updatePathValidate(post, session.getAttribute("userID").toString(), result);
		if(!result.hasErrors()) {
			return "updateForm";
		} else {
			return "notAccessible";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/getPost", method = RequestMethod.GET)
	public HashMap<String, Object> getPost(@ModelAttribute PostVO post, HttpSession session) {
		post.setUserEmailHost(session.getAttribute("hostID").toString());
		PictureVO picture = pictureService.getPicture(post);
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("post", postService.selectPost(post));
		if(picture != null) {
			result.put("picture", picture.getPicturePath());
		}
		return result;
	}
	
	@RequestMapping(value = "/updateCommit", method = RequestMethod.POST)
	public String updateCommit(@ModelAttribute PostVO post, BindingResult result, @RequestPart(required=true)List<MultipartFile> fileUpload,
			 HttpSession session, HttpServletRequest request, @RequestParam("deleted") String deleted,
			 RedirectAttributes redirectAttributes) {
		/*final String ROOT_PATH = request.getSession().getServletContext().getRealPath("/");*/
		final String ROOT_PATH = "/home1/irteam/resources/picture";
		post.setUserEmailHost(session.getAttribute("hostID").toString());
		post.setUserEmailGuest(session.getAttribute("userID").toString());
		post.setUserNameGuest(session.getAttribute("userName").toString());
		postService.updateCommit(post, fileUpload.get(0), result, ROOT_PATH, deleted);
		if(!result.hasErrors()) {
			return "redirect:/board";
		} else {
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.post", result);
			return "redirect:/update?postTimestamp=" + post.getPostTimestamp() + "&postNo=" + post.getPostNo();
		}
	}
}
