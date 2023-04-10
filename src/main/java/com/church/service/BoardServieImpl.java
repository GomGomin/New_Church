//작성자 : 심현민
//최초 작성일 : 23.04.04
package com.church.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.church.domain.Board;
import com.church.mapper.BoardMapper;

@Service
public class BoardServieImpl implements BoardService {

	@Autowired
	BoardMapper boardMapper;

	@Override
	public void newBoard(Board board) {
		boardMapper.newBoard(board);
	}

	@Override
	public int count() {
		return boardMapper.count();
	}
	
	@Override
	public Board boardById(String bno) {
		return boardMapper.boardById(bno);
	}

	@Override
	public void editBoard(Board board) {
		boardMapper.editBoard(board);
	}

	@Override
	public void updateView(String bno) {
		boardMapper.updateView(bno);
	}

	@Override
	public void updateReplyCnt(Object bno) {
		boardMapper.updateReplyCnt(bno);
	}

	@Override
	public void removeBoard(String bno) {
		boardMapper.removeBoard(bno);
	}

	@Override
	public List<Board> list(int displayPost, int postNum, String searchType, String keyword) throws Exception {
		return boardMapper.list(displayPost, postNum, searchType, keyword);
	}

	@Override
	public int searchCount(String searchType, String keyword) throws Exception {
		return boardMapper.searchCount(searchType, keyword);
	}

}
