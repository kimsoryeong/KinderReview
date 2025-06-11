package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.BoardDao;
import com.example.demo.dto.Board;

@Service
public class BoardService {

	private BoardDao boardDao;
	
	public BoardService(BoardDao boardDao) {
		this.boardDao = boardDao;
	}

	public Board getBoard(int boardId) {
		return this.boardDao.getBoard(boardId);
	}

	public int getBoardIdByName(String boardName) {
	    Board board = boardDao.getBoardByName(boardName);
	    if (board == null) {
	        throw new IllegalArgumentException("존재하지 않는 게시판 이름입니다: " + boardName);
	    }
	    return board.getId();
	}
	
	
}