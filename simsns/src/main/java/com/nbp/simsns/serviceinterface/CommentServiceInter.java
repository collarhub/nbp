package com.nbp.simsns.serviceinterface;

import java.util.List;

import org.springframework.validation.Errors;

import com.nbp.simsns.vo.CommentVO;
import com.nbp.simsns.vo.UserVO;

public interface CommentServiceInter {
	public void writeComment(CommentVO comment, Errors errors);
	public List<CommentVO> getAllComment(UserVO user);
	public void deleteComment(CommentVO comment);
	public void updateComment(Object object, Errors errors);
}
