package com.church.service;

import java.util.List;
import java.util.Map;

import com.church.domain.Albums;


public interface AlbumsService {
	
	int insert(Map<String, Object> albums);
	
	Albums detail(String ano);

	Albums recent();
	
	public List<Albums> list(int displayPost, int postNum, String searchType, String keyword) throws Exception;
	
	public int searchCount(String searchType, String keyword) throws Exception;
	
	void update(Map<String, Object> albums);
	
	void delete(String ano);

	void updateView(String ano);
	
}
