package com.nbp.simsns.serviceimpl;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;
import org.springframework.web.multipart.MultipartFile;

import com.nbp.simsns.dao.PictureDAO;
import com.nbp.simsns.dao.PostDAO;
import com.nbp.simsns.etc.Md5Generator;
import com.nbp.simsns.etc.PictureExtensionValidator;
import com.nbp.simsns.etc.PictureUploader;
import com.nbp.simsns.etc.PostUpdatePathValidator;
import com.nbp.simsns.etc.WriteCommitValidator;
import com.nbp.simsns.serviceinterface.PostServiceInter;
import com.nbp.simsns.vo.PictureVO;
import com.nbp.simsns.vo.PostVO;
import com.nbp.simsns.vo.UserVO;

@Service("postService")
public class PostServiceImpl implements PostServiceInter{
	
	static final String UPLOAD_PATH = "resources/picture/";
	@Autowired
	private PictureUploader pictureUploader;
	@Autowired
	private PostDAO postDAO;
	@Autowired
	private PictureDAO pictureDAO;
	@Autowired
	private WriteCommitValidator writeCommitValidator;
	@Autowired
	private PostUpdatePathValidator postUpdatePathValidator;

	@Override
	public void writeCommit(Object object, MultipartFile multipartFile, Errors errors, final String ROOT_PATH) {
		PostVO post = (PostVO)object;
		writeCommitValidator.validate(object, errors);
		if(!errors.hasErrors()) {
			post.setPostTimestamp(Long.toString(new Timestamp(System.currentTimeMillis()).getTime()));
			String maxPostNo = postDAO.selectMaxPostNo(post);
			if(maxPostNo == null) {
				post.setPostNo("1");
			} else {
				post.setPostNo(Integer.toString(Integer.parseInt(maxPostNo) + 1));
			}
	        postDAO.insertPost(post);
	        if(!multipartFile.isEmpty()) {
	        	PictureVO picture = new PictureVO();
	        	picture.setUserEmailGuest(post.getUserEmailGuest());
	        	picture.setUserEmailHost(post.getUserEmailHost());
	        	picture.setPictureTitle(post.getPostTitle());
	        	picture.setPostNo(post.getPostNo());
	        	picture.setPostTimestamp(post.getPostTimestamp());
	        	picture.setUserNameGuest(post.getUserNameGuest());
	        	picture.setPictureTimestamp(Long.toString(new Timestamp(System.currentTimeMillis()).getTime()));
				String maxPictureNo = pictureDAO.selectMaxPictureNo(picture);
				if(maxPictureNo == null) {
					picture.setPictureNo("1");
				} else {
					picture.setPictureNo(Integer.toString(Integer.parseInt(maxPictureNo) + 1));
				}
				picture.setPicturePath(new Md5Generator().getMd5(picture.getUserEmailHost())
										+ picture.getPictureTimestamp() + picture.getPictureNo()
										+ new PictureExtensionValidator().getExtension(multipartFile));
		        pictureUploader.writeFile(multipartFile, ROOT_PATH + UPLOAD_PATH, picture.getPicturePath());
	        	pictureDAO.insertPicture(picture);
	        }
		}
	}

	@Override
	public List<PostVO> getAllPost(UserVO user) {
		return postDAO.getAllPost(user);
	}

	@Override
	public void deletePost(PostVO post, final String ROOT_PATH) {
		postDAO.deletePost(post, ROOT_PATH);
		
	}

	@Override
	public PostVO selectPost(PostVO post) {
		return postDAO.selectPost(post);
	}

	@Override
	public void updateCommit(Object object, MultipartFile multipartFile, Errors errors, final String ROOT_PATH, String deleted) {
		PostVO post = (PostVO)object;
		writeCommitValidator.validate(object, errors);
		if(!errors.hasErrors()) {
			postDAO.updatePost(post);
			PictureVO picture = new PictureVO();
	    	picture.setUserEmailGuest(post.getUserEmailGuest());
	    	picture.setUserEmailHost(post.getUserEmailHost());
	    	picture.setPictureTitle(post.getPostTitle());
	    	picture.setPostNo(post.getPostNo());
	    	picture.setPostTimestamp(post.getPostTimestamp());
	    	picture.setUserNameGuest(post.getUserNameGuest());
	    	PictureVO pictureOutput = pictureDAO.getPicture(picture);
	    	if(pictureOutput == null) {
	    		if(!multipartFile.isEmpty()) {
	    			picture.setPictureTimestamp(Long.toString(new Timestamp(System.currentTimeMillis()).getTime()));
	    			String maxPictureNo = pictureDAO.selectMaxPictureNo(picture);
	    			if(maxPictureNo == null) {
	    				picture.setPictureNo("1");
	    			} else {
	    				picture.setPictureNo(Integer.toString(Integer.parseInt(maxPictureNo) + 1));
	    			}
	    			picture.setPicturePath(new Md5Generator().getMd5(picture.getUserEmailHost())
	    									+ picture.getPictureTimestamp() + picture.getPictureNo()
	    									+ new PictureExtensionValidator().getExtension(multipartFile));
	    	        pictureUploader.writeFile(multipartFile, ROOT_PATH + UPLOAD_PATH, picture.getPicturePath());
	    			pictureDAO.insertPicture(picture);
	    		}
	    	} else {
	    		if(!multipartFile.isEmpty()) {
	    			pictureOutput.setPictureTitle(picture.getPictureTitle());
	    			pictureDAO.updatePicture(pictureOutput, multipartFile, ROOT_PATH);
	    		} else {
	    			if(deleted.equals("true")) {
	    				pictureDAO.deletePicture(pictureOutput, ROOT_PATH);
	    			}
	    		}
	    	}
		}
		
	}

	@Override
	public void updatePathValidate(PostVO post, String user, Errors errors) {
		postUpdatePathValidator.validate(post, user, errors);
	}
	
	
}
