package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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
			, approveStatus = 1
			, authLevel = 1  
	""")
	void joinPersonalMember(@Param("loginId") String loginId, @Param("loginPw") String loginPw, @Param("nickname") String nickname);
	
	@Insert("""
	        INSERT INTO `member`
	        SET regDate = NOW()
	            , updateDate = NOW()
	            , loginId = #{loginId}
	            , loginPw = #{loginPw}
	            , nickname = #{nickname}
	            , institutionNumber = #{institutionNumber}
	            , approveStatus = 0
	            , authLevel = 2
	    """)
	    @Options(useGeneratedKeys = true, keyProperty = "id") 
	    void joinInstitutionMember(Member member);
	
	@Select("""
		    SELECT m.*, 
		           (SELECT id FROM file WHERE relTypeCode = 'member' AND relId = m.id LIMIT 1) AS workChkFileId
		    FROM member m
		    WHERE loginId = #{loginId}
		""")
		Member getMemberByLoginId(String loginId);

	@Select("""
		    SELECT m.*, 
		           (SELECT id FROM file WHERE relTypeCode = 'member' AND relId = m.id LIMIT 1) AS workChkFileId
		    FROM member m
		    WHERE id = #{id}
		""")
		Member getMemberById(@Param("id") int id);



	@Select("""
			SELECT * FROM `member`
			WHERE nickname = #{nickname}
		""")
		Member getMemberBynickname(String nickname);
	
	@Select("""
		    SELECT id
		    FROM file
		    WHERE relTypeCode = 'member' AND relId = #{memberId}
		    LIMIT 1
		""")
		Integer findWorkChkFileByMemberId(@Param("memberId") int memberId);
	
	
	@Select("""
		    SELECT *
		    FROM member
		    WHERE authLevel = 2
		      AND approveStatus = 0
		    ORDER BY regDate DESC
		""")
		List<Member> getPendingInstitutions();

	@Update("""
	        UPDATE member
	        SET approveStatus = #{approveStatus},
	            updateDate = NOW()
	        WHERE id = #{memberId}
	    """)
	    void updateApproveStatus(@Param("memberId") int memberId, @Param("approveStatus") int approveStatus);


	@Update("""
		    UPDATE member
		    SET workChkFile = #{savedName},
		     updateDate = NOW()
		    WHERE id = #{memberId}
		""")
		void updateWorkChkFile(@Param("memberId") int memberId, @Param("savedName") String savedName);

	


}