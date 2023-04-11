//작성자 : 김도영
//최초 작성일 : 23.04.04
package com.church.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.church.domain.Albums;

public interface AlbumsMapper {
	
	int insert(Map<String, Object> albums);
	
	Albums detail(String ano);
	
	Albums recent();
	
	public List<Albums> list(@Param("displayPost") int displayPost, @Param("postNum") int postNum, @Param("searchType") String searchType, @Param("keyword") String keyword);
	
	public int searchCount(@Param("searchType") String searchType, @Param("keyword") String keyword);
	
	void update(Map<String, Object> albums);
	
	void delete(String ano);
	
	void updateView(String ano);

}
