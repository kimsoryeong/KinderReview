package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.demo.dto.FileDto;

@Mapper
public interface FileDao {

    @Insert("""
            INSERT INTO file
                SET regDate = NOW(),
                    originName = #{originName},
                    savedName = #{savedName},
                    savedPath = #{savedPath},
                    relTypeCode = #{relTypeCode},
                    relId = #{relId}
    """)
    void insertFile(FileDto fileDto);

    @Select("SELECT LAST_INSERT_ID()")
    int getLastInsertId();

    @Select("""
        SELECT *
        FROM file
        WHERE id = #{id}
    """)
    FileDto getFileById(int id);

    @Select("""
        SELECT * 
        FROM file
        WHERE relTypeCode = #{relTypeCode}
        AND relId = #{relId}
    """)
    List<FileDto> getFilesByRel(@Param("relTypeCode") String relTypeCode, @Param("relId") int relId);

    @Select("""
        SELECT * 
        FROM file
        ORDER BY id DESC
    """)
    List<FileDto> getAllFiles();

    @Select("""
        SELECT * 
        FROM file
        WHERE relTypeCode = 'article' 
        AND relId = #{articleId}
    """)
    List<FileDto> getFilesByArticleId(int articleId);

    @Delete("""
        DELETE 
        FROM file
        WHERE relTypeCode = 'article' 
        AND relId = #{articleId}
    """)
    void deleteFileByArticleId(int articleId);

    @Insert("""
        INSERT INTO file (regDate, originName, savedName, savedPath, relTypeCode, relId) 
        VALUES (NOW(), #{originName}, #{savedName}, #{savedPath}, 'article', #{articleId})
    """)
    void saveFile(@Param("articleId") int articleId, 
                  @Param("originName") String originName, 
                  @Param("savedName") String savedName, 
                  @Param("savedPath") String savedPath);

    @Select("""
        SELECT * 
        FROM file
        WHERE relId = #{id}
    """)
    List<FileDto> getFilesByRelId(int id);

    @Delete("""
            DELETE FROM file
            WHERE id = #{fileId}
        """)
        void deleteFileById(int fileId);

	
 

}