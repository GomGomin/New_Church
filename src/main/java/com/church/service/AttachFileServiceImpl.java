//작성자 : 김도영
//최초 작성일 : 23.04.04
package com.church.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.church.domain.AttachFile;
import com.church.mapper.AttachFileMapper;

@Service
public class AttachFileServiceImpl implements AttachFileService {
	
	@Autowired
	AttachFileMapper attachFileMapper;

	@Override
	public List<AttachFile> todayFiles() {
		return attachFileMapper.todayFiles();
	}

	@Override
	public List<AttachFile> allFiles() {
		return attachFileMapper.allFiles();
	}

	@Override
	public List<AttachFile> selectAttachAll(String ano) {
		return attachFileMapper.selectAttachAll(ano);
	}

	@Override
	public int deleteAttach(String ano) {
		return attachFileMapper.deleteAttach(ano);
	}

	@Override
	public int insertAttach(Map<String, Object> attachFile) {
		return attachFileMapper.insertAttach(attachFile);
	}

	@Override
	public AttachFile oneAttach(int ano) {
		return attachFileMapper.oneAttach(ano);
	}

}
