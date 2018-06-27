package com.nbp.simsns.etc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.nbp.simsns.dao.PostDAO;
import com.nbp.simsns.vo.PostVO;

public class PostUpdatePathValidator implements Validator {
	@Autowired
	private PostDAO postDAO;

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void validate(Object object, Errors errors) {
		// TODO Auto-generated method stub
		
	}
	
	public void validate(Object object, String user, Errors errors) {
		PostVO post = postDAO.selectPost((PostVO)object);
		if(post == null || !post.getUserEmailGuest().equals(user)) {
			errors.rejectValue("postTimestamp", "select", "잘못된 접근입니다.");
		}
	}
}
