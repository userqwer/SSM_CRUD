package su.ssm.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import su.ssm.crud.bean.Employee;
import su.ssm.crud.bean.Msg;
import su.ssm.crud.service.EmployeeService;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工的crud
 * @author Mr.su
 * @create 2022-02-03 下午 11:12
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 单个批量二合一
     * 批量删除：1-2-3(传进来的参数)
     * 单个删除：1
     *
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/deleteEmp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids") String ids){
        //如果你传进来的参数包含“-”，那就是批量删除，否则就是删除单个
        if(ids.contains("-")){
            List<Integer> list_id = new ArrayList<Integer>();
            //把字符串分割成数组，那就是split方法。参数为分割的字符串或者正则表达式
            String[] str_ids = ids.split("-");//123

            for(String id : str_ids){
                list_id.add(Integer.parseInt(id));
            }
            System.out.println(list_id);//[1,2,3]
            employeeService.deleteBatch(list_id);
        }else{
            int id = Integer.parseInt(ids);
            employeeService.deleEmp(id);

        }
        return Msg.success();
    }

    //员工更新方法
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee){
        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    @ResponseBody//该方法的返回值直接作为响应报文的响应体响应到浏览器,并转换为json
    @RequestMapping(value = "/getEmp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){//把路径中的id值赋值给形参
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    @ResponseBody
    @RequestMapping("/checkUser")
    public Msg checkUser(@RequestParam("empName") String empName){
        String regx = "(^[a-z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        boolean matches = empName.matches(regx);
//        System.out.println(matches);
        if(!matches){
            return Msg.fail().add("va_msg","用户名可以是2-5位中文或者6-16位英文和数组的组合");
        }
        //返回true表示用户名可用，false：不可用
        Boolean b = employeeService.checkUser(empName);
        if(b){
            return Msg.success();//100
        }else{
            return Msg.fail().add("va_msg","用户名不可用");//200
        }
    }

    //保存用户
    @RequestMapping(value = "/saveEmp",method = RequestMethod.POST)
    @ResponseBody
    //@Valid：employeel里面的数据需要进行校验，BindingResult:封装校验的结果(成功或失败)
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            Map<String,Object> map = new HashMap<String, Object>();
            //获取所有字段的错误信息
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError error : fieldErrors){
                //哪一个字段出现错误了
                System.out.println("错误的字段名："+error.getField());
                //该字段出现了什么错误
                System.out.println("错误的信息："+error.getDefaultMessage());
                map.put(error.getField(),error.getDefaultMessage());
            }
            return Msg.fail().add("errorField",map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    }

    @RequestMapping("/emps")
    @ResponseBody//将Java对象直接作为控制器方法的返回值返回,自动转换为json响应回去
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){
        //在查询之前只需要调用，传入第几页，以及每页显示多少条数据
        PageHelper.startPage(pn,5);
//        startPage后面紧跟的这个查询就是一个分页查询了
        List<Employee> emps = employeeService.getAll();
        //使用PageInfo包装查询后的结果，只需要将PageInfo交个页面就行了
        //封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
        PageInfo pageInfo = new PageInfo(emps,5);
        model.addAttribute("pageInfo",pageInfo);
        return Msg.success().add("pageInfo",pageInfo);
    }

    //不发送参数的话，默认是1
    //pageNum：第几页
//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model) {
        //在查询之前只需要调用，传入第几页，以及每页显示多少条数据
        PageHelper.startPage(pn,5);
//        startPage后面紧跟的这个查询就是一个分页查询了
        List<Employee> emps = employeeService.getAll();
        //使用PageInfo包装查询后的结果，只需要将PageInfo交个页面就行了
        //封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
        PageInfo pageInfo = new PageInfo(emps,5);
        model.addAttribute("pageInfo",pageInfo);
        return "list";
    }
}
