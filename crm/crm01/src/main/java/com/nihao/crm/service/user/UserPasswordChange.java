package com.nihao.crm.service.user;

/**
 * 用户密码修改
 */
public interface UserPasswordChange {
    boolean changePassword(String id, String password);
}
