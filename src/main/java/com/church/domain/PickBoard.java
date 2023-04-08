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
