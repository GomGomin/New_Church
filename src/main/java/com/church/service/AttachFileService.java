//작성자 : 김도영
//최초 작성일 : 23.04.04
package com.church.service;

import java.util.List;
import java.util.Map;

import com.church.domain.AttachFile;

public interface AttachFileService {
	
	public List<AttachFile> todayFiles();
	
	public List<AttachFile> allFiles();

	public AttachFile oneAttach(int ano);
	
	public List<AttachFile> selectAttachAll(String ano);
	
	public int deleteAttach(String ano);
	
	public int insertAttach(Map<String, Object> attachFile);
	
}
