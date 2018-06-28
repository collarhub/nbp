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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.nbp.simsns.serviceimpl.PictureServiceImpl;
import com.nbp.simsns.vo.PictureVO;
import com.nbp.simsns.vo.UserVO;

@Controller
public class PictureController {
	@Autowired
	private PictureServiceImpl pictureService;
	
	@RequestMapping(value = "/picture", method = RequestMethod.GET)
	public String pictureGet() {
		return "pictureForm";
	}
	
	@ResponseBody
	@RequestMapping(value = "/postPicturePreview", method = RequestMethod.GET)
	public List<PictureVO> postPicturePreview(@ModelAttribute PictureVO picture, HttpSession session) {
		picture.setUserEmailHost(session.getAttribute("hostID").toString());
		picture.setUserEmailGuest(session.getAttribute("userID").toString());
		picture.setUserNameGuest(session.getAttribute("userName").toString());
		return pictureService.getPostPicturePreview(picture);
	}
	
	@ResponseBody
	@RequestMapping(value = "/picturePicturePreview", method = RequestMethod.GET)
	public List<PictureVO> picturePicturePreview(@ModelAttribute PictureVO picture, HttpSession session) {
		picture.setUserEmailHost(session.getAttribute("hostID").toString());
		picture.setUserEmailGuest(session.getAttribute("userID").toString());
		picture.setUserNameGuest(session.getAttribute("userName").toString());
		return pictureService.getPicturePicturePreview(picture);
	}
	
	@RequestMapping(value = "/goToPost", method = RequestMethod.POST)
	public String goToPost(@ModelAttribute PictureVO picture, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("goToPostTimestamp", picture.getPostTimestamp());
		redirectAttributes.addFlashAttribute("goToPostNo", picture.getPostNo());
		return "redirect:/board";
	}
	
	@RequestMapping(value = "/picture", method = RequestMethod.POST)
	public String picture(@ModelAttribute PictureVO picture, Locale locale, Model model) {
		UserVO user = new UserVO();
		user.setUserEmail(picture.getUserEmailHost());
		model.addAttribute("id", picture.getUserEmailHost());
		model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPicture(user)));
		return "pictureForm";
	}
	
	@RequestMapping(value = "/postPicture", method = RequestMethod.GET)
	public String postPicture(Model model, HttpSession session) {
		UserVO user = new UserVO();
		user.setUserEmail(session.getAttribute("hostID").toString());
		model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPostPicture(user)));
		return "postPictureForm";
	}
	
	@RequestMapping(value = "/writePicture", method = RequestMethod.GET)
	public String writePicture() {
		return "writePictureForm";
	}
	
	@RequestMapping(value = "/writePictureCommit", method = RequestMethod.POST)
	public String writePictureCommit(@ModelAttribute PictureVO picture, BindingResult result, HttpSession session,
			@RequestPart(required=true)List<MultipartFile> fileUpload, HttpServletRequest request, @RequestParam("back") String back,
			RedirectAttributes redirectAttributes) {
		/*final String ROOT_PATH = request.getSession().getServletContext().getRealPath("/");*/
		final String ROOT_PATH = "/home1/irteam/resources/picture";
		picture.setUserEmailGuest(session.getAttribute("userID").toString());
		picture.setUserNameGuest(session.getAttribute("userName").toString());
		picture.setUserEmailHost(session.getAttribute("hostID").toString());
		pictureService.writePictureCommit(picture, fileUpload.get(0), result, ROOT_PATH);
		if(!result.hasErrors()) {
			return "redirect:/picturePicture";
		} else {
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.pictureVO", result);
			return "redirect:/writePicture?back=" + back;
		}
	}
	
	@RequestMapping(value = "/picturePicture", method = RequestMethod.GET)
	public String picturePicture(HttpSession session, Model model) {
		UserVO user = new UserVO();
		user.setUserEmail(session.getAttribute("hostID").toString());
		model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPicturePicture(user)));
		return "picturePictureForm";
	}
	
	@RequestMapping(value = "/deletePicture", method = RequestMethod.POST)
	public String deletePicture(@ModelAttribute PictureVO picture,
			HttpSession session, HttpServletRequest request) {
		/*final String ROOT_PATH = request.getSession().getServletContext().getRealPath("/");*/
		final String ROOT_PATH = "/home1/irteam/resources/picture";
		picture.setUserEmailGuest(session.getAttribute("userID").toString());
		picture.setUserNameGuest(session.getAttribute("userName").toString());
		picture.setUserEmailHost(session.getAttribute("hostID").toString());
		pictureService.deletePicture(picture, ROOT_PATH);
		return "redirect:/picturePicture";
	}
	
	@RequestMapping(value = "/updatePicture", method = RequestMethod.GET)
	public String updatePicture(@ModelAttribute PictureVO picture, BindingResult result, HttpSession session) {
		picture.setUserEmailHost(session.getAttribute("hostID").toString());
		pictureService.updatePathValidate(picture, session.getAttribute("userID").toString(), result);
		if(!result.hasErrors()) {
			return "updatePictureForm";
		} else {
			return "notAccessible";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/getPicture", method = RequestMethod.GET)
	public PictureVO updatePicture(@ModelAttribute PictureVO picture, HttpSession session) {
		picture.setUserEmailHost(session.getAttribute("hostID").toString());
		return pictureService.selectPicture(picture);
	}
	
	@RequestMapping(value = "/updatePictureCommit", method = RequestMethod.POST)
	public String updatePictureCommit(@ModelAttribute PictureVO picture, @RequestPart(required=true)List<MultipartFile> fileUpload,
			 BindingResult result, HttpSession session, HttpServletRequest request, @RequestParam("deleted") String deleted,
			 RedirectAttributes redirectAttributes) {
		/*final String ROOT_PATH = request.getSession().getServletContext().getRealPath("/");*/
		final String ROOT_PATH = "/home1/irteam/resources/picture";
		picture.setUserEmailGuest(session.getAttribute("userID").toString());
		picture.setUserNameGuest(session.getAttribute("userName").toString());
		picture.setUserEmailHost(session.getAttribute("hostID").toString());
		pictureService.updatePictureCommit(picture, fileUpload.get(0), result, ROOT_PATH, deleted);
		if(!result.hasErrors()) {
			return "redirect:/picturePicture";
		} else {
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.pictureVO", result);
			return "redirect:/updatePicture";
		}
	}
}
