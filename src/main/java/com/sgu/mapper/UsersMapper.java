package com.sgu.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.sgu.domain.Users;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author huang
 * @date 2020/12/8 22:43
 */
public interface UsersMapper extends BaseMapper<Users> {

    List<Users> queryUsersByCondition(@Param("realname") String realname);

    Users queryOneById(Integer userid);

    Users selectOneByName(String username);

    List<Map<String, Object>> queryUsersMenus(Integer userid);

    List<String> queryUsersAllMenus(Integer userid);

}
