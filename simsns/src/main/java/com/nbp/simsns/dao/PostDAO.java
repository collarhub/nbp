package com.nbp.simsns.dao;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.nbp.simsns.vo.PostVO;
import com.nbp.simsns.vo.UserVO;

@Repository
public class PostDAO {
	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(PostDAO.class);
	
	public void insertPost(PostVO post) {
		post.setPostTimestamp(Long.toString(new Timestamp(System.currentTimeMillis()).getTime()));
		String maxPostNo = sqlSession.selectOne("postMapper.selectMaxPostNo", post);
		if(maxPostNo == null) {
			post.setPostNo("1");
		} else {
			post.setPostNo(Integer.toString(Integer.parseInt(maxPostNo) + 1));
		}
        sqlSession.insert("postMapper.insertPost", post);
    }
	
	public List<PostVO> getAllPost(UserVO user) {
		return sqlSession.selectList("postMapper.selectAllPost", user);
	}
	
	public void deletePost(PostVO post) {
		sqlSession.delete("postMapper.deletePost", post);
	}
	
	public PostVO selectPost(PostVO post) {
		return sqlSession.selectOne("postMapper.selectPost", post);
	}
	
	public void updatePost(PostVO post) {
		sqlSession.update("postMapper.updatePost", post);
	}

}
