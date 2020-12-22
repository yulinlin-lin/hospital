package com.sgu.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.sgu.domain.Role;
import com.sgu.mapper.RoleMapper;
import com.sgu.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author huang
 * @date 2020/12/18 19:09
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public List<Role> queryRolesByConditions(String rolename) {
        return roleMapper.queryRolesByConditions(rolename);
    }

    @Override
    public Role queryOneById(Integer roleid) {
        return roleMapper.queryOneById(roleid);
    }
}
