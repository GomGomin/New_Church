//작성자 : 심현민
//최초 작성일 : 23.04.04
package com.church.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Board {
	
	private int bno, bview, replyCount;
	
	private String btitle, bcontents, bwriter, date;
	
	public Board() {
		
	}
}
