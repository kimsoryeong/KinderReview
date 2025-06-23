package com.example.demo.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dao.FileDao;
import com.example.demo.dto.FileDto;

@Service
public class FileService {

    @Value("${custom.file.dir}")
    private String fileDir; 

    private final FileDao fileDao;

    public FileService(FileDao fileDao) {
        this.fileDao = fileDao;
    }

   
    public String saveFile(MultipartFile file, String relTypeCode, int relId) throws IOException {
        String orgName = file.getOriginalFilename(); 
        String uuid = UUID.randomUUID().toString();
        String extension = orgName.substring(orgName.lastIndexOf("."));
        String savedName = uuid + extension;
        String savedPath = fileDir + "/" + savedName; 

        FileDto fileDto = new FileDto();
        fileDto.setOriginName(orgName);
        fileDto.setSavedName(savedName);
        fileDto.setSavedPath(savedPath);
        fileDto.setRelTypeCode(relTypeCode);
        fileDto.setRelId(relId);

        file.transferTo(new File(savedPath)); 
        fileDao.insertFile(fileDto);
        
        return savedName; 
    }

  
    public List<FileDto> getFilesByRel(String relTypeCode, int relId) {
        return fileDao.getFilesByRel(relTypeCode, relId);
    }

    public FileDto getFileById(int id) {
        return fileDao.getFileById(id);
    }

    public void saveFile(MultipartFile file) throws IOException {
        saveFile(file, null, 0); 
    }
    
    public List<FileDto> getFiles() {
        return fileDao.getAllFiles();
    }

    public String getFullPath(String fileName) {
        return fileDir + "/" + fileName;  
    }

   
    public List<FileDto> getFilesByArticleId(int articleId) {
        return fileDao.getFilesByArticleId(articleId);
    }

    public void modifyFile(int articleId, MultipartFile file) throws Exception {

        String originName = file.getOriginalFilename(); 
        String savedName = generateSavedName(file); 
        String savedPath = fileDir + "/" + savedName;  

        file.transferTo(new File(savedPath)); 

        fileDao.saveFile(articleId, originName, savedName, savedPath);
    }

    public void deleteFileByArticleId(int articleId) {
        fileDao.deleteFileByArticleId(articleId);  
    }

    public String saveFile(int articleId, MultipartFile file) {
        String savedName = generateSavedName(file);  
        String savedPath = saveFileToServer(file, savedName);  

        fileDao.saveFile(articleId, file.getOriginalFilename(), savedName, savedPath); 
        
        return savedName;  
    }
    
    private String saveFileToServer(MultipartFile file, String savedName) {
        Path path = Paths.get(fileDir + "/" + savedName); 
        try {
            Files.write(path, file.getBytes()); 
        } catch (IOException e) {
            e.printStackTrace();
        }
        return path.toString();  
    }

    private String generateSavedName(MultipartFile file) {
        String fileName = file.getOriginalFilename();
        return System.currentTimeMillis() + "_" + fileName;  
    }

    public List<FileDto> getFilesByRelId(int id) {
        return fileDao.getFilesByRelId(id);
    }

    public void deleteFileById(int fileId) {
        fileDao.deleteFileById(fileId);

        FileDto fileDto = fileDao.getFileById(fileId);
        if (fileDto != null) {
            File file = new File(fileDto.getSavedPath());
            if (file.exists()) {
                file.delete();  
            }
        }
    }
    
    public void saveWorkCertFile(int memberId, MultipartFile file) {
        try {
            String savedName = saveFile(file, "member", memberId); 
        } catch (IOException e) {
            e.printStackTrace();
        }
    }






	
}