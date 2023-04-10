package com.church.service;

import java.util.List;
import java.util.Map;

import com.church.domain.Albums;


public interface AlbumsService {
	
	int insert(Albums albums);
	
	Albums detail(String ano);
	
	List<Albums> list();
	
	void update(Map<String, Object> albums);
	
	void delete(String ano);

	void updateView(String ano);
	
}
