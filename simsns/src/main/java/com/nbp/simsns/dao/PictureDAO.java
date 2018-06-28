package com.nbp.simsns.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.nbp.simsns.vo.PictureVO;
import com.nbp.simsns.vo.UserVO;

@Repository
public class PictureDAO {
	@Autowired
	private SqlSession sqlSession;

	public String selectMaxPictureNo(PictureVO picture) {
		return sqlSession.selectOne("pictureMapper.selectMaxPictureNo", picture);
	}
	
	public void insertPicture(PictureVO picture) {
        sqlSession.insert("pictureMapper.insertPicture", picture);
	}

	public List<PictureVO> getAllPicture(UserVO user) {
		return sqlSession.selectList("pictureMapper.selectAllPicture", user);
	}
	
	public PictureVO getPicture(PictureVO picture) {
		return sqlSession.selectOne("pictureMapper.selectPicture", picture);
	}
	
	public void updatePicture(PictureVO picture) {
		sqlSession.update("pictureMapper.updatePicture", picture);
	}

	public void deletePicture(PictureVO picture) {
		sqlSession.delete("pictureMapper.deletePicture", picture);
	}

	public List<PictureVO> getAllPostPicture(UserVO user) {
		return sqlSession.selectList("pictureMapper.selectAllPostPicture", user);
	}
	
	public List<PictureVO> getAllPicturePicture(UserVO user) {
		return sqlSession.selectList("pictureMapper.selectAllPicturePicture", user);
	}
	
	public PictureVO selectPicture(PictureVO picture) {
		return sqlSession.selectOne("pictureMapper.selectPicturePicture", picture);
	}
	
	public void updatePicturePicture(PictureVO picture) {
		sqlSession.update("pictureMapper.updatePicturePicture", picture);
	}
	
	public List<PictureVO> selectPostPicturePreview(PictureVO picture) {
		return sqlSession.selectList("pictureMapper.selectPostPicturePreview", picture);
	}
	
	public List<PictureVO> selectPicturePicturePreview(PictureVO picture) {
		return sqlSession.selectList("pictureMapper.selectPicturePicturePreview", picture);
	}
}
