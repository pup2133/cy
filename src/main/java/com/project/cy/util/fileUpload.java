package com.project.cy.util;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

public class fileUpload {
	
	public String upload(MultipartFile file, String realPath) {

		if (!file.isEmpty()) {
			String fileRealName = file.getOriginalFilename(); // 파일명을 얻어낼 수 있는 메서드
			long size = file.getSize(); // 파일 사이즈
			System.out.println("파일명 : " + fileRealName);
			System.out.println("용량크기(byte) : " + size);
			String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."), fileRealName.length());
			String uploadFolder = realPath;

			UUID uuid = UUID.randomUUID();
			System.out.println(uuid.toString());
			String[] uuids = uuid.toString().split("-");

			String uniqueName = uuids[0];
			System.out.println("생성된 고유문자열" + uniqueName);
			System.out.println("확장자명" + fileExtension);

			String filePath = uploadFolder + "/" + uniqueName + fileExtension;

			File saveFile = new File(filePath); // 적용 후

			try {
				file.transferTo(saveFile); // 실제 파일 저장메서드(filewriter 작업을 손쉽게 한방에 처리해준다.)
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

			String fileName = uniqueName + fileExtension;

			return fileName;

		} else {
			return null;
		}
	}

	public String edit(MultipartFile file, String realPath, String img) {
		if (file.isEmpty()) {
			return img;
		} else {
			fileUpload f = new fileUpload();
			return f.upload(file, realPath);
		}
	}
	
	public void delete(String realPath, String fileName) {
		String filePath = realPath +"/"+ fileName;		
		File file = new File(filePath);
		file.delete();
	}
}
