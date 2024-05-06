package com.nihao.crm.service.user;

import com.nihao.crm.entityClass.user.User;

/**
 * 用户登录接口
 */
public interface UserLogin {
    User byNameAndPasswordQueryUser(String name, String password);
}
