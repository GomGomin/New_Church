//작성자 : 심현민
//최초 작성일 : 23.04.04
package com.church.domain;

import lombok.Data;

@Data
public class Reply {

	private int rno, bno, sno;
	
	private String rwriter, rcontents, date, rupdate;

	public Reply(int rno, int bno, int sno, String rwriter, String rcontents, String date, String rupdate) {
		this.rno = rno;
		this.bno = bno;
		this.sno = sno;
		this.rwriter = rwriter;
		this.rcontents = rcontents;
		this.date = date;
		this.rupdate = rupdate;
	}
	
	public Reply() {
		
	}
}
