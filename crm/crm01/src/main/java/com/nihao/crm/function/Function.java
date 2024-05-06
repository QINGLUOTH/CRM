package com.nihao.crm.function;

import com.nihao.crm.entityClass.activity.Activity;
import com.nihao.crm.entityClass.activity.remark.ActivityRemark;
import com.nihao.crm.entityClass.user.User;
import com.nihao.crm.entityClass.user.UserLoginInfo;
import com.nihao.crm.service.activity.GetAllActivity;
import com.nihao.crm.service.activity.QueryAllDataActivityRemark;
import com.nihao.crm.service.user.ByIdQueryData;
import com.nihao.crm.service.user.QueryAllUser;
import com.nihao.crm.service.user.UserLogin;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.springframework.context.ApplicationContext;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

/**
 * 工具类
 */
public class Function {
    /**
     * 判断用户是否已经登录, 返回值是boolean
     */
    public static boolean verificationUserLogin(HttpServletRequest request){
        // 获取session域中的值
        HttpSession session = request.getSession();
        Object id = session.getAttribute("userPrimaryId");
        if(id != null){
            // 用户已经登录
            return true;
        }

        // 用户没有登录
        return false;
    }

    /**
     * 判断用户输入的密码和用户名是否正确
     * @return 返回UserLoginInfo类型的数据
     */
    public static UserLoginInfo userLogin(HttpServletRequest request, HttpServletResponse response, String name, String password, int number){
        // 获取spring容器
        ApplicationContext ac = returnSpring(request);

        // 查询用户数据
        UserLogin userLogin = (UserLogin) ac.getBean("userLogin");

        User user = userLogin.byNameAndPasswordQueryUser(name, password);

        // 获取用户当前时间
        String userCurrentTime = returnFormateDateTime(new Date());

        // 判断用户是否符合登录要求
        UserLoginInfo userLoginInfo = isCorrect(request, user, userCurrentTime);

        // 判断用户是否登录成功
        if(userLoginInfo.isLoginInfo() == false){
            return userLoginInfo;
        }

        // 用户名和用户密码正确, 登录最大时间没有过期, 该账户没有被封
        // 创建session域, 向session域中添加id
        HttpSession session = request.getSession();
        session.setAttribute("userPrimaryId", user.getId());

        // 判断用户是否要十天之内免登录
        if(number == 1){
            // 创建cookie对象
            Cookie cookie = new Cookie("userPrimaryId", user.getId());
            cookie.setMaxAge(60 * 60 * 24 * 10);
            cookie.setPath("/");
            response.addCookie(cookie);
        }

        // 将查询的用户数据存放在Session域中
        session.setAttribute("userData", user);
        return new UserLoginInfo("登录成功", true);
    }

    /**
     * 判断用户是否可以登录
     * @return true表示可以登录, false表示不可以登录
     */
    public static UserLoginInfo isCorrect(HttpServletRequest request, User user, String userCurrentTime){
        if(user == null){
            // 登录失败, 用户名或密码错误
            return new UserLoginInfo("登录失败, 用户名或密码错误", false);
        }else if(user.getExpireTime() != null && userCurrentTime.compareTo(user.getExpireTime()) > 0){
            // 用户最大的登录日期已过, 无法登录
            return new UserLoginInfo("用户最大的登录日期已过, 无法登录", false);
        }else if(user.getAllowIps() != null && !(user.getAllowIps().contains(request.getRemoteAddr()))){
            // 用户ip地址受限, 无法登录
            return new UserLoginInfo("用户ip地址受限, 无法登录", false);
        }else if(user.getLockState() != null && user.getLockState().equals("0")){
            // 用户账号被锁定
            return new UserLoginInfo("该账号已被锁定, 无法登录", false);
        }
        return new UserLoginInfo("登录成功", true);
    }

    /**
     * 判断用户是否有十天之内免登录或已经登录
     * @return 返回boolean类型的数据
     */
    public static boolean isLogin(HttpServletRequest request){
        if(request.getSession().getAttribute("userPrimaryId") != null){
            return true;
        }

        Cookie[] cookies = request.getCookies();
        if(cookies != null){
            for(int i = 0; i < cookies.length; i++){
                Cookie cookie = cookies[i];
                if(cookie.getName() != null && cookie.getName().equals("userPrimaryId") && cookie.getValue() != null){
                    User user = byIdQueryDate(request, cookie.getValue());
                    UserLoginInfo userLoginInfo = isCorrect(request, user, returnFormateDateTime(new Date()));
                    if(userLoginInfo.isLoginInfo() == false){
                        return false;
                    }
                    // 获取session对象, 向session域中存放id
                    request.getSession().setAttribute("userPrimaryId", cookie.getValue());
                    return true;
                }
            }
        }

        return false;
    }

    /**
     * 获取spring容器
     * @return ApplicationContext
     */
    public static ApplicationContext returnSpring(HttpServletRequest request){
        // 获取spring容器
        ServletContext context = request.getServletContext();
        return (ApplicationContext) context.getAttribute("spring");
    }

    /**
     * 格式化时间, 返回String类型的数据, 格式: yyyy-MM-dd HH-mm-ss
     * @return String类型的数据
     */
    public static String returnFormateDateTime(Date date){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
        return sdf.format(date);
    }

    /**
     * 获取当前登录用户的信息
     */
    public static User returnUserData(HttpServletRequest request){
        // 获取用户id
        String userId = (String)request.getSession().getAttribute("userPrimaryId");
        // 获取spring容器
        ApplicationContext ac = Function.returnSpring(request);
        ByIdQueryData byIdQueryData = (ByIdQueryData)ac.getBean("ByIdQueryData");
        // 查询数据
        return byIdQueryData.queryDate(userId);
    }

    /**
     * 通过用户id查询用户数据
     */
    public static User byIdQueryDate(HttpServletRequest request, String id){
        // 获取spring容器
        ApplicationContext ac = Function.returnSpring(request);
        ByIdQueryData byIdQueryData = (ByIdQueryData)ac.getBean("ByIdQueryData");
        // 查询数据
        return byIdQueryData.queryDate(id);
    }

    /**
     * 获取全部用户信息
     */
    public static List<User> getUserAll(ApplicationContext ac){
        QueryAllUser queryUser = (QueryAllUser) ac.getBean("QueryAllUser");
        List<User> allInfo = queryUser.queryAll();
        return allInfo;
    }

    /**
     * 获取所有活动的信息
     */
    public static List<Activity> getAllActivity(HttpServletRequest request){
        // 获取spring容器
        ApplicationContext ac = (ApplicationContext)request.getServletContext().getAttribute("spring");
        GetAllActivity getAllInfo = (GetAllActivity)ac.getBean("getAllActivity");
        return getAllInfo.getAllActivityInfo();
    }

    /**
     * 获取所有活动备注信息
     */
    public static List<ActivityRemark> getAllActivityRemark(HttpServletRequest request){
        // 获取spring容器
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("spring");
        QueryAllDataActivityRemark queryAllDataActivityRemark = (QueryAllDataActivityRemark)ac.getBean("queryAllDataActivityRemark");
        return queryAllDataActivityRemark.queryAllActivityRemark();
    }

    /**
     * 将字符串通过,分割成数组
     */
    public static String[] splitString(String str){
        // 获取每个活动的id
        String[] strings = null;
        try{
            strings = str.split(",");
        }catch(Exception e){
            strings = new String[1];
            strings[0] = str;
        }
        return strings;
    }

    /**
     * 通过正则表达式, 判断字符串是否符合要求
     * true表示符合要求, false表示不符合要求, 出现异常的时候返回的是false
     */
    public static boolean isJudgeStringAccordWithRequirement(String regExp, String data){
        Pattern pattern = null;
        try {
            pattern = Pattern.compile(regExp);
        }catch(Exception e){
            return false;
        }
        return pattern.matcher(data).matches();
    }

    /**
     * 判断除日期格式外的数据类型, 获取除日期格式外的数据, 返回String类型的数据
     */
    public static String judgeCellDataType(HSSFRow row, int cellNumber) throws Exception{
        String data = null;

        // 判断cell是否为空
        if(row.getCell(cellNumber) == null){
            data = "";
            return data;
        }

        // 判断data是什么类型的数据
        if(row.getCell(cellNumber).getCellType() == HSSFCell.CELL_TYPE_STRING){
            // 字符串类型
            data  = row.getCell(cellNumber).getStringCellValue();
        }else if(row.getCell(cellNumber).getCellType() == HSSFCell.CELL_TYPE_NUMERIC){
            // double类型
            data = String.valueOf(row.getCell(cellNumber).getNumericCellValue());
        }else if(row.getCell(cellNumber).getCellType() == HSSFCell.CELL_TYPE_BOOLEAN){
            // boolean类型
            data = String.valueOf(row.getCell(cellNumber).getNumericCellValue());
        }else if(row.getCell(cellNumber).getCellType() == HSSFCell.CELL_TYPE_BLANK){
            // 数据为空
            data = "";
        }
        return data;
    }

    /**
     * 获取日期ss
     * @return String类型的数据
     */
    public static String getDateData(HSSFRow row, int cellNumber, SimpleDateFormat sdf){
        String date = "";
        try {
            try {
                date = sdf.format(row.getCell(cellNumber).getDateCellValue());
            } catch (Exception e) {
                date = row.getCell(cellNumber).getStringCellValue();
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return date;
    }
}