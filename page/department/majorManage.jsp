<%--
  Created by IntelliJ IDEA.
  User: 木木
  Date: 2021/1/19
  Time: 12:17
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
                            <label class="layui-form-label">学校</label>
                            <div class="layui-input-inline">
                                <select name="school" lay-filter="school" disabled>
                                    <option value="1">太原理工大学</option>
                                    <option value="2">中北大学</option>
                                    <option value="3">山西大学</option>
                                    <option value="4">太原师范大学</option>
                                    <option value="5" selected>太原工业学院</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">院系名称</label>
                            <div class="layui-input-inline">
                                <select name="department" lay-filter="department" disabled>
                                    <option value="1">机械工程系</option>
                                    <option value="2">电子工程系</option>
                                    <option value="3">自动化系</option>
                                    <option value="4">化学与化工系</option>
                                    <option value="5" selected>计算机工程系</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">专业名称</label>
                            <div class="layui-input-inline">
                                <select name="major" lay-filter="major">
                                    <option value="1">数字媒体技术</option>
                                    <option value="2">计算机科学与技术</option>
                                    <option value="3">网络工程</option>
                                    <option value="4">软件工程</option>
                                </select>
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
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
        <!--实现表格的序号自增-->
        <script type="text/html" id="id">
            {{d.LAY_TABLE_INDEX+1}}
        </script>
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
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
            url: '/DepartmentServlet?method=findAllDepart',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'id', width: 90, title: '序号', templet:'#id',sort: true},
                {field: 'school', width: 160, title: '学校'},
                {field: 'department', width: 170, title: '院系', sort: true},
                {field: 'major', width: 150, title: '专业'},
                {field: 'creatDate', width:150, title: '创建时间',sort:true},
                {field: 'stuNumber', width:120, title: '学生人数',sort: true},
                {field: 'offerNumber', width:120, title: '就业人数',sort:true},
                {field: 'remark', width: 150, title: '备注'}
            ]]
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
                    title: '添加专业',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['80%', '70%'],
                    content: 'addMajor.jsp',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            }
        });
    });
</script>

</body>
</html>
