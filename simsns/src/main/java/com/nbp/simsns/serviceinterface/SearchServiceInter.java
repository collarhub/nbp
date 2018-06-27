package com.nbp.simsns.serviceinterface;

import com.nbp.simsns.vo.SearchResultVO;

public interface SearchServiceInter {
	public SearchResultVO searchPost(String searchRange, String searchKeyword, int searchIndex, String userEmailHost);
	public SearchResultVO searchComment(String searchRange, String searchKeyword, int searchIndex, String userEmailHost);
}
