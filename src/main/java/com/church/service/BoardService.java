//작성자 : 심현민
//최초 작성일 : 23.04.04
package com.church.service;

import java.util.List;

import com.church.domain.Board;

public interface BoardService {
	
	void newBoard(Board board);
	
	int count();
	
	public List<Board> list(int displayPost, int postNum, String searchType, String keyword) throws Exception;
	
	public int searchCount(String searchType, String keyword) throws Exception;
	
	Board boardById(String bno);

	void editBoard(Board board);
	
	void updateView(String bno);
	
	void updateReplyCnt(Object reply);
	
	void removeBoard(String bno); 
}
