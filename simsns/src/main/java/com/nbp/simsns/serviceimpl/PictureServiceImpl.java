package com.nbp.simsns.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.Errors;
import org.springframework.web.multipart.MultipartFile;

import com.nbp.simsns.dao.PictureDAO;
import com.nbp.simsns.etc.WritePictureCommitValidator;
import com.nbp.simsns.serviceinterface.PictureServiceInter;
import com.nbp.simsns.vo.PictureVO;
import com.nbp.simsns.vo.PostVO;
import com.nbp.simsns.vo.UserVO;

public class PictureServiceImpl implements PictureServiceInter {
	@Autowired
	private PictureDAO pictureDAO;
	@Autowired
	private WritePictureCommitValidator writePictureCommitValidator;

	@Override
	public List<PictureVO> getAllPicture(UserVO user) {
		return pictureDAO.getAllPicture(user);
	}

	@Override
	public PictureVO getPicture(PostVO post) {
		PictureVO picture = new PictureVO();
		picture.setUserEmailHost(post.getUserEmailHost());
		picture.setPostTimestamp(post.getPostTimestamp());
		picture.setPostNo(post.getPostNo());
		PictureVO pictureOutput = pictureDAO.getPicture(picture);
		return pictureOutput;
	}
	
	@Override
	public List<PictureVO> getAllPostPicture(UserVO user) {
		return pictureDAO.getAllPostPicture(user);
	}
	
	@Override
	public List<PictureVO> getAllPicturePicture(UserVO user) {
		return pictureDAO.getAllPicturePicture(user);
	}

	@Override
	public void writePictureCommit(Object object, MultipartFile multipartFile, Errors errors, String ROOT_PATH) {
		PictureVO picture = (PictureVO)object;
		if(!multipartFile.isEmpty()) {
			((PictureVO)object).setPicturePath("notEmpty");
		}
		writePictureCommitValidator.validate(object, errors);
		((PictureVO)object).setPicturePath(null);
		if(!errors.hasErrors()) {
			pictureDAO.insertPicture(picture, multipartFile, ROOT_PATH);
		}
	}
}
