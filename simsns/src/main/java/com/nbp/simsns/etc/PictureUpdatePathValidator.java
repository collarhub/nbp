package com.nbp.simsns.etc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.nbp.simsns.dao.PictureDAO;
import com.nbp.simsns.vo.PictureVO;

public class PictureUpdatePathValidator implements Validator {
	@Autowired
	private PictureDAO pictureDAO;

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
		PictureVO picture = pictureDAO.selectPicture((PictureVO)object);
		if(picture == null || !picture.getUserEmailGuest().equals(user)) {
			errors.rejectValue("pictureTimestamp", "select", "잘못된 접근입니다.");
		}
	}
	
}
