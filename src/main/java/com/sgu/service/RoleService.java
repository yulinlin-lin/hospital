package com.sgu.service;

import com.baomidou.mybatisplus.service.IService;
import com.sgu.domain.Role;

import java.util.List;

/**
 * @author huang
 * @date 2020/12/18 19:08
 */
public interface RoleService extends IService<Role> {

    List<Role> queryRolesByConditions(String rolename);

    Role queryOneById(Integer roleid);

}
