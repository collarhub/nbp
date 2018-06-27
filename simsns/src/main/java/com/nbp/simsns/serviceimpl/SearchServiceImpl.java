package com.nbp.simsns.serviceimpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nbp.simsns.dao.SearchDAO;
import com.nbp.simsns.serviceinterface.SearchServiceInter;
import com.nbp.simsns.vo.SearchResultVO;
import com.nbp.simsns.vo.SearchVO2;

@Service("searchService")
public class SearchServiceImpl implements SearchServiceInter {

	@Autowired
	private SearchDAO searchDAO;

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
