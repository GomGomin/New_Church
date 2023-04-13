//작성자 : 김도영
//최초 작성일 : 23.04.04
package com.church.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.church.domain.Albums;
import com.church.mapper.AlbumsMapper;

@Service
public class AlbumsServiceImpl implements AlbumsService {
	
	@Autowired
	AlbumsMapper albumsMapper;

	@Override
	public int insert(Map<String, Object> albums) {
		return albumsMapper.insert(albums);
	}

	@Override
	public Albums detail(String ano) {
		return albumsMapper.detail(ano);
	}

	@Override
	public Albums recent() {
		return albumsMapper.recent();
	}

	@Override
	public List<Albums> list(int displayPost, int postNum, String searchType, String keyword) throws Exception {
		return albumsMapper.list(displayPost, postNum, searchType, keyword);
	}

	@Override
	public int searchCount(String searchType, String keyword) throws Exception {
		return albumsMapper.searchCount(searchType, keyword);
	}

	@Override
	public void update(Map<String, Object> albums) {
		albumsMapper.update(albums);
	}

	@Override
	public void delete(String ano) {
		albumsMapper.delete(ano);
	}

	@Override
	public void updateView(String ano) {
		albumsMapper.updateView(ano);
	}

	@Override
	public int count() {
		return albumsMapper.count();
	}

}
