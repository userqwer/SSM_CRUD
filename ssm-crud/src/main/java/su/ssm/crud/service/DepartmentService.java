package su.ssm.crud.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import su.ssm.crud.bean.Department;
import su.ssm.crud.bean.Employee;
import su.ssm.crud.dao.DepartmentMapper;

import java.util.List;

/**
 * @author Mr.su
 * @create 2022-02-05 下午 10:36
 */
@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;


    //获取的部门的信息
    public List<Department> getDepts() {
        //按照条件查询
        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;
    }

}
