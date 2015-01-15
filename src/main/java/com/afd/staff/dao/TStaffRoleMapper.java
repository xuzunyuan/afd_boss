package com.afd.staff.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.afd.staff.model.TStaffRole;
import com.afd.staff.model.TStaffRoleExample;

@Repository
public interface TStaffRoleMapper {
	int countByExample(TStaffRoleExample example);

	int deleteByExample(TStaffRoleExample example);

	int deleteByPrimaryKey(Integer id);

	int insert(TStaffRole record);

	int insertSelective(TStaffRole record);

	List<TStaffRole> selectByExample(TStaffRoleExample example);

	TStaffRole selectByPrimaryKey(Integer id);

	int updateByExampleSelective(@Param("record") TStaffRole record,
			@Param("example") TStaffRoleExample example);

	int updateByExample(@Param("record") TStaffRole record,
			@Param("example") TStaffRoleExample example);

	int updateByPrimaryKeySelective(TStaffRole record);

	int updateByPrimaryKey(TStaffRole record);
}