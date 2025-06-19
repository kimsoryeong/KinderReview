package com.example.demo.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.demo.dto.Member;

@Mapper
public interface MemberDao {

	@Insert("""
		INSERT INTO `member`
		SET regDate = NOW()
			, updateDate = NOW()
			, loginId = #{loginId}
			, loginPw = #{loginPw}
			, nickname = #{nickname}
			, authLevel = 1  
	""")
	void joinPersonalMember(@Param("loginId") String loginId, @Param("loginPw") String loginPw, @Param("nickname") String nickname);
	
	@Insert("""
	        INSERT INTO `member`
	        SET regDate = NOW()
	            , updateDate = NOW()
	            , loginId = #{loginId}
	            , loginPw = #{loginPw}
	            , institutionName = #{institutionName}
	            , institutionNumber = #{institutionNumber}
	            , authLevel = 2
	    """)
	    @Options(useGeneratedKeys = true, keyProperty = "id") 
	    void joinInstitutionMember(Member member);
	
	@Select("""
		SELECT * FROM `member`
		WHERE loginId = #{loginId}
	""")
	Member getMemberByLoginId(String loginId);

	@Select("""
		SELECT * FROM `member`
		WHERE nickname = #{nickname}
	""")
	Member getMemberBynickname(String nickname);
	
	@Select("""
		    SELECT *
		    FROM member
		    WHERE id = #{id}
		""")
		Member getMemberById(@Param("id") int id);


}