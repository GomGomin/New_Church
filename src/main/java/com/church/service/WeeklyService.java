//작성자 : 김도영
//최초 작성일 : 23.04.04
package com.church.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.church.domain.Weekly;

public interface WeeklyService {
	
	int insert(Map<String, Object> weekly);
	
	Weekly detail(String wno);
	
	Weekly recent();
	
	public List<Weekly> list(@Param("displayPost") int displayPost, @Param("postNum") int postNum, @Param("searchType") String searchType, @Param("keyword") String keyword);
	
	public int searchCount(@Param("searchType") String searchType, @Param("keyword") String keyword);
	
	void update(Map<String, Object> weekly);
	
	void delete(String wno);
	
	void updateView(String wno);

}
