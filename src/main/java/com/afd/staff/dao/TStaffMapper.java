package com.afd.staff.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.afd.common.mybatis.Page;
import com.afd.staff.model.TStaff;
import com.afd.staff.model.TStaffExample;

@Repository
public interface TStaffMapper {
	int countByExample(TStaffExample example);

	int deleteByExample(TStaffExample example);

	int deleteByPrimaryKey(Integer staffId);

	int insert(TStaff record);

	int insertSelective(TStaff record);

	List<TStaff> selectByExample(TStaffExample example);

	TStaff selectByPrimaryKey(Integer staffId);

	int updateByExampleSelective(@Param("record") TStaff record,
			@Param("example") TStaffExample example);

	int updateByExample(@Param("record") TStaff record,
			@Param("example") TStaffExample example);

	int updateByPrimaryKeySelective(TStaff record);

	int updateByPrimaryKey(TStaff record);

	List<TStaff> selectAll(@Param("status") Boolean status);

	Page<TStaff> selectAllByPage(@Param("status") Boolean status,
			@Param("page") Page<TStaff> page);

	@Update("update t_staff set status = #{1} where staff_id = #{0}")
	void updateStaffStatus(Integer staffId, Boolean status);

	@Update("update t_staff set password = #{1} where staff_id = #{0}")
	void updateStaffPassword(Integer staffId, String password);

	List<TStaff> queryByConditionsPage(@Param("cond") Map<String, Object> map,
			@Param("page") Page<TStaff> page);
}