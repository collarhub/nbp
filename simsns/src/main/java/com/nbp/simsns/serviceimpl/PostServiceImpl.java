package com.nbp.simsns.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;

import com.nbp.simsns.dao.PostDAO;
import com.nbp.simsns.etc.WriteCommitValidator;
import com.nbp.simsns.serviceinterface.PostServiceInter;
import com.nbp.simsns.vo.PostVO;
import com.nbp.simsns.vo.UserVO;

@Service("postService")
public class PostServiceImpl implements PostServiceInter{
	
	@Autowired
	private PostDAO postDAO;
	@Autowired
	private WriteCommitValidator writeCommitValidator;

	@Override
	public void writeCommit(Object object, Errors errors) {
		PostVO post = (PostVO)object;
		writeCommitValidator.validate(object, errors);
		if(!errors.hasErrors()) {
			postDAO.insertPost(post);
		}
	}

	@Override
	public List<PostVO> getAllPost(UserVO user) {
		return postDAO.getAllPost(user);
	}

	@Override
	public void deletePost(PostVO post) {
		postDAO.deletePost(post);
		
	}

	@Override
	public PostVO selectPost(PostVO post) {
		return postDAO.selectPost(post);
	}

	@Override
	public void updateCommit(Object object, Errors errors) {
		PostVO post = (PostVO)object;
		writeCommitValidator.validate(object, errors);
		if(!errors.hasErrors()) {
			postDAO.updatePost(post);
		}
		
	}
	
	

}
