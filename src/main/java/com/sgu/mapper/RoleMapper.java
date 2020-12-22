package com.sgu.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.sgu.domain.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author huang
 * @date 2020/12/18 19:07
 */
public interface RoleMapper extends BaseMapper<Role> {
    List<Role> queryRolesByConditions(@Param("roleName") String roleName);

    Role queryOneById(Integer roleid);

}
