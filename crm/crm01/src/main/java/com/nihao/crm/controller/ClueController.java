package com.nihao.crm.controller;

import com.nihao.crm.entityClass.clue.Clue;
import com.nihao.crm.entityClass.clue.ClueInfo;
import com.nihao.crm.entityClass.user.User;
import com.nihao.crm.function.Function;
import com.nihao.crm.service.clue.ClueService;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * 线索功能处理器
 */
@Controller
public class ClueController {
    /**
     * 处理器方法, 处理queryClue.do请求, 查询线索数据
     * @param request 请求
     * @param clueName 名称
     * @param clueCompany 线索公司
     * @param companyLandline 公司座机
     * @param clueSource 线索源
     * @param clueOwner 线索所有人
     * @param mobilePhone 手机
     * @param clueState 线索状态
     * @return json格式的字符串
     */
    @RequestMapping(value = "/queryClue.do")
    @ResponseBody
    public Object clueQuery(HttpServletRequest request, String clueName, String clueCompany, String companyLandline, String clueSource, String clueOwner,
                            String mobilePhone, String clueState, Integer pageNumber){
        // 获取spring容器
        ApplicationContext ac = Function.returnSpring(request);
        // 获取数据库操作对象
        ClueService clueService = (ClueService)ac.getBean("clueService");
        Map<String, Object> map = new HashMap<>();
        map.put("fullname", clueName);
        map.put("company", clueCompany);
        map.put("phone", companyLandline);
        map.put("source", clueSource);
        map.put("owner", clueOwner);
        map.put("mphone", mobilePhone);
        map.put("state", clueState);
        map.put("pageNumber", (pageNumber - 1) * 10);
        // 执行sql语句, 返回json格式的字符串
        return clueService.queryClue(map);
    }

    /**
     * 处理createClue.do请求, 创建线索
     * @param request 请求
     * @param session 会话
     * @param clueOwner 线索所有者
     * @param company 公司
     * @param call 称呼
     * @param fullname 名字
     * @param job 职位
     * @param email 邮箱
     * @param companyLandline 公司座机
     * @param website 公司网站
     * @param mobilePhone 手机电话
     * @param clueState 线索状态
     * @param clueSource 线索来源
     * @param clueDescribe 线索描述
     * @param contactSummary 联系纪要
     * @param nextContactTime 上次联系时间
     * @param detailedAddress 地址
     * @return json格式的字符串, 其中有flag属性, true表示创建成功, false表示创建失败
     */
    @RequestMapping(value = "/createClue.do")
    @ResponseBody
    public Object clueCreate(HttpServletRequest request, HttpSession session, String clueOwner, String company, String call, String fullname,
                             String job, String email, String companyLandline, String website, String mobilePhone, String clueState,
                             String clueSource, String clueDescribe, String contactSummary, String nextContactTime, String detailedAddress){
        // 随机生成id
        String id = UUID.randomUUID().toString().replace("-", "");
        // 获取创建线索账户名
        User user = (User)session.getAttribute("userData");
        // 获取当前时间
        String currentTime = Function.returnFormateDateTime(new Date());
        // 获取spring容器
        ApplicationContext ac = (ApplicationContext)Function.returnSpring(request);
        ClueService clueService = (ClueService)ac.getBean("clueService");
        return new ClueInfo(clueService.insertClue(new Clue(id, fullname, call, clueOwner, company, job, email, companyLandline,
                website, mobilePhone, clueState, clueSource, user.getId(), currentTime, user.getId(), currentTime, clueDescribe,
                contactSummary, nextContactTime, detailedAddress)));
    }

    /**
     * 处理removeActivity.do请求, 删除线索
     * @param request 请求
     * @param ids 要删除的线索id
     * @return json格式的字符串. 其中有flag属性, true表示删除成功, false表示删除失败
     */
    @RequestMapping(value = "/removeClue.do")
    @ResponseBody
    public Object removeClue(HttpServletRequest request, String ids){
        // 获取每个线索的id
        String[] allId = Function.splitString(ids);
        // 获取spring容器
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("spring");
        ClueService clueService = (ClueService)ac.getBean("clueService");
        return new ClueInfo(clueService.deleteClue(allId) > 0);
    }

    /**
     * 处理byIdQueryClue.do请求, 查询修改数据
     * @param request 请求
     * @param id 修改数据的id
     * @return com.nihao.crm.entityClass.clue.Clue
     */
    @RequestMapping(value = "/byIdQueryClue.do")
    @ResponseBody
    public Object queryAlterData(HttpServletRequest request, String id){
        // 获取spring容器
        ApplicationContext ac = Function.returnSpring(request);
        // 获取数据库操作对象
        ClueService clueService = (ClueService) ac.getBean("clueService");
        return clueService.selectClueById(id);
    }

    /**
     * 处理alterClue.do请求, 修改线索
     * @param request 请求
     * @param owner 线索所有者
     * @param company 公司
     * @param cell 称呼
     * @param name 名字
     * @param job 职位
     * @param email 邮箱
     * @param companyLandline 公司座机
     * @param website 公司网站
     * @param mobilePhone 手机
     * @param clueState 线索状态
     * @param clueSource 线索来源
     * @param clueDescribe 线索描述
     * @param contactSummary 联系纪要
     * @param nextContactTime 下次联系时间
     * @param address 地址
     * @param id 线索id
     * @return json格式的字符串, 其中有flag属性, true表示修改成功, false表示修改失败
     */
    @RequestMapping(value = "/alterClue.do")
    @ResponseBody
    public Object alterClue(HttpServletRequest request, String owner, String company, String cell, String name, String job, String email,
                            String companyLandline, String website, String mobilePhone, String clueState, String clueSource,
                            String clueDescribe, String contactSummary, String nextContactTime, String address, String id){
        // 获取spring容器
        ApplicationContext ac = Function.returnSpring(request);
        // 获取当前时间
        String currentTime = Function.returnFormateDateTime(new Date());
        // 获取修改者
        String editBy = request.getSession().getId();
        Clue clue = new Clue(id, name, cell, owner, company,
                job, email, companyLandline, website, mobilePhone, clueState,
                clueSource, editBy, currentTime, clueDescribe, contactSummary, nextContactTime, address);
        // 获取数据库操作对象
        ClueService clueService = (ClueService)ac.getBean("clueService");
        return new ClueInfo(clueService.updateClue(clue) > 0);
    }

    @RequestMapping(value = "/queryClueRemark.do")
    @ResponseBody
    public Object queryClueRemark(HttpServletRequest request, String id){
        ApplicationContext ac = Function.returnSpring(request);
        ClueService clueService = (ClueService)ac.getBean("clueService");
        return clueService.selectClueRemark(id);
    }
}
