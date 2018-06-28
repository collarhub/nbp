package com.nbp.simsns.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.nbp.simsns.vo.CommentVO;
import com.nbp.simsns.vo.UserVO;

@Repository
public class CommentDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public String selectMaxCommentNo(CommentVO comment) {
		return sqlSession.selectOne("commentMapper.selectMaxCommentNo", comment);
	}

	public void insertComment(CommentVO comment) {
		sqlSession.insert("commentMapper.insertComment", comment);
	}
	
	public List<CommentVO> getAllComment(UserVO user) {
		return sqlSession.selectList("commentMapper.selectAllComment", user);
	}
	
	public List<CommentVO> selectChild(CommentVO comment) {
		return sqlSession.selectList("commentMapper.selectChild", comment);
	}
	
	public void deleteComment(CommentVO comment) {
		sqlSession.delete("commentMapper.deleteComment", comment);
	}
	
	public void updateComment(CommentVO comment) {
		sqlSession.update("commentMapper.updateComment", comment);
	}
}