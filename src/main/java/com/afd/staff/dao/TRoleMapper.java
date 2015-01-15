package com.afd.staff.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.afd.common.mybatis.Page;
import com.afd.staff.model.TRole;
import com.afd.staff.model.TRoleExample;

@Repository
public interface TRoleMapper {
	int countByExample(TRoleExample example);

	int deleteByExample(TRoleExample example);

	int deleteByPrimaryKey(Integer roleId);

	int insert(TRole record);

	int insertSelective(TRole record);

	List<TRole> selectByExample(TRoleExample example);

	TRole selectByPrimaryKey(Integer roleId);

	int updateByExampleSelective(@Param("record") TRole record,
			@Param("example") TRoleExample example);

	int updateByExample(@Param("record") TRole record,
			@Param("example") TRoleExample example);

	int updateByPrimaryKeySelective(TRole record);

	int updateByPrimaryKey(TRole record);

	List<TRole> selectAll();

	List<TRole> selectAllByPage(@Param("page") Page<TRole> page);

	@Update("update t_role set status = #{1} where role_id = #{0}")
	void updateRoleStatus(Integer roleId, Boolean status);
}