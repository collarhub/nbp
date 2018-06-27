package com.nbp.simsns.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.nbp.simsns.vo.CommentVO;
import com.nbp.simsns.vo.PostVO;
import com.nbp.simsns.vo.SearchVO2;

@Repository
public class SearchDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public PostVO selectPostTitle(SearchVO2 search) {
		return sqlSession.selectOne("searchMapper.selectPostTitleOne", search);
	}
	public int countTotalTitle(SearchVO2 search) {
		return sqlSession.selectOne("searchMapper.countTotalTitle", search);
	}
	public PostVO selectPostContent(SearchVO2 search) {
		return sqlSession.selectOne("searchMapper.selectPostContentOne", search);
	}
	public int countTotalContent(SearchVO2 search) {
		return sqlSession.selectOne("searchMapper.countTotalContent", search);
	}
	public PostVO selectPostWriter(SearchVO2 search) {
		return sqlSession.selectOne("searchMapper.selectPostWriterOne", search);
	}
	public int countTotalWriter(SearchVO2 search) {
		return sqlSession.selectOne("searchMapper.countTotalWriter", search);
	}
	public PostVO selectPostTitleContent(SearchVO2 search) {
		return sqlSession.selectOne("searchMapper.selectPostTitleContentOne", search);
	}
	public int countTotalTitleContent(SearchVO2 search) {
		return sqlSession.selectOne("searchMapper.countTotalTitleContent", search);
	}
	public CommentVO selectCommentContent(SearchVO2 search) {
		return sqlSession.selectOne("searchMapper.selectCommentContentOne", search);
	}
	public int countCommentTotalContent(SearchVO2 search) {
		return sqlSession.selectOne("searchMapper.countCommentTotalContent", search);
	}
	public CommentVO selectCommentWriter(SearchVO2 search) {
		return sqlSession.selectOne("searchMapper.selectCommentWriterOne", search);
	}
	public int countCommentTotalWriter(SearchVO2 search) {
		return sqlSession.selectOne("searchMapper.countCommentTotalWriter", search);
	}
}
