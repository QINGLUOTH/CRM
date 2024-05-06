package com.nihao.crm.service.impl.user;

import com.nihao.crm.entityClass.user.User;
import com.nihao.crm.mapper.user.UserMapper;
import com.nihao.crm.service.user.QueryAllUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * QueryAllUser接口的实现类
 */
@Service("QueryAllUser")
public class QueryAllUserImpl implements QueryAllUser {
    @Autowired
    UserMapper userMapper;

    @Override
    public List<User> queryAll() {
        return userMapper.selectAllUser();
    }
}
