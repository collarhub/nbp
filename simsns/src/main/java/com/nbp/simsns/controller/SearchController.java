package com.nbp.simsns.controller;

import java.util.HashMap;
import java.util.List;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.nbp.simsns.serviceimpl.CommentServiceImpl;
import com.nbp.simsns.serviceimpl.LikeServiceImpl;
import com.nbp.simsns.serviceimpl.PictureServiceImpl;
import com.nbp.simsns.serviceimpl.PostServiceImpl;
import com.nbp.simsns.serviceimpl.SearchServiceImpl;
import com.nbp.simsns.vo.CommentVO;
import com.nbp.simsns.vo.PostVO;
import com.nbp.simsns.vo.SearchResultVO;
import com.nbp.simsns.vo.SearchVO;
import com.nbp.simsns.vo.UserVO;

@Controller
public class SearchController {
	@Autowired
	private SearchServiceImpl searchService;
	@Autowired
	private PostServiceImpl postService;
	@Autowired
	private CommentServiceImpl commentService;
	@Autowired
	private LikeServiceImpl likeService;
	@Autowired
	private PictureServiceImpl pictureService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/searchBoard", method = RequestMethod.POST)
	public String searchBoard(@ModelAttribute SearchVO searchVO, HttpSession session, Model model, BindingResult result,
							HttpServletRequest request) {
		HashMap<String, Object> boardResult = searchService.searchBoard(searchVO, result);
		if(!result.hasErrors()) {
			model.addAttribute("postList", new Gson().toJson((List<PostVO>)boardResult.get("postList")));
			model.addAttribute("commentList", new Gson().toJson((List<CommentVO>)boardResult.get("commentList")));
			return "postSearchResultForm";
		} else {
			UserVO userVO = new UserVO();
			userVO.setUserEmail(searchVO.getUserEmailHost());
			model.addAttribute("id", searchVO.getUserEmailHost());
			model.addAttribute("postList", new Gson().toJson(postService.getAllPost(userVO)));
			model.addAttribute("commentList", new Gson().toJson(commentService.getAllComment(userVO)));
			model.addAttribute("likeList", new Gson().toJson(likeService.getAllLike(userVO)));
			model.addAttribute("pictureList", new Gson().toJson(pictureService.getAllPicture(userVO)));
			return "mainBoard";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/searchPost", method = RequestMethod.GET)
	public SearchResultVO searchPost(@RequestParam("searchRange") String searchRange,
			@RequestParam("searchKeyword") String searchKeyword, @RequestParam("searchIndex") int searchIndex,
			@RequestParam("userEmailHost") String userEmailHost) {
		return searchService.searchPost(searchRange, searchKeyword, searchIndex, userEmailHost);
	}
	
	@ResponseBody
	@RequestMapping(value = "/searchComment", method = RequestMethod.GET)
	public SearchResultVO searchComment(@RequestParam("searchRange") String searchRange,
			@RequestParam("searchKeyword") String searchKeyword, @RequestParam("searchIndex") int searchIndex,
			@RequestParam("userEmailHost") String userEmailHost) {
		return searchService.searchComment(searchRange, searchKeyword, searchIndex, userEmailHost);
	}
}
