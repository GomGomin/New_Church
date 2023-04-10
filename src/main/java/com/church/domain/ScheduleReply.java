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
public class ScheduleReply {
    private int rno;
    private int sno;
    private String rwriter;
    private String rcontents;
    private String date;
    private String rupdate;

    public ScheduleReply(int sno, String rwriter, String rcontents) {
        this.sno = sno;
        this.rwriter = rwriter;
        this.rcontents = rcontents;
    }
}
