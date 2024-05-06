package com.nihao.crm.service.user;

import com.nihao.crm.entityClass.user.User;

public interface CreateAccount {
    /**
     * 创建账户
     * @param user com.nihao.crm.entityClass.user.User
     * @return boolean类型的数据, true表示创建成功, false表示创建失败
     */
    boolean createUser(User user);
}
