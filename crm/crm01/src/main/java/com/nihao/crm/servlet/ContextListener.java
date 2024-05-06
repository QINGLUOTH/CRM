package com.nihao.crm.servlet;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.ContextLoaderListener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.annotation.WebListener;
import java.io.File;

/**
 * Context域监听器
 */
@WebListener
public class ContextListener extends ContextLoaderListener {
    /**
     * 该方法在context域创建时调用, 创建spring容器, 并将容器放在context域中
     * @param event ServletContextEvent类型的数据
     */
    @Override
    public void contextInitialized(ServletContextEvent event) {
        // 获取spring容器
        ApplicationContext ac = new ClassPathXmlApplicationContext("applicationTransaction.xml");
        // 将spring容器存放在Context域中
        ServletContext context = event.getServletContext();
        context.setAttribute("spring", ac);
    }
}
