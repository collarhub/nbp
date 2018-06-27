package com.nbp.simsns.dao;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.nbp.simsns.etc.Md5Generator;
import com.nbp.simsns.etc.PictureExtensionValidator;
import com.nbp.simsns.etc.PictureUploader;
import com.nbp.simsns.vo.PictureVO;
import com.nbp.simsns.vo.UserVO;

@Repository
public class PictureDAO {
	static final String UPLOAD_PATH = "resources/picture/";
	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private PictureUploader pictureUploader;

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

	public void updatePicture(PictureVO picture, MultipartFile multipartFile, String ROOT_PATH) {
		pictureUploader.deleteFile(ROOT_PATH + UPLOAD_PATH, picture.getPicturePath());
		picture.setPicturePath(new Md5Generator().getMd5(picture.getUserEmailHost())
				+ picture.getPictureTimestamp() + picture.getPictureNo()
				+ new PictureExtensionValidator().getExtension(multipartFile));
		sqlSession.update("pictureMapper.updatePicture", picture);
		pictureUploader.writeFile(multipartFile, ROOT_PATH + UPLOAD_PATH, picture.getPicturePath());
	}

	public void deletePicture(PictureVO picture, final String ROOT_PATH) {
		sqlSession.delete("pictureMapper.deletePicture", picture);
		pictureUploader.deleteFile(ROOT_PATH + UPLOAD_PATH, picture.getPicturePath());
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
