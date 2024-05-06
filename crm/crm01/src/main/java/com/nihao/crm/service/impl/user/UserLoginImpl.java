package com.nihao.crm.service.impl.user;

import com.nihao.crm.entityClass.user.User;
import com.nihao.crm.mapper.user.UserMapper;
import com.nihao.crm.service.user.UserLogin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * 查询用户信息
 */
@Service("userLogin")
public class UserLoginImpl implements UserLogin {
    @Autowired
    private UserMapper userMapper;
    /**
     * 通过名字和密码查询用户信息
     * @param name 用户名
     * @param password 用户密码
     * @return 返回User类型的数据
     */
    @Override
    public User byNameAndPasswordQueryUser(String name, String password) {
        Map<String, String> map = new HashMap<>();
        map.put("name", name);
        map.put("password", password);
        return userMapper.selectByNameAndPassword(map);
    }
}
