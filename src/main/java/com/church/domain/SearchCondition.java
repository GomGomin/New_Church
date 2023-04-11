/*
    작성자 : 박지원
    작성일 : 2023-04-08
*/
package com.church.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.util.UriComponentsBuilder;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class SearchCondition {
    private int page = 1;
    private int pageSize = 10;
    //private int offset = 0;
    private String keyword = "";
    private String option = "";
    public int getOffset(){ return (page-1) * pageSize; }
    public String getQueryString(int page){
        return UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .queryParam("pageSize", pageSize)
                .queryParam("option", option)
                .queryParam("keyword", keyword)
                .build().toString();
    }
    public String getQueryString(){
        return getQueryString(page);
    }
    public SearchCondition(int page, int pageSize, String keyword, String option) {
        this.page = page;
        this.pageSize = pageSize;
        this.keyword = keyword;
        this.option = option;
    }
    public SearchCondition(int page, int pageSize) {
        this.page = page;
        this.pageSize = pageSize;
    }
}
