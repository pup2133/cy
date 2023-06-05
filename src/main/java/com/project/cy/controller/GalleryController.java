package com.project.cy.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.cy.model.dto.gallery;
import com.project.cy.model.service.galleryService;
import com.project.cy.util.fileUpload;
import com.project.cy.util.pagination;

@Controller
public class GalleryController {

	private galleryService service;
		
	@Autowired
	private ServletContext servletContext;

	@Autowired
	public GalleryController(galleryService service) {
		this.service = service;
	}
	
	@GetMapping("gallery")
	public String gallery(@RequestParam(defaultValue = "1") int page, Model model, HttpSession session, String id) {
		String sessionId = (String)session.getAttribute("sessionId");
		
		int totalCount = service.getTotalCount(id, sessionId);
		pagination p = new pagination();
		Map<String, Integer> pagination = p.pagination(totalCount, page, 3);
		
		List<gallery> list = service.getGalleryList(id, sessionId, pagination.get("startItem"), pagination.get("itemsPerPage"));		
		model.addAttribute("list", list);
		model.addAttribute("totalPages", pagination.get("totalPages"));
		model.addAttribute("currentPage", page);
		model.addAttribute("startPage", pagination.get("startPage"));
		model.addAttribute("endPage", pagination.get("endPage"));
		
		return "gallery";
	}
	

	@GetMapping("galleryReg")
	public String gallery_reg() {
		return "gallery_reg";
	}

	@PostMapping("gallery/reg")
	public String galleryReg(MultipartFile file, gallery gallery, HttpSession session) {
		
		String sessionId = (String) session.getAttribute("sessionId");
		String realPath = servletContext.getRealPath("/resources/file");
		fileUpload upload = new fileUpload();
		String uniqueName = upload.upload(file, realPath);
		gallery dto = new gallery(gallery.getG_title(), uniqueName, gallery.getG_text(), sessionId, gallery.getG_secret());
		service.add(dto);

		return "redirect:/gallery?id="+sessionId;
	}

	@PostMapping("gallery/edit")
	public String galleryEdit(MultipartFile file, gallery gallery, HttpSession session) {
		
		String sessionId = (String) session.getAttribute("sessionId");
		String realPath = servletContext.getRealPath("/resources/file");
		fileUpload upload = new fileUpload();
		String uniqueName = upload.edit(file, realPath, gallery.getG_pic());
		gallery g = new gallery(gallery.getG_title(), uniqueName, gallery.getG_text(), gallery.getG_secret(), gallery.getG_num());
		service.editGallery(g);

		return "redirect:/gallery?id="+sessionId;
	}

	@PostMapping("galleryGood")
	@ResponseBody
	public int galleryGood(gallery gallery) {
		gallery dto = new gallery(gallery.getG_num(), gallery.getM_id());
		String m_id = service.getMemberId(dto);
		return service.galleryGood(dto, m_id);
	}

	@PostMapping("commentGood")
	@ResponseBody
	public int commentGood(gallery g) {
		String id = service.getMemberId2(g.getGc_num(), g.getM_id());
		return service.CommentGood(g.getGc_num(), g.getM_id(), id);
	}

	@PostMapping("comment")
	@ResponseBody
	public List<gallery> comment(gallery g, HttpSession session) {
		
		String sessionId = (String) session.getAttribute("sessionId");
		ArrayList<gallery> list = new ArrayList<>();

		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String date = sdf.format(now);

		gallery np = service.getNickname(sessionId);

		gallery rc = new gallery(g.getGc_text(), g.getG_num(), sessionId);
		service.regComment(rc);

		gallery comment = new gallery(sessionId ,rc.getGc_num(), np.getG_pic(), np.getM_nick(), date, g.getGc_text());
		list.add(comment);

		return list;

	}

	@PostMapping("commentList")
	@ResponseBody
	public List<gallery> commentList(int g_num) {
		return service.getCommentList(g_num);
	}

	@PostMapping("editComment")
	@ResponseBody
	public int editComment(gallery g) {
		return service.editComment(g.getGc_text(), g.getGc_num());
	}

	@PostMapping("deleteComment")
	@ResponseBody
	public int deleteComment(int gc_num) {
		return service.deleteComment(gc_num);

	}

	@GetMapping("editGallery")
	public String editGallery(gallery g, Model model) {
		model.addAttribute("title", g.getG_title());
		model.addAttribute("pic", g.getG_pic());
		model.addAttribute("text", g.getG_text());
		model.addAttribute("g_num", g.getG_num());
		return "gallery_edit";
	}

	@PostMapping("deleteGallery")
	@ResponseBody
	public int deleteGallery(int g_num, String fileName) {
		String realPath = servletContext.getRealPath("/resources/file");
		fileUpload file = new fileUpload();
		file.delete(realPath, fileName);
		return service.deleteGallery(g_num);
	}

}
