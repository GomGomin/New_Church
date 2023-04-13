//작성자 : 김도영
//최초 작성일 : 23.04.04
package com.church.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.church.domain.Weekly;
import com.church.mapper.WeeklyMapper;

@Service
public class WeeklyServiceImpl implements WeeklyService {
	
	@Autowired
	WeeklyMapper weeklyMapper;

	@Override
	public int insert(Map<String, Object> weekly) {
		return weeklyMapper.insert(weekly);
	}

	@Override
	public Weekly detail(String wno) {
		return weeklyMapper.detail(wno);
	}

	@Override
	public Weekly recent() {
		return weeklyMapper.recent();
	}

	@Override
	public List<Weekly> list(int displayPost, int postNum, String searchType, String keyword) {
		return weeklyMapper.list(displayPost, postNum, searchType, keyword);
	}

	@Override
	public int searchCount(String searchType, String keyword) {
		return weeklyMapper.searchCount(searchType, keyword);
	}

	@Override
	public void update(Map<String, Object> weekly) {
		weeklyMapper.update(weekly);
		
	}

	@Override
	public void delete(String wno) {
		weeklyMapper.delete(wno);
		
	}

	@Override
	public void updateView(String wno) {
		weeklyMapper.updateView(wno);
		
	}

	@Override
	public int count() {
		return weeklyMapper.count();
	}

}
