package com.nbp.simsns.serviceinterface;

import java.util.List;

import org.springframework.validation.Errors;

import com.nbp.simsns.vo.LikeVO;
import com.nbp.simsns.vo.UserVO;

public interface LikeServiceInter {
	public void addLike(LikeVO like, Errors errors);
	public List<LikeVO> getAllLike(UserVO user);
}
