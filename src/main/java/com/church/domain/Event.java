/*
    작성자 : 박지원
    작성일 : 2023-04-10
*/

package com.church.domain;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Event {
    private int eno;
    private String etitle;
    private String efile;
    private String eimg;
    private String econtents;
    private String ewriter;
    private int eview;
    private String date;

    public Event(String etitle, String econtents, String ewriter) {
        this.etitle = etitle;
        this.econtents = econtents;
        this.ewriter = ewriter;
    }

}
