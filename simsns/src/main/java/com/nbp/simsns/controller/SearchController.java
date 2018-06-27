package com.nbp.simsns.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nbp.simsns.serviceimpl.SearchServiceImpl;
import com.nbp.simsns.vo.SearchResultVO;

@Controller
public class SearchController {
	@Autowired
	private SearchServiceImpl searchService;
	
	@ResponseBody
	@RequestMapping(value = "/searchPost", method = RequestMethod.GET)
	public SearchResultVO searchPost(@RequestParam("searchRange") String searchRange,
			@RequestParam("searchKeyword") String searchKeyword, @RequestParam("searchIndex") int searchIndex,
			HttpSession session) {
		return searchService.searchPost(searchRange, searchKeyword, searchIndex, session.getAttribute("hostID").toString());
	}
	
	@ResponseBody
	@RequestMapping(value = "/searchComment", method = RequestMethod.GET)
	public SearchResultVO searchComment(@RequestParam("searchRange") String searchRange,
			@RequestParam("searchKeyword") String searchKeyword, @RequestParam("searchIndex") int searchIndex,
			HttpSession session) {
		return searchService.searchComment(searchRange, searchKeyword, searchIndex, session.getAttribute("hostID").toString());
	}
}
