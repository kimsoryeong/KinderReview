package com.example.demo.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.dto.Board;

@Mapper
public interface BoardDao {
	
	@Select("""
			SELECT *
				FROM board
				WHERE id = #{boardId} 
			""")
	Board getBoard(int boardId);
	
	 @Select("""
		        SELECT * 
	 		    	FROM board 
	 		    	WHERE boardName = #{boardName}
		    """)
	Board getBoardByName(String boardName);
}