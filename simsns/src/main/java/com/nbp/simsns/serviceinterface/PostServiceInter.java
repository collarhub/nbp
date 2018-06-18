package com.nbp.simsns.serviceinterface;

import java.util.List;

import org.springframework.validation.Errors;
import org.springframework.web.multipart.MultipartFile;

import com.nbp.simsns.vo.PictureVO;
import com.nbp.simsns.vo.PostVO;
import com.nbp.simsns.vo.UserVO;

public interface PostServiceInter {
	public void writeCommit(Object object, MultipartFile multipartFile, Errors errors, final String ROOT_PATH);
	public List<PostVO> getAllPost(UserVO user);
	public void deletePost(PostVO post, final String ROOT_PATH);
	public PostVO selectPost(PostVO post);
	public void updateCommit(Object object, MultipartFile multipartFile, Errors errors, final String ROOT_PATH, String deleted);
}
