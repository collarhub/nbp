package com.nbp.simsns.etc;

import org.springframework.web.multipart.MultipartFile;

public class PictureExtensionValidator {
	public String getExtension(MultipartFile multipartFile) {
		if(multipartFile.getContentType().equals("image/jpeg")) {
			return ".jpg";
		} else if(multipartFile.getContentType().equals("image/png")) {
			return ".png";
		} else {
			return ".png";
		}
	}
}
