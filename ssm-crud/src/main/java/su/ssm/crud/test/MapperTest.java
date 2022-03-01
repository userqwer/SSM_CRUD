package su.ssm.crud.test;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import su.ssm.crud.bean.Department;
import su.ssm.crud.bean.Employee;
import su.ssm.crud.dao.DepartmentMapper;
import su.ssm.crud.dao.EmployeeMapper;

import java.util.UUID;

/**
 * @author Mr.su
 * @create 2022-02-03 下午 10:00
 * 推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
 *  *1、导入SpringTest模块（jar包）SpringJUnit4ClassRunner
 *  *2、@ContextConfiguration指定Spring配置文件的位置，这个注解可以帮我们创建ioc容器对象并从容器中获取mapper
 *  *3、直接autowired要使用的组件即可
 */
//用哪个单元测试执行
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD(){
//        System.out.println(departmentMapper);//org.apache.ibatis.binding.MapperProxy@1a1da881
        //1、插入几个部门
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));
        //2、生成员工数据，测试员工插入
//        employeeMapper.insertSelective(new Employee(null,"Jerry", "M", "Jerry@atguigu.com", 1));
        //3、批量插入多个员工；批量，使用可以执行批量操作的sqlSession。
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i = 0;i<1000;i++){
            String uid = UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Employee(null,uid, "M", uid+"@atguigu.com", 1));
        }
        System.out.println("批量完成");

    }
}
