package com.nbp.simsns.serviceimpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;

import com.nbp.simsns.dao.SearchDAO;
import com.nbp.simsns.etc.SearchValidator;
import com.nbp.simsns.serviceinterface.SearchServiceInter;
import com.nbp.simsns.vo.CommentVO;
import com.nbp.simsns.vo.PostVO;
import com.nbp.simsns.vo.SearchResultVO;
import com.nbp.simsns.vo.SearchVO;
import com.nbp.simsns.vo.SearchVO2;

@Service("searchService")
public class SearchServiceImpl implements SearchServiceInter {
	@Autowired
	private SearchValidator searchValidator;
	@Autowired
	private SearchDAO searchDAO;
	
	@Override
	public HashMap<String, Object> searchBoard(SearchVO search, Errors errors) {
		searchValidator.validate(search, errors);
		if(!errors.hasErrors()) {
			List<PostVO> postList = new ArrayList<PostVO>();
			List<CommentVO> commentList = new ArrayList<CommentVO>();
			if(search.getSearchRange().equals("title")) {
				postList = searchDAO.searchPostTitle(search);
			} else if(search.getSearchRange().equals("content")) {
				postList = searchDAO.searchPostContent(search);
			} else if(search.getSearchRange().equals("writer")) {
				postList = searchDAO.searchPostWriter(search);
			} else if(search.getSearchRange().equals("titleContent")) {
				postList = searchDAO.searchPostTitleContent(search);
			}
			HashMap<String, Object> boardResult = new HashMap<String, Object>();
			boardResult.put("postList", postList);
			boardResult.put("commentList", commentList);
			return boardResult;
		}
		return null;
	}

	@Override
	public SearchResultVO searchPost(String searchRange, String searchKeyword, int searchIndex, String userEmailHost) {
		SearchResultVO result = new SearchResultVO();
		SearchVO2 search = new SearchVO2(userEmailHost, searchKeyword, searchIndex);
		if(searchRange.equals("title")) {
			result.setResult(searchDAO.selectPostTitle(search));
			result.setTotal(searchDAO.countTotalTitle(search));
		} else if(searchRange.equals("content")) {
			result.setResult(searchDAO.selectPostContent(search));
			result.setTotal(searchDAO.countTotalContent(search));
		} else if(searchRange.equals("writer")) {
			result.setResult(searchDAO.selectPostWriter(search));
			result.setTotal(searchDAO.countTotalWriter(search));
		} else if(searchRange.equals("titleContent")) {
			result.setResult(searchDAO.selectPostTitleContent(search));
			result.setTotal(searchDAO.countTotalTitleContent(search));
		}
		return result;
	}
	
	@Override
	public SearchResultVO searchComment(String searchRange, String searchKeyword, int searchIndex, String userEmailHost) {
		SearchResultVO result = new SearchResultVO();
		SearchVO2 search = new SearchVO2(userEmailHost, searchKeyword, searchIndex);
		if(searchRange.equals("content")) {
			result.setResult(searchDAO.selectCommentContent(search));
			result.setTotal(searchDAO.countCommentTotalContent(search));
		} else if(searchRange.equals("writer")) {
			result.setResult(searchDAO.selectCommentWriter(search));
			result.setTotal(searchDAO.countCommentTotalWriter(search));
		}
		return result;
	}
}
