package com.sgu.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.sgu.domain.UserARole;
import com.sgu.mapper.UserARoleMapper;
import com.sgu.service.UserARoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author huang
 * @date 2020/12/18 20:26
 */
@Service
public class UserARoleServiceImpl extends ServiceImpl<UserARoleMapper, UserARole> implements UserARoleService {

    @Autowired
    private UserARoleMapper userARoleMapper;

    @Override
    public boolean updateUserRoleId(Integer userid, Integer rid, Integer oldroleid) {
        return userARoleMapper.updateUserRoleId(userid,rid,oldroleid);
    }
}
