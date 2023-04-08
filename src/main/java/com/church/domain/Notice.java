//작성자 : 심현민
//최초 작성일 : 23.04.04
package com.church.domain;

import lombok.Data;

@Data
public class Notice {

    private int nno, nview;
    private String ntitle, ncontents, nwriter, date;
}