package com.nbp.simsns.etc;

import java.io.File;
import java.io.FileOutputStream;

import org.springframework.web.multipart.MultipartFile;

public class PictureUploader {
	private FileOutputStream fileOutputStream;
	
    public void writeFile(MultipartFile file, String path, String fileName){
        try{
            byte fileData[] = file.getBytes();
            fileOutputStream = new FileOutputStream(path + fileName);
            fileOutputStream.write(fileData);
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            if(fileOutputStream != null){
                try{
                	fileOutputStream.close();
                }catch(Exception e){}
                }
        }
    }
    
    public void deleteFile(String path, String fileName) {
        File file = new File(path + fileName);
		if(file.exists() == true){
			file.delete();
		}
    }
}
