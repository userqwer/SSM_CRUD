<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- web路径：
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
    http://localhost:3306/crud
         -->
    <script type="text/javascript"
            src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
    <link
            href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 修改员工时弹出的框(模态框) -->
<div class="modal fade" id="empupdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <%--显示输入框里的内容正确与否的提示信息--%>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email">
                            <%--显示输入框里的内容正确与否的提示信息--%>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 添加员工时弹出的框(模态框) -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="emp_add_input" placeholder="empName">
                            <%--显示输入框里的内容正确与否的提示信息--%>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email">
                            <%--显示输入框里的内容正确与否的提示信息--%>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 搭建显示页面 -->
<%--“行（row）”必须包含在 类 .container 里面--%>
<%--.col-md-占多少列--%>
<div class="container">
    <%--    你的内容应当放置于“列（column）”内，并且，只有“列（column）”可以作为行（row）”的直接子元素。--%>
    <div class="row">
        <%-- 标题--%>
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%-- 按钮--%>
    <div class="row">
        <div class="col-md-offset-8">
            <%--偏移8个列的宽度--%>
            <button class="btn btn-primary" id="emp_add_model_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>

    <%--显示表格数据--%>
    <div class="row"><%--这一行显示表格数据--%>
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
<%--                        在表头设置一个复选框--%>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                <%--表格里的用户数据通过解析json生成--%>
                </tbody>
            </table>
        </div>
    </div>

<%--分页条和分页信息--%>
    <div class="row">
        <!--分页文字信息  -->
        <div class="col-md-6" id="page_info_area">
            <%--通过解析json生成--%>
        </div>
        <div class="col-md-6" id="page_nav_area">
        <%--分页条通过解析json生成--%>
        </div>
    </div>
</div>

<script type="text/javascript">
    //定义一个全局变量保存总记录数/当前页码，然后调用to_page去到最后一页/当前修改用户的是哪一页，显示新添加/修改的员工
    var totalRecord ,currentPage;
    //1、页面加载完成后，直接发送ajax请求，要到分页数据
    $(function () {
        to_page(1);
    });
    //去到第几页
    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"get",
            success:function (result) {
                console.log(result);
                //解析并显示员工数据
                build_emps_table(result);
                //解析并显示分页信息(左下角的)
                build_page_info(result);
                //解析并显示分页条(右下角的)
                build_page_nav(result);
            }
        })
    }

    //构建员工信息表格
    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        //index每个用户的索引值
        //item遍历出来的每一条用户信息
        $.each(emps,function (index,item) {
            // alert(item.empName);
            //$("<td></td>")构建出一个单元格
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);

            //addClass给这个button标签添加一个类选择器
            //编辑框
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑");
                //为编辑按钮添加一个自定义属性，来表示当前员工id
            editBtn.attr("edit-id",item.empId);
                //删除框
                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");
            //为删除按钮添加一个自定义属性，来表示当前员工id
                delBtn.attr("dele-id",item.empId);
            var btn = $("<td></td>").append(editBtn).append(" ").append(delBtn);

            //append方法执行完成以后还是返回原来的元素<tr></tr>
            $("<tr></tr>").append(checkBoxTd)
            .append(empIdTd)
            .append(empNameTd)
            .append(genderTd)
            .append(emailTd)
            .append(deptNameTd)
            .append(btn)
            .appendTo("#emps_table tbody");//添加到表格里
        });
    }
    //分页信息
    function build_page_info(result) {
        //清空前一次的分页信息
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页,总"
            +result.extend.pageInfo.pages+"页，总"+result.extend.pageInfo.total+"条记录");
        totalRecord = result.extend.pageInfo.total;
        currentPage =result.extend.pageInfo.pageNum;
    }
    //分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        //page_nav_area
        var firstPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append("首页"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        //如果有上一页我才给他绑定单击事件，否则不能点击
        if(result.extend.pageInfo.hasPreviousPage==false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append("末页"));
        //如果有下一页我才给他绑定单击事件
        if(result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }

        //添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);
        //1,2,3,4,5 遍历给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            //设置当前页为高亮显示
            if(result.extend.pageInfo.pageNum ==item){
                numLi.addClass("active")
            }
            numLi.click(function () {
                to_page(item);
            })
            ul.append(numLi);
        });
        //添加下一页和末页的提示
        ul.append(nextPageLi).append(lastPageLi);
        //把ul放到<nav></nav>标签下
        var navEle = $("<nav></nav>").append(ul);
        //把<nav></nav>放到#page_nav_area下
        navEle.appendTo("#page_nav_area");
    }

    //清空表单样式和内容
    function reset_form(ele){
        //重置表单里的内容
        $(ele)[0].reset();
        //清空样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text(" ");//清空文本框下的提示信息
    }

    //点击新增按钮弹出模态框
    $("#emp_add_model_btn").click(function (){
        // alert($("#empAddModal form"));
        // $("#empAddModal form")[0].reset();
        reset_form("#empAddModal form");
        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#empAddModal select");
        //调用模态框
        $("#empAddModal").modal({
            //当模态框弹出来时点击背景不会删除
            backdrop:"static"
        })
    });

    //查询所有部门信息
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            //把查询出来的部门信息放到result里保存
            success:function (result) {
                $.each(result.extend.depts,function () {
                    //给option标签里添加id属性,定义送往服务器的选项值
                    var optionEle = $("<option></option>").attr("value",this.deptId).append(this.deptName);
                    //放到添加员工模态框中的下拉列表中
                    optionEle.appendTo(ele);
                })
            }
        })
    }

    //校验表单数据
    function validate_add_form(){
        var empName = $("#emp_add_input").val();
        var regName = /(^[a-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            // alert("用户名可以是2-5位中文或者6-16位英文和数组的组合")
            //校验状态，如 error、warning 和 success 状态，都定义了样式。使用时，
            // 添加 .has-warning、.has-error 或 .has-success 类到这些控件的父元素即可,错误就显示红色，可用就是绿色
            show_validate_msg("#emp_add_input","error","用户名可以是2-5位中文或者6-16位英文和数组的组合");
            // $("#emp_add_input").parent().addClass("has-error");
            // $("#emp_add_input").next("span").text("用户名可以是2-5位中文或者6-16位英文和数组的组合");
            return false;
        }else{
            show_validate_msg("#emp_add_input","success","");
            // $("#emp_add_input").parent().addClass("has-success");
            // $("#emp_add_input").next("span").text("");
        }
        var email = $("#email_add_input").val();
        var regEmail =/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            // alert("邮箱格式不正确");
            show_validate_msg("#email_add_input","error","邮箱格式不正确");
            // $("#email_add_input").parent().addClass("has-error");
            // $("#email_add_input").next("span").text("邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_add_input","success","");
            // $("#email_add_input").parent().addClass("has-success");
            // $("#email_add_input").next("span").text("")
        }
        return true;
    }

    //显示校验结果的提示信息
    function show_validate_msg(ele,status,msg){
        $(ele).parent().removeClass("has-error has-success");
        $(ele).next("span").text("");
        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验用户名是否可用，当文本框里的内容发生变化之后
    $("#emp_add_input").change(function () {
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkUser",
            type:"POST",
            data:"empName="+empName,
            success:function (result) {
                if(result.code==100){
                    show_validate_msg("#emp_add_input","success","用户名可用");
                    //如果用户名不可用就给点击保存的按钮添加ajax-va=success属性值
                    $("#emp_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#emp_add_input","error",result.extend.va_msg);
                    //如果用户名不可用就给点击保存的按钮添加ajax-va=error属性值
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        })
    });

    //点击保存，保存员工
    $("#emp_save_btn").click(function () {
        // alert(this);
        if(!validate_add_form()){
            //如果方法返回来false就不让他往下执行，如不关闭模态框、不保存用户
            return false;
        }

        //1、判断之前的ajax用户名校验是否成功。如果成功。
        //this拿到当前操作的对象，保存按钮
        //如果这个属性ajax-va的值是error，就不给他点保存(不继续往下执行)
        if($(this).attr("ajax-va")=="error"){
            return false;
        }

        $.ajax({
            url:"${APP_PATH}/saveEmp",
            type:"POST",
                  //序列化表单里的内容，把表单里的内容发送给服务器
            data: $("#empAddModal form").serialize(),
            //把查询出来的部门信息放到result里保存
            success:function (result) {
                if(result.code==100){
                    //关闭模态框
                    $("#empAddModal").modal('hide');
                    //它会吧一个大于总页码的页码，给我们查出总是最后一页的数据
                    to_page(totalRecord);
                }else{
                    if(undefined != result.extend.errorField.email){
                        //显示邮箱的错误信息
                        show_validate_msg("#email_add_input","error",result.extend.errorField.email);
                    }
                    if(undefined != result.extend.errorField.empName){
                        //显示员工名字的错误信息
                        show_validate_msg("#emp_add_input","error",result.extend.errorField.empName);
                    }
                }
            }
        })
    })
    //给编辑按钮绑上点击事件
    //1、我们是按钮创建之前就绑定了click，所以绑定不上。
    //1）、可以在创建按钮的时候绑定。    2）、绑定点击.live()
    //jquery新版没有live，使用on进行替代
    //在整个文档中给".edit_btn"编辑按钮绑上单击事件，"click"：绑click事件
    $(document).on("click",".edit_btn",function(){
        //查出员工的信息
        getEmp($(this).attr("edit-id"));
        //查出部门的信息放到下拉列表中
        getDepts("#empupdateModal select");
        //把员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("update-btn",$(this).attr("edit-id"));
        //弹出模态框
        $("#empupdateModal").modal({
            //当模态框弹出来时点击背景不会删除
            backdrop:"static"

        })
    });
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/getEmp/"+id,
            type:"GET",
            success:function (result) {
                // console.log(result);
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);//给文本框赋值
                //给这个模态框empupdateModal里的name=gender的input标签里的单选框赋值，传入一个被单选框选中的值
                $("#empupdateModal input[name=gender]").val([empData.gender]);
                $("#empupdateModal select").val([empData.dId]);
            }
        })
    }
    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //1、验证邮箱是否合法
        var email = $("#email_update_input").val();
        var regEmail =/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            show_validate_msg("#email_update_input","error","邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_update_input","success","");
        }
        //2、发送ajax请求保存修改的员工信息
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("update-btn"),
            type:"PUT",
            data:$("#empupdateModal form").serialize(),
            success:function (result) {
                $("#empupdateModal").modal('hide');
                to_page(currentPage);
            }
        })
    });

    //单个删除
    $(document).on("click",".delete_btn ",function () {
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("dele-id");
        if(confirm("确定要删除【"+empName+"】吗？")){
            $.ajax({
                url:"${APP_PATH}/deleteEmp/"+empId,
                type:"delete" ,
                success:function (result) {
                    to_page(currentPage);
                }
            })
        }
    })

    //完成全选/全不选
    $("#check_all").click(function () {
        //attr获取checked是undefined;
        //attr是用来获取 自定义 属性的值；
        //prop是用来修改和读取 dom原生 属性的值
        //选中的话checked是true，不选中checked就是false
        $(".check_item").prop("checked",$(this).prop("checked"));//把员工前面的框的状态和表头的状态一样#check_all
    })
    $(document).on("click",".check_item",function () {
        //判断当前选择中的元素是否5个或是否被选满
        //匹配所有被选中的复选框，即当前是被选中的check_item的长度是否等于全部的复选框
        var flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //删除被选中的员工
    $("#emp_delete_all_btn").click(function () {
        var empNames = "";
        var del_idstr = "";
        //遍历被选中的复选框
        $.each($(".check_item:checked"),function () {
            //this表示当前遍历到的元素,拿到每个员工的名字和id值
            empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";//姓名,每个姓名之间用逗号分割
            del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";//id，每个id姓名之间用 - 分割
        });
        //截取从第一个开始到倒数最后一个字符之间的数据出来，剩余的不要
        empNames = empNames.substring(0,empNames.length-1);//去除多余的逗号
        del_idstr = del_idstr.substring(0,del_idstr.length-1);//去除多余的-
        if(confirm("确认删除【"+empNames+"】吗？")){
            //点击确认后发送ajax请求
            $.ajax({
                url:"${APP_PATH}/deleteEmp/"+del_idstr,
                type:"delete",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            })
        }
    })
</script>
</body>
</html>
