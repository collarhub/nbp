package com.nbp.simsns.dao;

import java.sql.Timestamp;
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

	public void insertLike(LikeVO like) {
		like.setLikeTimestamp(Long.toString(new Timestamp(System.currentTimeMillis()).getTime()));
		String maxLikeNo = sqlSession.selectOne("likeMapper.selectMaxLikeNo", like);
		if(maxLikeNo == null) {
			like.setLikeNo("1");
		} else {
			like.setLikeNo(Integer.toString(Integer.parseInt(maxLikeNo) + 1));
		}
		sqlSession.insert("likeMapper.insertLike", like);
	}

	public List<LikeVO> getAllLike(UserVO user) {
		return sqlSession.selectList("likeMapper.selectAllLike", user);
	}

}
