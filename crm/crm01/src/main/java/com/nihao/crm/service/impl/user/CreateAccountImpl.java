package com.nihao.crm.service.impl.user;

import com.nihao.crm.entityClass.user.User;
import com.nihao.crm.mapper.user.UserMapper;
import com.nihao.crm.service.user.CreateAccount;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * CreateAccount接口的实现类
 */
@Service("createAccount")
public class CreateAccountImpl implements CreateAccount {
    @Autowired
    UserMapper userMapper;

    @Override
    public boolean createUser(User user) {
        int count = userMapper.insertAccount(user);
        return count > 0 ? true : false;
    }
}
