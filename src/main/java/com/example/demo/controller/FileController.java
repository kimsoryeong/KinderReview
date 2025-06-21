package com.example.demo.controller;

import java.io.IOException;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dto.FileDto;
import com.example.demo.service.FileService;
import com.example.demo.util.Util;


@Controller
public class FileController {
	private FileService fileService;
	
	
	public FileController(FileService fileService) {
		this.fileService = fileService;
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


}