package com.nihao.crm.controller;

import com.nihao.crm.entityClass.activity.Activity;
import com.nihao.crm.entityClass.activity.ActivityAndIds;
import com.nihao.crm.entityClass.activity.ActivityInfo;
import com.nihao.crm.entityClass.activity.remark.ActivityRemark;
import com.nihao.crm.entityClass.activity.remark.ActivityRemarkInfo;
import com.nihao.crm.entityClass.activity.remark.ActivityRemarkQueryInfo;
import com.nihao.crm.entityClass.user.User;
import com.nihao.crm.function.Function;
import com.nihao.crm.service.activity.*;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;

/**
 * 市场活动相关功能处理器
 */
@Controller
public class ActivityController {
    /**
     * 创建市场活动
     * @param request 请求
     * @param owner 所有者
     * @param activityName 市场活动名
     * @param startDate 开始时间
     * @param endDate 结束时间
     * @param cost 成本
     * @param describe 描述信息
     * @return json格式的数据
     */
    @RequestMapping(value = {"/createActivity.do"}, method = {RequestMethod.POST})
    @ResponseBody
    public Object createActivity(HttpServletRequest request, HttpSession session, String owner, String activityName,
                                 String startDate, String endDate, String cost, String describe){
        // 获取spring容器
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("spring");
        CreateActivity createActivity = (CreateActivity) ac.getBean("createActivity");
        // 创建UUID
        String uuid = UUID.randomUUID().toString().replace("-", "");
        // 获取当前时间
        String currentDateTime = Function.returnFormateDateTime(new Date());
        // 获取user对象
        User user = (User) session.getAttribute("userData");
        // 获取创建者
        String createBy = user.getId();
        // 创建市场活动
        boolean flag = createActivity.addActivity(new Activity(uuid, owner, activityName, startDate
                , endDate, cost, describe, currentDateTime, createBy, currentDateTime, createBy));
        return new ActivityInfo(flag);
    }

    /**
     * 添加活动备注
     * 处理createActivityRemark.do请求
     * @param request 请求
     * @param session 会话
     * @param remark 备注
     * @param activityId 活动id
     * @return 返回json格式的数据
     */
    @RequestMapping(value = "/createActivityRemark.do")
    @ResponseBody
    public Object addActivityRemark(HttpServletRequest request, HttpSession session, String remark, String activityId){
        // 获取添加备注的用户的id
        User user = (User) session.getAttribute("userData");
        String userId = user.getId();
        // 创建id
        String id = UUID.randomUUID().toString().replace("-", "");
        // 获取当前时间
        String currentTime = Function.returnFormateDateTime(new Date());
        // 获取spring容器
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("spring");
        CreateActivityRemark createActivityRemark = (CreateActivityRemark)ac.getBean("createActivityRemark");
        return new ActivityRemarkInfo(createActivityRemark.addActivityRemark(
                new ActivityRemark(id, remark, currentTime, userId, currentTime, userId, activityId)));
    }

    /**
     * 处理查询活动请求
     * @param request 请求
     * @param activityName 查询活动名
     * @param activityOwner 查询活动所有人
     * @param activityStartDate 查询活动开始日期
     * @param activityEndDate 查询活动结束日期
     * @param pageShowNumber 当前页面
     * @return com.nihao.crm.entityClass.activity.ActivityAndActivityNumber
     */
    @RequestMapping(value = "/queryActivityInfo.do")
    @ResponseBody
    public Object queryActivity(HttpServletRequest request, String activityName, String activityOwner, String activityStartDate, String activityEndDate,
                                Integer pageShowNumber) {
        // 模糊查询活动信息
        Map<String, Object> map = new HashMap<>();
        map.put("activityName", activityName);
        map.put("activityOwner", activityOwner);
        map.put("activityStartDate", activityStartDate);
        map.put("activityEndDate", activityEndDate);
        map.put("pageShowNumber", (pageShowNumber - 1) * 10);
        // 获取spring容器
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("spring");
        SelectQueryActivity selectQueryActivity = (SelectQueryActivity)ac.getBean("selectQueryActivity");
        return selectQueryActivity.likeQueryActivity(map);
    }

    /**
     * 处理removeActivity.do请求, 删除活动数据
     * @param request 请求
     * @param activityIds 删除活动数据的id
     * @return true表示删除成功, false表示删除失败
     */
    @RequestMapping(value = "/removeActivity.do")
    @ResponseBody
    public Object removeActivity(HttpServletRequest request, String activityIds){
        // 判断activityIds是否为空或""
        if(activityIds == null | activityIds.equals("")){
            return new ActivityInfo(false);
        }
        // 获取每个活动的id
        String[] ids = Function.splitString(activityIds);
        // 获取spring容器
        ApplicationContext ac = (ApplicationContext)request.getServletContext().getAttribute("spring");
        RemoveActivity removeActivity = (RemoveActivity) ac.getBean("removeActivity");
        return new ActivityInfo(removeActivity.removeActivityAndRemoveActivityRemark(ids));
    }

    /**
     * 处理updateActivity.do请求, 更新活动数据
     * @param request 请求
     * @param activityIds 更新活动的id
     * @param editActivityOwner 修改的活动所有人
     * @param editActivityName 修改的活动名
     * @param editStartDate 修改的活动开始日期
     * @param editEndDate 修改的活动结束日期
     * @param editCost 修改的活动成本
     * @param editDescribe 修改的活动描述信息
     * @return true表示修改成功, false表示修改失败
     */
    @RequestMapping(value = "/updateActivity.do")
    @ResponseBody
    public Object updateActivity(HttpServletRequest request, HttpSession session, String activityIds, String editActivityOwner,
                                 String editActivityName, String editStartDate, String editEndDate, String editCost, String editDescribe){
        // 获取当前时间
        String currentTime = Function.returnFormateDateTime(new Date());
        // 获取修改活动信息的用户
        User user = (User)session.getAttribute("userData");
        // 获取每个活动的id
        String[] ids = Function.splitString(activityIds);
        // 获取spring容器
        ApplicationContext ac = (ApplicationContext)request.getServletContext().getAttribute("spring");
        AlterActivity alterActivity = (AlterActivity)ac.getBean("alterActivity");
        return new ActivityInfo(alterActivity.changeActivity(new ActivityAndIds(ids, new Activity(editActivityOwner,
                editActivityName, editStartDate, editEndDate, editCost, editDescribe,
                null, null, currentTime, user.getId()))));
    }

    /**
     * 处理deleteActivityRemark.do请求, 删除活动备注信息
     * @param request 请求
     * @param id 活动备注id
     * @return true表示删除成功, false表示删除失败
     */
    @RequestMapping(value = "/deleteActivityRemark.do")
    @ResponseBody
    public Object removeActivityRemark(HttpServletRequest request, String id){
        // 获取spring容器
        ApplicationContext ac = (ApplicationContext)request.getServletContext().getAttribute("spring");
        RemoveActivityRemark removeActivityRemark = (RemoveActivityRemark) ac.getBean("removeActivityRemark");
        return new ActivityRemarkInfo(removeActivityRemark.deleteActivityRemark(id));
    }

    /**
     * 处理queryActivityRemark.do请求, 查询活动备注信息
     * @param request 请求
     * @param id 活动备注id
     * @return 返回string类型的数据
     */
    @RequestMapping(value = "/queryActivityRemark.do")
    @ResponseBody
    public Object queryActivityRemark(HttpServletRequest request, String id){
        // 获取spring容器
        ApplicationContext ac = (ApplicationContext)request.getServletContext().getAttribute("spring");
        ByIdQueryActivityRemark byIdQueryActivityRemark = (ByIdQueryActivityRemark) ac.getBean("byIdQueryActivityRemark");
        return new ActivityRemarkQueryInfo(byIdQueryActivityRemark.findActivityRemark(id));
    }

    /**
     * 处理updateActivityRemark.do请求, 通过活动备注id, 修改活动备注信息
     * @param request 请求
     * @param id 活动备注id
     * @param editActivityRemark 修改活动备注信息
     * @return true表示修改成功, false表示修改失败
     */
    @RequestMapping(value = "/updateActivityRemark.do")
    @ResponseBody
    public Object alterActivityRemark(HttpServletRequest request, String id, String editActivityRemark){
        // 获取spring容器
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("spring");
        AlterActivityRemark activityRemark = (AlterActivityRemark) ac.getBean("alterActivityRemark");
        return new ActivityRemarkInfo(activityRemark.alterActivityRemark(new ActivityRemark(id, editActivityRemark)));
    }

    /**
     * 处理downloadActivityFile.do请求, 查询活动数据, 导出活动数据, 生成后缀名为.xls文件, 导出文件
     * @param request 请求
     * @param id 活动id
     */
    @RequestMapping(value = "/downloadActivityFile.do")
    public void activityExport(HttpServletRequest request, HttpServletResponse response, String id){
        List<Activity> activities = null;
        // 获取spring容器
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("spring");
        if(id.equals("1")){
            // 批量导出市场活动
            // 获取数据库操作对象
            GetAllActivity getAllActivity = (GetAllActivity)ac.getBean("getAllActivity");
            activities = getAllActivity.getAllActivityInfo();
        }else{
            // 选择导出市场活动
            // 获取每个活动的id
            String[] ids = Function.splitString(id);
            // 通过活动id查询活动数据
            // 获取数据库操作对象
            ByIdSelectActivity byIdSelectActivity = (ByIdSelectActivity)ac.getBean("byIdSelectActivity");
            activities = byIdSelectActivity.selectActivity(ids);
        }
        // 设置响应类型
        // application/octet-stream表示二进制流, 表示所有格式的文件
        response.setContentType("application/octet-stream;charset=UTF-8");
        //设置响应头, 指定下载文件名
        response.setHeader("Content-Disposition", "attachment;filename=activityFile.xls");
        // 创建xls文件操作对象
        HSSFWorkbook workbook = new HSSFWorkbook();
        // 创建xls文件操作对象数据中的第一页
        HSSFSheet sheet = workbook.createSheet("活动信息列表");
        // 创建行对象
        HSSFRow row = null;
        // 创建列对象
        HSSFCell cell = null;

        int i = 0;
        // 添加第一行
        // 在poi插件中, 每行的起始下标是0
        row = sheet.createRow(i);
        // 添加第一行中的列
        cell = row.createCell(0);
        cell.setCellValue("id");
        cell = row.createCell(1);
        cell.setCellValue("owner");
        cell = row.createCell(2);
        cell.setCellValue("name");
        cell = row.createCell(3);
        cell.setCellValue("startDate");
        cell = row.createCell(4);
        cell.setCellValue("endDate");
        cell = row.createCell(5);
        cell.setCellValue("cost");
        cell = row.createCell(6);
        cell.setCellValue("description");
        cell = row.createCell(7);
        cell.setCellValue("createTime");
        cell = row.createCell(8);
        cell.setCellValue("createBy");
        cell = row.createCell(9);
        cell.setCellValue("editTime");
        cell = row.createCell(10);
        cell.setCellValue("editBy");

        if(activities != null) {
            // 遍历活动集合, 将集合中的活动数据导入到xls文件对象中(HSSFWorkbook)
            for (Activity activity : activities) {
                i++;
                row = sheet.createRow(i);
                cell = row.createCell(0);
                cell.setCellValue(activity.getId());
                cell = row.createCell(1);
                cell.setCellValue(activity.getOwner());
                cell = row.createCell(2);
                cell.setCellValue(activity.getName());
                cell = row.createCell(3);
                cell.setCellValue(activity.getStartDate());
                cell = row.createCell(4);
                cell.setCellValue(activity.getEndDate());
                cell = row.createCell(5);
                cell.setCellValue(activity.getCost());
                cell = row.createCell(6);
                cell.setCellValue(activity.getDescription());
                cell = row.createCell(7);
                cell.setCellValue(activity.getCreateTime());
                cell = row.createCell(8);
                cell.setCellValue(activity.getCreateBy());
                cell = row.createCell(9);
                cell.setCellValue(activity.getEditTime());
                cell = row.createCell(10);
                cell.setCellValue(activity.getEditBy());
            }
        }

        OutputStream servletOutputStream = null;
        try {
            // 直接将xls文件输出到浏览器上
            servletOutputStream = response.getOutputStream();
            workbook.write(servletOutputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }

        try {
            workbook.close();
            if(servletOutputStream != null){
                servletOutputStream.flush();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 处理importFile.do请求, 解析xls上传文件数据, 将上传文件中的数据存放在数据库中
     * @param request 请求
     * @param file 文件
     * @return true表示上传成功, false表示上传失败
     */
    @RequestMapping(value = "/importFile.do")
    @ResponseBody
    public Object importFile(HttpServletRequest request, MultipartFile file) throws IOException {
        // 解析xls文件
        HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());

        // 获取当前时间
        String current = Function.returnFormateDateTime(new Date());
        // 获取当前用户
        User user = (User) request.getSession().getAttribute("userData");
        // 获取当前用户id
        String userId = user.getId();
        // 解析xls文件的第一页数据
        // 下标是从零开始
        HSSFSheet sheet = workbook.getSheetAt(0);
        HSSFRow row = null;
        List<Activity> activities = new ArrayList<>();
        if(sheet.getLastRowNum() <= 0){
            return new ActivityInfo(false, "数据为空");
        }

        String owner = null;
        String name = null;
        String startDate = null;
        String endDate = null;
        String cost = null;
        String description = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for(int i = 0; i <= sheet.getLastRowNum(); i++){
            row = sheet.getRow(i);
            if(row == null){
                continue;
            }
            try {
                // 获取活动所有者
                owner = Function.judgeCellDataType(row, 0);
                // 获取活动名
                name = Function.judgeCellDataType(row, 1);
                // 获取活动开始日期
                startDate = Function.getDateData(row, 2, sdf);
                // 获取活动结束日期
                endDate = Function.getDateData(row, 3, sdf);
                // 获取活动成本
                cost = Function.judgeCellDataType(row, 4);
                // 获取活动描述信息
                description = Function.judgeCellDataType(row, 5);
            } catch (Exception e) {
                // 出现异常, 返回错误信息
                return new ActivityInfo(false, "数据格式不符合要求");
            }

            if(i == 0){
                // 判断第一行的数据是否符合要求
                if(owner.equals("owner") && name.equals("name") && startDate.equals("startDate") && endDate.equals("endDate")
                        && cost.equals("cost") && description.equals("description")){
                    // 数据符合要求
                    continue;
                }
                return new ActivityInfo(false, "数据格式不符合要求");
            }
            if(!(startDate.equals("") && endDate.equals(""))){
                // 判断用户传入的日期格式是否正确
                Pattern datePatternOne = Pattern.compile("^[\\d]{4}-[\\d]{2}-[\\d]{2}$");
                Pattern datePatternTwo = Pattern.compile("^[\\d]{4}/[\\d]{2}/[\\d]{2}$");
                if(! (datePatternOne.matcher(startDate).matches() || datePatternTwo.matcher(startDate).matches())
                        || ! (datePatternOne.matcher(endDate).matches() || datePatternTwo.matcher(endDate).matches())){
                    return new ActivityInfo(false, "日期格式不正确");
                }
            }

            if(! cost.equals("")){
                // 判断成本格式是否正确
                Pattern costPattern = Pattern.compile("^[\\d]+[\\.]?[\\d]*$");
                if(! costPattern.matcher(cost).matches()){
                    return new ActivityInfo(false, "成本格式不正确");
                }
            }

            // 使用UUI随机生成id
            String id = UUID.randomUUID().toString().replace("-", "");
            // 将数据存放在List集合中
            activities.add(new Activity(id, owner, name, startDate, endDate, cost, description, current, userId, current, userId));
        }

        // 关闭资源
        workbook.close();
        // 获取spring容器
        ApplicationContext ac = Function.returnSpring(request);
        // 获取数据库操作对象
        AddActivity addActivity = (AddActivity)ac.getBean("addActivity");
        // 将文件数据保存到数据库中
        return new ActivityInfo(addActivity.createActivityBatch(activities));
    }
}