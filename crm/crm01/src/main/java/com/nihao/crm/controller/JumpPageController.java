package com.nihao.crm.controller;

import com.nihao.crm.entityClass.activity.Activity;
import com.nihao.crm.entityClass.activity.remark.ActivityRemark;
import com.nihao.crm.entityClass.clue.Clue;
import com.nihao.crm.entityClass.user.User;
import com.nihao.crm.function.Function;
import com.nihao.crm.service.activity.QueryActivity;
import com.nihao.crm.service.activity.QueryActivityRemarkData;
import com.nihao.crm.service.clue.ClueService;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 页面跳转处理器
 */
@Controller
public class JumpPageController {
    /**
     * 实现用户免登录功能, 如果用户没有设置免登录
     * 跳转界面到index界面
     */
    @RequestMapping(value = "/index.do")
    public String jumpIndex(HttpServletRequest request){
        // 判断用户是否有十天之内免登录或已经登录
        if(Function.isLogin(request)){
            return "redirect:/workbench/index.do";
        }

        return "index";
    }

    /**
     * 跳转到login页面上
     * @return 返回String类型的数据
     */
    @RequestMapping(value = "/login.do")
    public String jumpLoginPage(HttpServletRequest request){
        // 判断用户是否有十天之内免登录或已经登录
        if(Function.isLogin(request)){
            return "redirect:/workbench/index.do";
        }

        return "settings/qx/user/login";
    }

    /**
     * 处理WEB-INF/crmPages/workbench/index.jsp页面无法跳转问题
     * @return 返回String类型的数据
     */
    @RequestMapping(value = "/workbench/index.do")
    public String jumpWorkbenchIndex(HttpServletRequest request, HttpSession session){
        // 判断session是否有userData对象和allUser对象和getAllActivityInfo对象和allActivityRemark对象
        Object userData = session.getAttribute("userData");
        Object allUser = session.getAttribute("allUser");
        if(userData != null && allUser != null){
            return "workbench/index";
        }

        // session域中没有user对象, 向存放user对象
        User user = Function.returnUserData(request);
        session.setAttribute("userData", user);

        // 查询所有用户信息, 向session域中存储所有用户信息
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("spring");
        List<User> allInfo = Function.getUserAll(ac);
        session.setAttribute("allUser", allInfo);
        return "workbench/index";
    }

    /**
     * 处理workbench/main/index页面无法在浏览器直接发送请求响应问题
     */
    @RequestMapping(value = "/main/index.do")
    public String jumpMainIndexPage(){
        return "workbench/main/index";
    }

    /**
     * 处理workbench/activity/index页面无法在浏览器直接发送请求响应问题
     */
    @RequestMapping(value = "/activity/index.do")
    public String jumpActivityIndexPage(HttpServletRequest request, HttpSession session){
        return "workbench/activity/index";
    }

    /**
     * 处理workbench/clue/index页面无法在浏览器直接发送请求响应问题
     */
    @RequestMapping(value = "/clue/index.do")
    public String jumpClueIndexPage(){
        return "workbench/clue/index";
    }

    /**
     * 处理workbench/customer/index页面无法在浏览器直接发送请求响应问题
     */
    @RequestMapping(value = "/customer/index.do")
    public String jumpCustomerIndexPage(){
        return "workbench/customer/index";
    }

    /**
     * 处理workbench/contacts/index页面无法在浏览器直接发送请求响应问题
     */
    @RequestMapping(value = "/contacts/index.do")
    public String jumpContactsIndexPage(){
        return "workbench/contacts/index";
    }

    /**
     * 处理workbench/transaction/index页面无法在浏览器直接发送请求响应问题
     */
    @RequestMapping(value = "/transaction/index.do")
    public String jumpTransactionIndexPage(){
        return "workbench/transaction/index";
    }

    /**
     * 处理settings/index页面无法在浏览器直接发送请求响应问题
     */
    @RequestMapping(value = "/settings/index.do")
    public String jumpSettingsIndexPage(){
        return "settings/index";
    }

    /**
     * 处理settings/qx/index页面无法在浏览器直接发送请求响应问题
     */
    @RequestMapping(value = "/qx/index.do")
    public String jumpSettingsQxIndexPage(){
        return "settings/qx/index";
    }

    /**
     * 处理permission/index页面无法在浏览器直接发送请求响应问题
     */
    @RequestMapping(value = "/permission/index.do")
    public String jumpPermissionIndexPage(){
        return "settings/qx/permission/index";
    }

    /**
     * 处理role/index页面无法在浏览器直接发送请求响应问题
     */
    @RequestMapping(value = "role/index.do")
    public String jumpRoleIndexPage(){
        return "settings/qx/role/index";
    }

    /**
     * 处理user/index页面无法在浏览器直接发送请求响应问题
     */
    @RequestMapping(value = "user/index.do")
    public String jumpUserIndexPage(){
        return "settings/qx/user/index";
    }

    /**
     * 跳转页面到workbench/detail.jsp
     * 接受workbench/activity/detail.do请求
     */
    @RequestMapping(value = "/activity/detail.do")
    public String jumpWorkbenchDetail(HttpServletRequest request, HttpSession session, String id){
        // 获取spring容器
        ServletContext context = request.getServletContext();
        ApplicationContext ac = (ApplicationContext)context.getAttribute("spring");
        // 查询活动备注信息
        QueryActivityRemarkData queryActivityRemarkData = (QueryActivityRemarkData)ac.getBean("queryActivityRemarkData");
        // 查询活动信息
        QueryActivity queryActivity = (QueryActivity) ac.getBean("queryActivity");
        Map<String, String> map = new HashMap<String, String>();
        map.put("id", id);
        Activity activity = (Activity)queryActivity.byIdQueryActivity(map);
        List<ActivityRemark> activityRemarks = (List<ActivityRemark>) queryActivityRemarkData.byIdQueryActivityRemark(map);
        // 向request域中存储数据
        request.setAttribute("activity", activity);
        request.setAttribute("activityRemarks", activityRemarks);
        return "forward:/WEB-INF/crmPages/workbench/activity/detail.jsp";
    }

    /**
     * 处理/workbench/clue/detail.do请求, 解决/workbench/clue/detail.jsp页面无法跳转问题
     */
    @RequestMapping(value = "/workbench/clue/detail.do")
    public String jumpWorkbenchClueDetailPage(HttpServletRequest request, String id){
        // 通过线索id, 获取线索信息
        // 获取spring容器
        ApplicationContext ac = Function.returnSpring(request);
        ClueService clueService = (ClueService)ac.getBean("clueService");
        Clue clue = clueService.selectClueById(id);
        // 将clue数据存放在request域中
        request.setAttribute("clue", clue);
        return "/workbench/clue/detail";
    }
}