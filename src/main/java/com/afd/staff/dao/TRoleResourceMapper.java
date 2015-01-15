package com.afd.staff.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.afd.staff.model.TRoleResource;
import com.afd.staff.model.TRoleResourceExample;

@Repository
public interface TRoleResourceMapper {
	int countByExample(TRoleResourceExample example);

	int deleteByExample(TRoleResourceExample example);

	int deleteByPrimaryKey(Integer id);

	int insert(TRoleResource record);

	int insertSelective(TRoleResource record);

	List<TRoleResource> selectByExample(TRoleResourceExample example);

	TRoleResource selectByPrimaryKey(Integer id);

	int updateByExampleSelective(@Param("record") TRoleResource record,
			@Param("example") TRoleResourceExample example);

	int updateByExample(@Param("record") TRoleResource record,
			@Param("example") TRoleResourceExample example);

	int updateByPrimaryKeySelective(TRoleResource record);

	int updateByPrimaryKey(TRoleResource record);
}