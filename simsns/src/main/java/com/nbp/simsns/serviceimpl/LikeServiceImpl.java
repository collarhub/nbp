package com.nbp.simsns.serviceimpl;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;

import com.nbp.simsns.dao.LikeDAO;
import com.nbp.simsns.etc.AddLikeValidator;
import com.nbp.simsns.serviceinterface.LikeServiceInter;
import com.nbp.simsns.vo.LikeVO;
import com.nbp.simsns.vo.UserVO;

@Service("likeService")
public class LikeServiceImpl implements LikeServiceInter{

	@Autowired
	private LikeDAO likeDAO;
	@Autowired
	private AddLikeValidator addLikeValidator;
	
	@Override
	public void addLike(LikeVO like, Errors errors) {
		addLikeValidator.validate(like, errors);
		if(!errors.hasErrors()) {
			like.setLikeTimestamp(Long.toString(new Timestamp(System.currentTimeMillis()).getTime()));
			String maxLikeNo = likeDAO.selectMaxLikeNo(like);
			if(maxLikeNo == null) {
				like.setLikeNo("1");
			} else {
				like.setLikeNo(Integer.toString(Integer.parseInt(maxLikeNo) + 1));
			}
			likeDAO.insertLike(like);
		}
	}

	@Override
	public List<LikeVO> getAllLike(UserVO user) {
		return likeDAO.getAllLike(user);
	}
	
}
