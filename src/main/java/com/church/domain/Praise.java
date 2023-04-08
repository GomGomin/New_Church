/*
    작성자 : 박지원
    작성일 : 2023-04-09
*/

package com.church.domain;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Praise {
    private int pno;
    private String ptitle;
    private int pfile;
    private String pcontents;
    private String pwriter;
    private int plike;
    private int pview;
    private String date;

    public Praise(String ptitle, String pcontents, String pwriter) {
        this.ptitle = ptitle;
        this.pcontents = pcontents;
        this.pwriter = pwriter;
    }
}
