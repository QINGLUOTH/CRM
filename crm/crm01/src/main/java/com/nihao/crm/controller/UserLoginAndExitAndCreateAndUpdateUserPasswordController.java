package com.nihao.crm.controller;

import com.nihao.crm.entityClass.user.AccountCreateInfo;
import com.nihao.crm.entityClass.user.User;
import com.nihao.crm.entityClass.user.UserLoginInfo;
import com.nihao.crm.entityClass.user.ChangePasswordInfo;
import com.nihao.crm.function.Function;
import com.nihao.crm.service.user.CreateAccount;
import com.nihao.crm.service.user.UserPasswordChange;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.*;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * 处理器, 处理用户登录和退出功能和修改密码功能和创建用户功能
 */
@Controller
public class UserLoginAndExitAndCreateAndUpdateUserPasswordController {
    /**
     * 用户登录功能
     */
    @RequestMapping(value = "/userLogin.do")
    @ResponseBody
    public Object returnUserLoginInfo(HttpServletRequest request, HttpServletResponse response, String name, String password, Integer num){
        int number = 0;
        if(num != null){
            number = num;
        }

        UserLoginInfo uli = Function.userLogin(request, response, name, password, number);
        return uli;
    }

    /**
     * 退出登录功能
     */
    @RequestMapping("/exitLogin.do")
    public String exitLogin(HttpServletRequest request, HttpServletResponse response){
        // 获取Session对象
        HttpSession session = request.getSession();
        // 销毁session对象
        session.invalidate();

        // 获取cookie对象
        Cookie[] cookies = request.getCookies();
        if(cookies != null){
            for(Cookie cookie : cookies){
                if(cookie.getName() != null && cookie.getName().equals("userPrimaryId") && cookie.getValue() != null){
                    // 销毁cookie对象
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    return "redirect:/index.do";
                }
            }
        }
        return "redirect:/index.do";
    }

    /**
     * 修改用户密码, 返回json类型的数据
     */
    @RequestMapping("/changePassword.do")
    @ResponseBody
    public Object changeUserPassword(HttpServletRequest request, String password){
        // 获取用户的id
        String userId = (String)request.getSession().getAttribute("userPrimaryId");
        // 获取spring容器
        ApplicationContext ac = Function.returnSpring(request);
        // 获取操作数据库对象
        UserPasswordChange userPasswordChange = (UserPasswordChange)ac.getBean("UserPasswordChange");
        boolean flag = userPasswordChange.changePassword(userId, password);
        return new ChangePasswordInfo(flag);
    }

    /**
     * 处理createAccount.do请求, 创建账户, 返回Objct, 对象中有一个flag属性, 表示用户是否创建成功
     * @param request 请求
     * @param accountName 账户名
     * @param accountPassword 账户密码
     * @param userName 用户名
     * @param email 账户邮箱
     * @param expireTime 最大有效时间
     * @param lockState 状态1表示没有被锁定, 可以使用, 0表示被锁定, 不能使用
     * @param deptno 账户部门名称
     * @param allowIps 允许访问的所有ip地址
     * @return 返回com.nihao.crm.entityClass.AccountCreateInfo对象, springmvc会自动将数据转换为json格式的数据
     */
    @RequestMapping(value = "/createAccount.do")
    @ResponseBody
    public Object createAccount(HttpServletRequest request, HttpSession session, String accountName, String accountPassword, String userName,
                                String email, String expireTime, String lockState, String deptno, String allowIps){
        // 获取spring容器
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("spring");
        // 从spring容器中出去createAccount对象
        CreateAccount createAccount = (CreateAccount)ac.getBean("createAccount");
        // 使用UUID创建用户id
        UUID uuid = UUID.randomUUID();
        String id = uuid.toString().replace("-", "");

        // 获取当前时间时间
        String createAccountDate = Function.returnFormateDateTime(new Date());

        // 调用CreateAccount类中的createUser方法创建账户
        boolean flag = createAccount.createUser(new User(id, accountName, userName, accountPassword, email,
                expireTime, lockState, deptno, allowIps, createAccountDate));

        // 更新用户信息
        if(flag == true){
            List<User> allInfo = Function.getUserAll(ac);
            if(session.getAttribute("allUser") != null){
                session.removeAttribute("allUser");
            }

            session.setAttribute("allUser", allInfo);
        }
        return new AccountCreateInfo(flag);
    }
}
