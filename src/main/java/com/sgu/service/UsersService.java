package com.sgu.service;

import com.baomidou.mybatisplus.service.IService;
import com.sgu.domain.Users;

import java.util.List;

/**
 * @author huang
 * @date 2020/12/8 22:43
 */
public interface UsersService extends IService<Users> {
    List<Users> queryUsersByCondition(String realname);

    Users queryOneById(Integer userid);
}
