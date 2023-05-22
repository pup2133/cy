package com.project.cy.controller;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.project.cy.model.dto.gallery;
import com.project.cy.model.service.galleryService;
import com.project.cy.util.fileUpload;


@Controller
public class GalleryController {

	galleryService service;
	
	@Autowired
    private ServletContext servletContext;
	
	@Autowired
	public GalleryController(galleryService service) {
		this.service = service;
	}
	

	@GetMapping("gallery_reg")
	public String gallery_reg() {
		
        return "gallery_reg";
	}
	
	@GetMapping("gallery")
	public String gallery(Model model) {
		
		List<gallery> list = service.getGalleryList();
		model.addAttribute("list", list);
		
		
		return "gallery";
	}
	
	@PostMapping("upload")
	public String upload(MultipartFile file, gallery gallery, HttpSession session) {
		
		String realPath = servletContext.getRealPath("/resources/file");
		System.out.println(realPath);
		fileUpload upload = new fileUpload();	
		String uniqueName = upload.upload(file,realPath);
		
		session.setAttribute("sessionId", "yun2");
		String sessionId = (String) session.getAttribute("sessionId");
		
		gallery.setM_id(sessionId);	
		gallery.setG_pic(uniqueName);
		
		gallery g = new gallery(gallery.getG_title(),gallery.getG_pic(),gallery.getG_text(),gallery.getM_id(),gallery.getG_secret());
		
		service.add(g);
		
		return "redirect:/gallery_reg";
	}
	

}
