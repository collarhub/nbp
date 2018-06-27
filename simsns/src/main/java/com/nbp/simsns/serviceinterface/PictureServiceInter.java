package com.nbp.simsns.serviceinterface;

import java.util.List;

import org.springframework.validation.Errors;
import org.springframework.web.multipart.MultipartFile;

import com.nbp.simsns.vo.PictureVO;
import com.nbp.simsns.vo.PostVO;
import com.nbp.simsns.vo.UserVO;

public interface PictureServiceInter {
	public List<PictureVO> getAllPicture(UserVO user);
	public List<PictureVO> getAllPostPicture(UserVO user);
	public PictureVO getPicture(PostVO post);
	public void writePictureCommit(Object object, MultipartFile multipartFile, Errors errors, final String ROOT_PATH);
	public List<PictureVO> getAllPicturePicture(UserVO user);
	public void deletePicture(PictureVO picture, final String ROOT_PATH);
	public PictureVO selectPicture(PictureVO picture);
	public void updatePictureCommit(Object object, MultipartFile multipartFile, Errors errors, final String ROOT_PATH, String deleted);
	public List<PictureVO> getPostPicturePreview(PictureVO picture);
	public List<PictureVO> getPicturePicturePreview(PictureVO picture);
	public void updatePathValidate(PictureVO picture, String user, Errors errors);
}
