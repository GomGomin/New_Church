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
	public int insert(Albums albums) {
		return albumsMapper.insert(albums);
	}

	@Override
	public Albums detail(String ano) {
		return albumsMapper.detail(ano);
	}

	@Override
	public List<Albums> list() {
		return albumsMapper.list();
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
	
}
