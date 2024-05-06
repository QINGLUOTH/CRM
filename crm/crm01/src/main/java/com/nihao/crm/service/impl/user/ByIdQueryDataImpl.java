package com.nihao.crm.service.impl.user;

import com.nihao.crm.entityClass.user.User;
import com.nihao.crm.mapper.user.UserMapper;
import com.nihao.crm.service.user.ByIdQueryData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("ByIdQueryData")
public class ByIdQueryDataImpl implements ByIdQueryData {
    @Autowired
    UserMapper userMapper;

    /**
     * 通过id查询用户数据
     * @param id String类型的数据
     * @return User类型的数据
     */
    @Override
    public User queryDate(String id) {
        return userMapper.byIdQueryData(id);
    }
}
