/**
 * 
 */
package com.afd.staff.dao.extend;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.afd.staff.model.TResource;

/**
 * 
 * 雇员权限Dao
 * 
 * @author xuzunyuan
 * @date 2013年12月25日
 */
@Repository
public interface TStaffPrivilegeMapper {
	/**
	 * 查询雇员所有权限，结果按照显示顺序排序
	 * 
	 * @param staffId
	 * @return
	 */
	List<TResource> selectStaffPrivelege(Integer staffId);
}
