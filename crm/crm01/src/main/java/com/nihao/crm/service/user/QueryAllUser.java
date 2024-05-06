package com.nihao.crm.service.user;

import com.nihao.crm.entityClass.user.User;

import java.util.List;

public interface QueryAllUser {
    /**
     * 查询所有用户信息
     * @return List<User>类型的数据
     */
    List<User> queryAll();

}
