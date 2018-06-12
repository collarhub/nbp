package com.nbp.simsns.serviceinterface;

import java.util.List;

import com.nbp.simsns.vo.LikeVO;
import com.nbp.simsns.vo.UserVO;

public interface LikeServiceInter {
	public void addLike(LikeVO like);
	public List<LikeVO> getAllLike(UserVO user);
}
