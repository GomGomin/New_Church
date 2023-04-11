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
public class Worship {
    private int wno;
    private String wtitle;
    private String wfile;
    private String wimg;
    private String wcontents;
    private String wwriter;
    private int wview;
    private String date;

    public Worship(String wtitle, String wcontents, String wwriter) {
        this.wtitle = wtitle;
        this.wcontents = wcontents;
        this.wwriter = wwriter;
    }

}
