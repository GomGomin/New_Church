//작성자 : 김도영
//최초 작성일 : 23.04.04
package com.church.mapper;

import java.util.List;
import java.util.Map;

import com.church.domain.PickBoard;
import org.apache.ibatis.annotations.Select;

public interface PickUpsMapper {
	
	int insert(PickBoard pickBoard);
	
	PickBoard detail(String pbwriter);
	
	List<PickBoard> accessList();
	
	List<PickBoard> denyList();
	
	void update(Map<String, Object> pickBoard);
	
	void access(String pbno);
	
	void delete(String pbno);
	
	int hasPickupHistory(String pbwriter);

	@Select("SELECT count(*) FROM pickboard")
	int count();
}
