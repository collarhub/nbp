package com.nbp.simsns.serviceinterface;

import java.util.HashMap;

import org.springframework.validation.Errors;

import com.nbp.simsns.vo.SearchResultVO;
import com.nbp.simsns.vo.SearchVO;

public interface SearchServiceInter {
	public HashMap<String, Object> searchBoard(SearchVO search, Errors errors);
	public SearchResultVO searchPost(String searchRange, String searchKeyword, int searchIndex, String userEmailHost);
	public SearchResultVO searchComment(String searchRange, String searchKeyword, int searchIndex, String userEmailHost);
}
