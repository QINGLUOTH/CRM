package com.nihao.crm.service.impl.user;

import com.nihao.crm.mapper.user.UserMapper;
import com.nihao.crm.service.user.UserPasswordChange;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service("UserPasswordChange")
public class UserPasswordChangeImpl implements UserPasswordChange {
    @Autowired
    UserMapper userMapper;

    @Override
    public boolean changePassword(String id, String password) {
        Map<String, String> map = new HashMap<>();
        map.put("id", id);
        map.put("password", password);
        int number = userMapper.byIdChangePassword(map);
        return number > 0 ? true : false;
    }
}
