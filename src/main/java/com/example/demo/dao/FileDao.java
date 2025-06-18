package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
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


	@Insert("""
		    INSERT INTO member(loginId, loginPw, companyName, companyNumber, regDate)
		    VALUES(#{loginId}, #{loginPw}, #{companyName}, #{companyNumber}, NOW())
		""")
		void joinCompanyMember(String loginId, String loginPw, String companyName, String companyNumber);

	@Select("SELECT LAST_INSERT_ID()")
		int getLastInsertId();

	@Select("""
			SELECT *
			FROM `file`
			WHERE relTypeCode = #{relTypeCode} AND relId = #{relId}
			""")
	List<FileDto> getFilesByRel(String relTypeCode, int relId);

	@Select("""
			SELECT *
			FROM `file`
			WHERE id = #{id}
			""")
	FileDto getFileById(int id);
}

