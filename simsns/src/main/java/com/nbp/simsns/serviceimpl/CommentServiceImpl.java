package com.nbp.simsns.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;

import com.nbp.simsns.dao.CommentDAO;
import com.nbp.simsns.etc.CommentWriteValidator;
import com.nbp.simsns.serviceinterface.CommentServiceInter;
import com.nbp.simsns.vo.CommentVO;
import com.nbp.simsns.vo.UserVO;

@Service("commentService")
public class CommentServiceImpl implements CommentServiceInter {
	@Autowired
	private CommentDAO commentDAO;
	@Autowired
	private CommentWriteValidator commentWriteValidator;

	@Override
	public void writeComment(CommentVO comment, Errors errors) {
		commentWriteValidator.validate(comment, errors);
		if(!errors.hasErrors()) {
			commentDAO.insertComment(comment);
		}
	}

	@Override
	public List<CommentVO> getAllComment(UserVO user) {
		return commentDAO.getAllComment(user);
	}

	@Override
	public void deleteComment(CommentVO comment) {
		commentDAO.deleteComment(comment);
	}

	@Override
	public void updateComment(Object object, Errors errors) {
		CommentVO comment = (CommentVO)object;
		commentWriteValidator.validate(object, errors);
		if(!errors.hasErrors()) {
			commentDAO.updateComment(comment);
		}
	}
}
