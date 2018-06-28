package com.nbp.simsns.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.nbp.simsns.vo.LikeVO;
import com.nbp.simsns.vo.UserVO;

@Repository
public class LikeDAO {
	@Autowired
	private SqlSession sqlSession;

	public String selectMaxLikeNo(LikeVO like) {
		return sqlSession.selectOne("likeMapper.selectMaxLikeNo", like);
	}
	
	public void insertLike(LikeVO like) {
		sqlSession.insert("likeMapper.insertLike", like);
	}

	public List<LikeVO> getAllLike(UserVO user) {
		return sqlSession.selectList("likeMapper.selectAllLike", user);
	}

	public List<LikeVO> selectLike(LikeVO like) {
		List<LikeVO> outputs = sqlSession.selectList("likeMapper.selectLike", like);
		return outputs;
	}

}
