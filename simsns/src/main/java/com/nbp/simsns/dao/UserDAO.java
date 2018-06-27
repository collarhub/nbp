package com.nbp.simsns.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.nbp.simsns.vo.UserVO;

@Repository
public class UserDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(UserDAO.class);
    
    public void insertUser(UserVO user) {
        sqlSession.insert("userMapper.insertUser", user);
    }
    
    public List<UserVO> selectUser(UserVO user) {
    	List<UserVO> outputs = sqlSession.selectList("userMapper.selectUser", user);
    	return outputs;
    }
    
    public String getHash(String passwordString) {
    	String output = sqlSession.selectOne("userMapper.getHash", passwordString);
    	return output;
    }
}
