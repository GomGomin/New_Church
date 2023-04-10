package com.church.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.church.domain.PickBoard;
import com.church.mapper.PickUpsMapper;

@Service
public class PickUpsServiceImpl implements PickUpsService {
	
	@Autowired
	PickUpsMapper pickUpsMapper;

	@Override
	public int insert(PickBoard pickBoard) {
		return pickUpsMapper.insert(pickBoard);
	}

	@Override
	public PickBoard detail(String pbwriter) {
		return pickUpsMapper.detail(pbwriter);
	}

	@Override
	public List<PickBoard> accessList() {
		return pickUpsMapper.accessList();
	}

	@Override
	public List<PickBoard> denyList() {
		return pickUpsMapper.denyList();
	}

	@Override
	public void update(Map<String, Object> pickBoard) {
		pickUpsMapper.update(pickBoard);
	}

	@Override
	public void access(String pbno) {
		pickUpsMapper.access(pbno);
	}

	@Override
	public void delete(String pbno) {
		pickUpsMapper.delete(pbno);
	}
	
	
}
