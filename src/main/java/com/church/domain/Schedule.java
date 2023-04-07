/*
    작성자 : 박지원
    작성일 : 2023-04-05
*/

package com.church.domain;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Schedule {
    private int sno;
    private String stitle;
    private String scontents;
    private String swriter;
    private int sview;
    private int replyCount;
    private String date;

    public Schedule(String stitle, String scontents, String swriter) {
        this.stitle = stitle;
        this.scontents = scontents;
        this.swriter = swriter;
    }
}
