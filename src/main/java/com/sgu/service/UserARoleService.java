package com.sgu.service;

import com.baomidou.mybatisplus.service.IService;
import com.sgu.domain.UserARole;

/**
 * @author huang
 * @date 2020/12/18 20:25
 */
public interface UserARoleService extends IService<UserARole> {
    boolean updateUserRoleId(Integer userid, Integer rid, Integer oldroleid);

}
