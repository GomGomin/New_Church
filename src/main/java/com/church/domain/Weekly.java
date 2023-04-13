//작성자 : 김도영
//최초 작성일 : 23.04.04
package com.church.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Weekly {
	
	private int wno, wview;
	private String wtitle, wwriter, date;

}