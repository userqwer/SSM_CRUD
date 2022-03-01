package su.ssm.crud.service;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import su.ssm.crud.bean.Employee;
import su.ssm.crud.bean.EmployeeExample;
import su.ssm.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {
	
	@Autowired
	EmployeeMapper employeeMapper;

	/**
	 * 查询所有员工
	 * @return
	 */
	public List<Employee> getAll() {
		// TODO Auto-generated method stub
		return employeeMapper.selectByExampleWithDept(null);
	}

	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
	}

	//检验用户名是否可用
	public Boolean checkUser(String empName) {

		EmployeeExample example = new EmployeeExample();
		//创建一个条件
		EmployeeExample.Criteria criteria =  example.createCriteria();
		//拼装我们要的条件empName
		criteria.andEmpNameEqualTo(empName);
		//按照条件进行查询，符合条件example就返回有多少条记录
		long count = employeeMapper.countByExample(example);
		//返回true表示用户名可用，false：不可用
		return count==0;
	}

	public Employee getEmp(Integer id) {
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	//更新员工
	public void updateEmp(Employee employee) {
		//有选择的更新，如果带了id就根据id进行更新，如果带了其它条件就根据其他条件更新
		employeeMapper.updateByPrimaryKeySelective(employee);

	}
	//删除单个员工
	public void deleEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}
	//批量删除员工
	public void deleteBatch(List<Integer> str_ids) {
		EmployeeExample example = new EmployeeExample();
		EmployeeExample.Criteria criteria = example.createCriteria();
		//delete from xxx where emp_id in(1,2,3)
		criteria.andEmpIdIn(str_ids);//员工id在list集合里
		employeeMapper.deleteByExample(example);
	}
}
