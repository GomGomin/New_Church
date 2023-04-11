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
public class PickBoard {
	
	private int pbno, pbstate;
	private String pbaddress, pbtel, pbwriter, date, pbname;
	
}
