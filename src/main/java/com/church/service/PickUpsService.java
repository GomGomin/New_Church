//작성자 : 김도영
//최초 작성일 : 23.04.04
package com.church.service;

import java.util.List;
import java.util.Map;

import com.church.domain.PickBoard;


public interface PickUpsService {
	
	int insert(PickBoard pickBoard);
	
	PickBoard detail(String pbwriter);
	
	List<PickBoard> accessList();
	
	List<PickBoard> denyList();
	
	void update(Map<String, Object> pickBoard);
	
	void access(String pbno);
	
	void delete(String pbno);
 
}
