package com.church.mapper;

import java.util.List;
import java.util.Map;

import com.church.domain.PickBoard;

public interface PickUpsMapper {
	
	int insert(PickBoard pickBoard);
	
	PickBoard detail(String pbwriter);
	
	List<PickBoard> accessList();
	
	List<PickBoard> denyList();
	
	void update(Map<String, Object> pickBoard);
	
	void access(String pbno);
	
	void delete(String pbno);

}