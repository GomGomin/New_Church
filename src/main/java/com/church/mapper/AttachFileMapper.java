package com.church.mapper;

import java.util.List;
import java.util.Map;

import com.church.domain.AttachFile;

public interface AttachFileMapper {
	
	public List<AttachFile> todayFiles();
	
	public List<AttachFile> allFiles();
	
	public AttachFile oneAttach(int ano);
	
	public List<AttachFile> selectAttachAll(String ano);
	
	public int deleteAttach(String ano);
	
	public int insertAttach(Map<String, Object> attachFile);
	
	
	
}
