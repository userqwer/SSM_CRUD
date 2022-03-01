package su.ssm.crud.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import su.ssm.crud.bean.Department;
import su.ssm.crud.bean.Employee;
import su.ssm.crud.bean.Msg;
import su.ssm.crud.service.DepartmentService;
import su.ssm.crud.service.EmployeeService;

import java.util.List;

/**
 * 处理和部门有关的请求
 * @author Mr.su
 * @create 2022-02-05 下午 10:33
 */
@Controller
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    //返回所有部门信息
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Department> list = departmentService.getDepts();
        return Msg.success().add("depts",list);
    }
}
