package com.nbp.simsns.dao;

import java.sql.Timestamp;
import java.util.ArrayList;
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

	public void insertComment(CommentVO comment) {
		comment.setCommentTimestamp(Long.toString(new Timestamp(System.currentTimeMillis()).getTime()));
		String maxCommentNo = sqlSession.selectOne("commentMapper.selectMaxCommentNo", comment);
		if(maxCommentNo == null) {
			comment.setCommentNo("1");
		} else {
			comment.setCommentNo(Integer.toString(Integer.parseInt(maxCommentNo) + 1));
		}
		sqlSession.insert("commentMapper.insertComment", comment);
	}
	
	public List<CommentVO> getAllComment(UserVO user) {
		return sqlSession.selectList("commentMapper.selectAllComment", user);
	}
	
	public void deleteComment(CommentVO commentRoot) {
		List<CommentVO> deleteList = new ArrayList<CommentVO>();
		List<CommentVO> childList;
		deleteList.add(commentRoot);
		for(int index = 0; index < deleteList.size(); index++) {
			childList = sqlSession.selectList("commentMapper.selectChild", deleteList.get(index));
			deleteList.addAll(childList);
		}
		for(CommentVO comment : deleteList) {
			sqlSession.delete("commentMapper.deleteComment", comment);
		}
	}
	
	public void updateComment(CommentVO comment) {
		sqlSession.update("commentMapper.updateComment", comment);
	}
}