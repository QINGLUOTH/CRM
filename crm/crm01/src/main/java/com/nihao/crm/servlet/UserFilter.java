package com.nihao.crm.servlet;

import com.nihao.crm.function.Function;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 过滤器, 过滤所有没有登录的用户
 */
@WebFilter("/*")
public class UserFilter extends HttpFilter {
    /**
     * 过滤器, 过滤用户请求
     */
    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
        // 获取用户的请求路径地址
        String userRequestPath = request.getRequestURI();
        // 判断用户访问的是否是index.jsp页面, 如果是, 就发送index.do请求
        if(userRequestPath.equals(request.getContextPath() + "/WEB-INF/crmPages/index.jsp")
        || userRequestPath.equals(request.getContextPath() + "/")){
            response.sendRedirect(request.getContextPath() + "/index.do");
            return;
        }

        if(userRequestPath.equals(request.getContextPath() + "/WEB-INF/crmPages/index.jsp")
                || userRequestPath.equals(request.getContextPath() + "/")
                || userRequestPath.equals(request.getContextPath() + "/index.do")
                || userRequestPath.equals(request.getContextPath() + "/login.do")
                || userRequestPath.equals(request.getContextPath() + "/WEB-INF/crmPages/settings/qx/user/login.jsp")
                || userRequestPath.equals(request.getContextPath() + "/userLogin.do")
                || userRequestPath.equals(request.getContextPath() + "/jquery/bootstrap_3.3.0/css/bootstrap.min.css")
                || userRequestPath.equals(request.getContextPath() + "/jquery/jquery-1.11.1-min.js")
                || userRequestPath.equals(request.getContextPath() + "/jquery/bootstrap_3.3.0/js/bootstrap.min.js")
                || userRequestPath.equals(request.getContextPath() + "/image/IMG_7114.JPG")){
            // 用户访问的地址是index初始页面和登录界面和静态资源时不做限制
            chain.doFilter(request, response);
            return;
        }else if(Function.verificationUserLogin(request)){
            // 判断用户是否登录, 如果用户登录了, 则不做限制
            chain.doFilter(request, response);
            return;
        }
        // 如果用户没有满足以上条件, 就使用重定向重新发送index.do请求
        response.sendRedirect(request.getContextPath() + "/index.do");
    }
}
