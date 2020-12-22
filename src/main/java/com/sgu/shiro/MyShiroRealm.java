package com.sgu.shiro;

import com.sgu.domain.UserVo;
import com.sgu.domain.Users;
import com.sgu.mapper.UsersMapper;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @author huang
 * @date 2020/12/21 12:44
 */
@Component
@Scope("prototype")
public class MyShiroRealm extends AuthorizingRealm {

    @Autowired
    private UsersMapper usersMapper;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        UserVo uvo = (UserVo)principals.getPrimaryPrincipal();

        List<String> list = usersMapper.queryUsersAllMenus(uvo.getUserid());
        Set<String> set = new HashSet<String>();
        for (String perms : list) {
            if (perms != null && !"".equals(perms)){
                set.add(perms);
            }
        }

        System.out.println(list);
        System.out.println(list);
        System.out.println(list);
        System.out.println(list);
        System.out.println(list);

        SimpleAuthorizationInfo sai = new SimpleAuthorizationInfo();
        sai.addStringPermissions(list);
        sai.setRoles(set);
        return sai;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {

        UsernamePasswordToken token2 = (UsernamePasswordToken) token;
        String no = token2.getUsername();
        Users u =  usersMapper.selectOneByName(no);

        if (u == null) {
            throw new UnknownAccountException("用户名或密码有误！");
        }
        if(u.getStatus() == 1) {
            throw new UnknownAccountException("用户名已被禁用，请联系系统管理员！");
        }

        //		拿到用户在数据库中密码
        String password = u.getPassword();
        UserVo uvo = new UserVo();
        uvo.setUserid(u.getUserid());
        uvo.setNo(u.getNo());
        uvo.setRealname(u.getRealname());
        List<Map<String,Object>> list = usersMapper.queryUsersMenus(u.getUserid());
        uvo.setList(list);

        SimpleAuthenticationInfo sp =
                new SimpleAuthenticationInfo(uvo, password, this.getName());
        return sp;

    }
}
