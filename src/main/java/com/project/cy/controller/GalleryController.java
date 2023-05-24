package com.project.cy.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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
	public String gallery(Model model, HttpSession session) {
		
		List<gallery> list = service.getGalleryList();
		String sessionId = (String) session.getAttribute("sessionId");
		
		model.addAttribute("list", list);
		model.addAttribute("sessionId",sessionId);		
		
		return "gallery";
	}
	
	@PostMapping("upload")
	public String upload(MultipartFile file, gallery gallery, HttpSession session) {
		
		String realPath = servletContext.getRealPath("/resources/file");
		System.out.println(realPath);
		fileUpload upload = new fileUpload();	
		String uniqueName = upload.upload(file,realPath);
		
		String sessionId = (String) session.getAttribute("sessionId");
		
		gallery.setM_id(sessionId);	
		gallery.setG_pic(uniqueName);
		
		gallery g = new gallery(gallery.getG_title(),gallery.getG_pic(),gallery.getG_text(),gallery.getM_id(),gallery.getG_secret());
		
		service.add(g);
		
		return "redirect:/gallery_reg";
	}
	
	@PostMapping("good")
	@ResponseBody
	public String good(gallery g) {
		
		gallery ga = new gallery(g.getG_num(),g.getM_id());
		
		String m_id = service.getMemberId(ga);		
		if(m_id==null) {
			service.insertGood(ga);
			return "insert";
		}
		
		int good = service.getGood(ga);
		if(good==0) {
			service.plusGood(ga);
			return "plus";
		}else{
			service.minusGood(ga);
			return "minus";
		}
	}

		
	@PostMapping("gallery_comment")
	@ResponseBody
	public List<gallery> comment(gallery g, HttpSession session){
		Date now = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String date = sdf.format(now);
        
		String sessionId = (String) session.getAttribute("sessionId");

		gallery nickAndpic = service.getNickname(sessionId);
		String nick = nickAndpic.getM_nick();
		String pic = nickAndpic.getG_pic();

		gallery ga = new gallery(g.getGc_text(),g.getG_num(),sessionId);		
		service.regComment(ga);
		
		gallery ga2 = new gallery(pic,nick,date,g.getGc_text());
		ArrayList<gallery> list = new ArrayList<>();
		list.add(ga2);
	
		return list;
		
	}
	
	@PostMapping("commentList")
	@ResponseBody
	public List<gallery> commentList(String g_num){
		return service.getCommentList(g_num);
	}
	
	@PostMapping("editComment")
	@ResponseBody
	public gallery editComment(gallery g){
		service.editComment(g.getGc_text(),g.getG_num());
		return service.getComment(g.getG_num());
		
	}
	
	@PostMapping("deleteComment")
	@ResponseBody
	public int deleteComment(int g_num){
		return service.deleteComment(g_num);
		
	}
	
	
}
