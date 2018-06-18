package com.nbp.simsns.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;
import org.springframework.web.multipart.MultipartFile;

import com.nbp.simsns.dao.PostDAO;
import com.nbp.simsns.etc.WriteCommitValidator;
import com.nbp.simsns.serviceinterface.PostServiceInter;
import com.nbp.simsns.vo.PictureVO;
import com.nbp.simsns.vo.PostVO;
import com.nbp.simsns.vo.UserVO;

@Service("postService")
public class PostServiceImpl implements PostServiceInter{
	
	@Autowired
	private PostDAO postDAO;
	@Autowired
	private WriteCommitValidator writeCommitValidator;

	@Override
	public void writeCommit(Object object, MultipartFile multipartFile, Errors errors, final String ROOT_PATH) {
		PostVO post = (PostVO)object;
		writeCommitValidator.validate(object, errors);
		if(!errors.hasErrors()) {
			postDAO.insertPost(post, multipartFile, ROOT_PATH);
		}
	}

	@Override
	public List<PostVO> getAllPost(UserVO user) {
		return postDAO.getAllPost(user);
	}

	@Override
	public void deletePost(PostVO post, final String ROOT_PATH) {
		postDAO.deletePost(post, ROOT_PATH);
		
	}

	@Override
	public PostVO selectPost(PostVO post) {
		return postDAO.selectPost(post);
	}

	@Override
	public void updateCommit(Object object, MultipartFile multipartFile, Errors errors, final String ROOT_PATH, String deleted) {
		PostVO post = (PostVO)object;
		writeCommitValidator.validate(object, errors);
		if(!errors.hasErrors()) {
			postDAO.updatePost(post, multipartFile, ROOT_PATH, deleted);
		}
		
	}
	
	

}
