package com.sgu.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.sgu.domain.Users;
import com.sgu.mapper.UsersMapper;
import com.sgu.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author huang
 * @date 2020/12/8 22:43
 */
@Service
public class UsersServiceImpl extends ServiceImpl<UsersMapper, Users> implements UsersService {

    @Autowired
    private UsersMapper usersMapper;

    @Override
    public List<Users> queryUsersByCondition(String realname) {
        return usersMapper.queryUsersByCondition(realname);
    }

    @Override
    public Users queryOneById(Integer userid) {
        return usersMapper.queryOneById(userid);
    }
}
