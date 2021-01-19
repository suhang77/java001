<%--
  Created by IntelliJ IDEA.
  User: SH
  Date: 2021/1/19
  Time: 13:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
            <legend>查询班级学生信息</legend>
            <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        </fieldset>

        <!--   <script type="text/html" id="toolbarDemo">
               <div class="layui-btn-container">
                   <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
               </div>
           </script>-->

        <!--实现表格的序号自增-->
        <script type="text/html" id="zi">
            {{d.LAY_TABLE_INDEX+1}}
        </script>
        <!-- <script type="text/html" id="currentTableBar">
             <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
             <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
         </script>-->
        <table class="layui-hide" id="currentTable" lay-filter="currentTableFilter"></table>
        <!--实现表格的序号自增-->
        <script type="text/html" id="zizeng">
            {{d.LAY_TABLE_INDEX+1}}
        </script>
        <script type="text/html" id="isGetJob">
            {{d.isGetJob == 1?'是':'否'}}
        </script>
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn  layui-btn-xs data-count-edit" lay-event="edit">修改</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
            <a class="layui-btn layui-btn-normal layui-btn-xs " lay-event="find">查看详情</a>
            <!--<a class="layui-btn layui-btn-xs  data-count-delete" lay-event="addBatch">批量添加学生</a>-->
        </script>

    </div>
</div>
<script src="../../lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: '/StudentServlet?method=findAll',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {field: 'zi', width: 40, title: '序号',templet:'#zi'},
                {field: 'sno', width: 100, title: '学号', sort: true},
                {field: 'sname', width: 100, title: '姓名'},
                {field: 'sex', width: 50, title: '性别'},
                {field: 'birthday', width: 100, title: '出生日期', sort: true},
                {field: 'natives', width: 100, title: '籍贯'},
                {field: 'qq', width: 100, title: 'QQ'},
                {field: 'weixin', width: 100, title: '微信'},
                {field: 'telephone', width: 120, title: '联系方式'},
                {field: 'isGetJob', width: 50, title: '是否就业',templet: "#isGetJob"},
                {title: '操作', minWidth: 280, toolbar: '#currentTableBar', align: "center"}
            ]],
            page:true
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
//      table.on('toolbar(currentTableFilter)', function (obj) {
//          if (obj.event === 'add') {  // 监听添加操作
//              var index = layer.open({
//                  title: '添加专业',
//                  type: 2,
//                  shade: 0.2,
//                  maxmin:true,
//                  shadeClose: true,
//                  area: ['80%', '70%'],
//                  content: 'addMajor.html',
//              });
//              $(window).on("resize", function () {
//                  layer.full(index);
//              });
//          }
//      });
//  });
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '添加学生',
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
                    title: '修改学生信息',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: 'editStudent.html',
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
                    content: 'studentInformation.html',
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
<!--</script>-->

</body>
</html>

