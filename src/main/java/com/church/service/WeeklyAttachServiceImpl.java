//작성자 : 김도영
//최초 작성일 : 23.04.04
package com.church.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.church.domain.WeeklyAttach;
import com.church.mapper.WeeklyAttachMapper;

@Service
public class WeeklyAttachServiceImpl implements WeeklyAttachService {
	
	@Autowired
	WeeklyAttachMapper WeeklyAttachMapper;

	@Override
	public List<WeeklyAttach> todayFiles() {
		return WeeklyAttachMapper.todayFiles();
	}

	@Override
	public List<WeeklyAttach> allFiles() {
		return WeeklyAttachMapper.allFiles();
	}

	@Override
	public WeeklyAttach oneAttach(int wno) {
		return WeeklyAttachMapper.oneAttach(wno);
	}

	@Override
	public List<WeeklyAttach> selectAttachAll(String wno) {
		return WeeklyAttachMapper.selectAttachAll(wno);
	}

	@Override
	public int deleteAttach(String wno) {
		return WeeklyAttachMapper.deleteAttach(wno);
	}

	@Override
	public int insertAttach(Map<String, Object> weeklyAttach) {
		return WeeklyAttachMapper.insertAttach(weeklyAttach);
	}



}
