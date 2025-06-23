package com.example.demo.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import org.springframework.http.HttpHeaders;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dto.Article;
import com.example.demo.dto.FileDto;
import com.example.demo.service.ArticleService;
import com.example.demo.service.FileService;
import com.example.demo.service.MemberService;
import com.example.demo.util.Util;


@Controller
public class FileController {
	private FileService fileService;
	private MemberService memberService;
	private ArticleService articleService;
	
	
	public FileController(FileService fileService,MemberService memberService, ArticleService articleService ) {
		this.fileService = fileService;
		this.memberService = memberService;
		this.articleService = articleService;
		
	}
	
	@PostMapping("/usr/file/upload")
	@ResponseBody
	public String upload(MultipartFile file) {
		if (file.isEmpty()) {
			return Util.jsReplace("파일이 선택되지 않았습니다", null);
		}
		
		try {
			fileService.saveFile(file);
		} catch (IOException e) {
			e.printStackTrace();
			return Util.jsReplace("파일을 업로드 하는데 문제가 발생했습니다", null);
		}
		
		return Util.jsReplace("파일 업로드 성공", "/");
	}
	
	@GetMapping("/usr/home/view")
	public String view(Model model) {
		
		List<FileDto> files = fileService.getFiles();
		
		model.addAttribute("files", files);
		
		return "usr/home/view";
	}
	
	@GetMapping("/usr/home/file/{fileId}")
	@ResponseBody
	public Resource fileLoad(Model model, @PathVariable("fileId") int id) throws IOException {
		
		FileDto fileDto = fileService.getFileById(id);
		
		return new UrlResource("file:" + fileDto.getSavedPath());
	}
	
	@GetMapping("/usr/member/file/view/{fileName:.+}")
	public ResponseEntity<Resource> viewByFileName(@PathVariable String fileName) throws IOException {
	    String path = fileService.getFullPath(fileName);
	    Resource resource = new UrlResource("file:" + path);

	    if (!resource.exists() || !resource.isReadable()) {
	        return ResponseEntity.notFound().build();
	    }

	    String contentType = Files.probeContentType(Path.of(path));
	    if (contentType == null) {
	        contentType = "application/octet-stream";
	    }

	    return ResponseEntity.ok()
	            .header(HttpHeaders.CONTENT_TYPE, contentType)
	            .body(resource);
	}
	
	@GetMapping("/usr/member/file/download/{fileName:.+}")
	public ResponseEntity<Resource> downloadByFileName(@PathVariable String fileName) throws IOException {
	    String path = fileService.getFullPath(fileName);
	    Resource resource = new UrlResource("file:" + path);

	    if (!resource.exists() || !resource.isReadable()) {
	        return ResponseEntity.notFound().build();
	    }

	    String encodedFileName = URLEncoder.encode(resource.getFilename(), StandardCharsets.UTF_8);

	    return ResponseEntity.ok()
	            .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodedFileName + "\"")
	            .header(HttpHeaders.CONTENT_TYPE, "application/octet-stream")
	            .body(resource);
	}

	
	 @PostMapping("/usr/file/modify/{articleId}")
	    public String modifyFile(@PathVariable("articleId") int articleId, @RequestParam("workCertFile") MultipartFile file) {
	        if (file.isEmpty()) {
	            return "redirect:/usr/article/detail?id=" + articleId + "&error=새 파일을 선택해 주세요.";
	        }

	        try {
	            fileService.modifyFile(articleId, file);
	        } catch (Exception e) {
	            e.printStackTrace();
	            return "redirect:/usr/article/detail?id=" + articleId + "&error=파일 수정에 실패했습니다.";
	        }

	        return "redirect:/usr/article/detail?id=" + articleId + "&success=파일이 수정되었습니다.";
	    }
	 
	 @GetMapping("/usr/member/file/delete/{fileId}")
	 public String deleteFile(@PathVariable("fileId") int fileId, @RequestParam("articleId") int articleId) {
	     fileService.deleteFileById(fileId);  

	     return "redirect:/usr/article/modify?id=" + articleId;  
	 }

	 @PostMapping("/usr/file/reupload")
	 @ResponseBody
	 public String reupload(@RequestParam("file") MultipartFile file,
	                        @RequestParam String type,
	                        @RequestParam(required = false) Integer memberId,
	                        @RequestParam(required = false) Integer articleId) throws IOException {
	     if ("member".equals(type) && memberId != null) {
	         String fileName = fileService.saveFile(file, "member", memberId);
	         memberService.updateWorkChkFile(memberId, fileName);
	         memberService.updateApproveStatus(memberId, 0);
	     }

	     if ("article".equals(type) && articleId != null) {
	         String fileName = fileService.saveFile(file, "article", articleId);
	         articleService.reuploadFile(articleId, fileName);
	     }

	     return Util.jsReplace("파일이 재업로드 되었습니다. 승인을 기다려주세요.", "/usr/member/myPage");
	 }




}