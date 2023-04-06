//작성자 : 심현민
//최초 작성일 : 23.04.04
package com.church.domain;

import lombok.Data;

@Data
public class Board {
	
	private int bno, bview, replyCount;
	
	private String btitle, bcontents, bwriter, date;

	public Board(int bno, int bview, int replyCount, String btitle, String bcontents, String bwriter, String date) {
		this.bno = bno;
		this.bview = bview;
		this.replyCount = replyCount;
		this.btitle = btitle;
		this.bcontents = bcontents;
		this.bwriter = bwriter;
		this.date = date;
	}
	
	public Board() {
		
	}
}
