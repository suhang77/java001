<%--
  Created by IntelliJ IDEA.
  User: SH
  Date: 2021/1/19
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="../../css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">专业</label>
                            <div class="layui-input-inline">
                                <select name="major" lay-filter="major">
                                    <option value="">--请选择--</option>
                                    <option value="0">计算机科技与技术</option>
                                    <option value="1" >软件工程</option>
                                    <option value="2">网络工程</option>
                                </select>                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">班号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="cno" autocomplete="off" class="layui-input" placeholder="请输入班号">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">年级</label>
                            <div class="layui-input-inline">
                                <input id="grade" type="text" name="grade" autocomplete="off" class="layui-input" readonly placeholder="请选择入学年份">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <button type="submit" class="layui-btn layui-btn-primary"  lay-submit lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加班级 </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 批量删除 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
        <!--实现表格的序号自增-->
        <script type="text/html" id="zizeng">
            {{d.LAY_TABLE_INDEX+1}}
        </script>
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn  layui-btn-xs data-count-edit" lay-event="edit">修改</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
            <a class="layui-btn layui-btn-normal layui-btn-xs " lay-event="find">学生查询</a>
            <a class="layui-btn layui-btn-xs  data-count-delete" lay-event="addBatch">批量添加学生</a>
        </script>

    </div>
</div>
<script src="../../lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table','laydate'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table,
            laydate = layui.laydate;
        //年选择器
        laydate.render({
            elem: '#grade'
            ,type: 'year'
        });


        table.render({
            elem: '#currentTableId',
            url: '../../api/class.json',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'zizeng', width: 80, title: '序号',templet:'#zizeng',align:'center'},
                {field: 'cno', width: 100, title: '班号',align:'center'},
                {field: 'majorName', width: 150, title: '专业', sort: true,align:'center'},
                {field: 'joinDate', width:120, title: '入学时间',align:'center'},
                {field: 'leaveDate', width:120, title: '毕业时间',align:'center'},
                {field: 'num', title: '班级人数',width:80,align:'center'},
                {field: 'classTeacher', width: 130, title: '班主任',align:'center'},
                {field: 'telephone', width: 120, title: '班主任联系电话'},
                {field: 'counsellor', width: 130, title: '辅导员',align:'center'},
                {field: 'telephoneTel', width: 120, title: '辅导员联系电话'},
                {field: 'remark', width: 120, title: '备注'},
                {title: '操作', minWidth: 280, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,
            page: true

        });

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            var result = JSON.stringify(data.field);
            layer.alert(result, {
                title: '最终的搜索信息'
            });

            //执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                }
                , where: {
                    searchParams: result
                }
            }, 'data');

            return false;
        });

        /**
         * toolbar监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '添加班级',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: 'addClass.html',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {  // 监听删除操作
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                layer.alert(JSON.stringify(data));
            }
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {

                var index = layer.open({
                    title: '修改班级',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: 'editClass.html',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                layer.confirm('真的删除行么', function (index) {
                    obj.del();
                    layer.close(index);
                });
            }else if(obj.event === 'find'){
                var index = layer.open({
                    title: '查询班级学生信息',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: 'findStudentByCno.html',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            }else if(obj.event === 'addBatch'){
                var index = layer.open({
                    title: '批量添加学生',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['55%', '50%'],
                    content: 'addBatchStudent.html',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            }
        });

    });
</script>

</body>
</html>

