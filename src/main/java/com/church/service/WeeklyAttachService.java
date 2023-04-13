//작성자 : 김도영
//최초 작성일 : 23.04.04
package com.church.service;

import java.util.List;
import java.util.Map;

import com.church.domain.WeeklyAttach;

public interface WeeklyAttachService {
	
	public List<WeeklyAttach> todayFiles();
	
	public List<WeeklyAttach> allFiles();
	
	public WeeklyAttach oneAttach(int wno);
	
	public List<WeeklyAttach> selectAttachAll(String wno);
	
	public int deleteAttach(String wno);
	
	public int insertAttach(Map<String, Object> weeklyAttach);
	
}
