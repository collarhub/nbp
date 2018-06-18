package com.nbp.simsns.etc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.nbp.simsns.dao.LikeDAO;
import com.nbp.simsns.vo.LikeVO;

public class AddLikeValidator implements Validator{
	@Autowired
	private LikeDAO likeDAO;

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void validate(Object object, Errors errors) {
		LikeVO like = (LikeVO)object;
		if(!likeDAO.selectLike(like).isEmpty()) {
        	errors.rejectValue("userEmailGuest", "select", "한 번만 가능합니다.");
        }
	}
	
}
