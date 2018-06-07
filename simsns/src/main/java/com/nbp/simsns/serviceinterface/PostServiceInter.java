package com.nbp.simsns.serviceinterface;

import java.util.List;

import org.springframework.validation.Errors;

import com.nbp.simsns.vo.PostVO;
import com.nbp.simsns.vo.UserVO;

public interface PostServiceInter {
	public void writeCommit(Object object, Errors errors);
	public List<PostVO> getAllPost(UserVO user);
	public void deletePost(PostVO post);
	public PostVO selectPost(PostVO post);
	public void updateCommit(Object object, Errors errors);
}
