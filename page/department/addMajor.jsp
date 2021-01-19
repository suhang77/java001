<%--
  Created by IntelliJ IDEA.
  User: 木木
  Date: 2021/1/19
  Time: 12:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加专业</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="../../css/public.css" media="all">
    <style>
        body {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div class="layui-form layuimini-form">
    <div class="layui-form-item">
        <label class="layui-form-label required">学校名称</label>
        <div class="layui-input-block">
            <input type="text" name="school" lay-verify="required" value="太原工业学院" class="layui-input" readonly>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">院系名称</label>
        <div class="layui-input-block">
            <input type="text" name="department" lay-verify="required" value="计算机工程系" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">专业名称</label>
        <div class="layui-input-block">
            <input type="text" name="major" lay-verify="required" placeholder="请输入专业名称" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label ">创建时间</label>
        <div class="layui-input-block" >
            <input id="creatDate" type="text" name="creatDate" placeholder="请选择创建时间" value="" class="layui-input" lay-verify="required" lay-reqtext="时间不能为空" readonly>
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label required">学生总人数</label>
        <div class="layui-input-block">
            <input type="number" name="stuNumber" lay-verify="required" placeholder="请输入学生总人数" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">就业学生人数</label>
        <div class="layui-input-block">
            <input type="number" name="offerNumber" lay-verify="required" placeholder="请输入就业学生人数" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">备注信息</label>
        <div class="layui-input-block">
            <textarea name="remark" class="layui-textarea" placeholder="请输入备注信息"></textarea>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认保存</button>
        </div>
    </div>
</div>
<script src="../../lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    // 年月日选择器（加入时间）
    layui.use('laydate',function () {
        var laydate = layui.laydate;
        laydate.render({
            elem: '#creatDate',
            trigger: 'click'
        });

    })

    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$;

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            var index = layer.alert(JSON.stringify(data.field), {
                title: '最终的提交信息'
            }, function () {

                // 关闭弹出层
                layer.close(index);

                var iframeIndex = parent.layer.getFrameIndex(window.name);
                parent.layer.close(iframeIndex);

            });

            return false;
        });

    });
</script>
</body>
</html>