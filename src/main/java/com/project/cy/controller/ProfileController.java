package com.project.cy.controller;

import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.cy.model.dto.ProfileDTO;
import com.project.cy.model.service.ProfileService;
import com.project.cy.util.fileUpload;

@Controller
public class ProfileController {
	
	ProfileService service;
	
	@Autowired
    private ServletContext servletContext;
	
	@Autowired
	public void setService(ProfileService service) {
		this.service = service;
	}
	
	ProfileDTO profile;

	@GetMapping("profile")
	public String getProfile(Model model, String id, HttpSession session) throws Exception {
		
		profile = (ProfileDTO) service.selectProfile(id);
		
		session.setAttribute("hostId", id);
		
		model.addAttribute("profile", profile);
		
		return "profile";
	}
	
	@PostMapping("profile/profileUpdate")
	public void updateProfile(@RequestParam Map<String, String> map) {
		
		service.updateProfile1(map);
		service.updateProfile2(map);
		service.updateProfile3(map);
	}
	
	@PostMapping("fileSet")
	@ResponseBody
	public String fileSet(@RequestParam MultipartFile file) {
		String p_pic = profile.getP_pic();
		
		if(!file.isEmpty()) {
			String realPath = servletContext.getRealPath("/resources/file/profile");
			System.out.println("realPath: " + realPath);
			fileUpload upload = new fileUpload();	
			p_pic = upload.upload(file,realPath);
		}
			
		
		return p_pic;
	}
}
