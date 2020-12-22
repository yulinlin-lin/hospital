<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>更改挂号</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/bootstrap-responsive.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/style.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/jquery.js"></script>
    <%--    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/jquery.sorted.js"></script>--%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/bootstrap.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/ckform.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/common.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/ckeditor/ckeditor.js"></script>


    <style type="text/css">
        body {
            padding-bottom: 40px;
        }

        .sidebar-nav {
            padding: 9px 0;
        }

        @media (max-width: 980px) {
            /* Enable use of floated navbar text */
            .navbar-text.pull-right {
                float: none;
                padding-left: 5px;
                padding-right: 5px;
            }
        }


    </style>
    <script type="text/javascript">
        $(function () {
            $('#backid').click(function () {
                // window.location.href = "index.html";
                window.history.back(-1);
            });
        });
    </script>
</head>
<body>
<form action="${pageContext.request.contextPath}/registration/addRegister" method="post" class="definewidth m20">
    <table class="table table-bordered table-hover definewidth m10">
        <tr>
            <td width="10%" class="tableleft">姓名</td>
            <td><input type="text" name="name" value=""/></td>
        </tr>

        <tr>
            <td width="10%" class="tableleft">证件类型</td>
            <td>
                <select name="identifierType">
                    <option>身份证</option>
                    <option>护照</option>
                    <option>军人证</option>
                </select>
            </td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">证件号</td>
            <td><input type="text" name="identifier" value=""/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">社保号</td>
            <td><input type="text" name="insuranceint" value=""/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">挂号费</td>
            <td><input type="text" name="guahaofei" value=""/>元</td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">联系电话</td>
            <td><input type="text" name="phone" value=""/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">是否自费</td>
            <td><input type="radio" name="expenseFlag" value="否" checked/>否&nbsp;&nbsp;&nbsp;
                <input type="radio" name="expenseFlag" value="是"/>是
            </td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">性别</td>
            <td><input type="radio" name="gender" value="1" checked/>男&nbsp;&nbsp;&nbsp;
                <input type="radio" name="gender" value="0"/>女
            </td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">年龄</td>
            <td><input type="text" name="age" value=""/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">职业</td>
            <td><input type="text" name="profession" value=""/></td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">初复诊</td>
            <td><input type="radio" name="czflag" value="初诊" checked/>初诊&nbsp;&nbsp;&nbsp;
                <input type="radio" name="czflag" value="复诊"/>复诊
            </td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">所挂科室</td>
            <td>
                <select id="ks" name="" onchange="changeDorctor(this.value);">
                    <option value="0">--请选择科室--</option>
                    <%--<option value=''>急诊科</option>--%>
                </select>
            </td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">指定医生</td>
            <td>
                <select id="docs" name="doctorId">
                </select>
            </td>
        </tr>
        <tr>
            <td width="10%" class="tableleft">备注</td>
            <td><textarea name="remark"></textarea></td>
        </tr>
        <tr>
            <td colspan="2">
                <center>
                    <button type="submit" class="btn btn-primary" type="button">保存</button> &nbsp;&nbsp;<button
                        type="button" class="btn btn-success" name="backid" id="backid">返回列表
                </button>
                </center>
            </td>
        </tr>
    </table>
</form>


<script>

    $(function () {
        indexKs();   //  所挂科室；

    });


    /***
     初始化所挂科室
     */
    function indexKs() {
        $.ajax({
            type: "post",
            url: "${pageContext.request.contextPath}/dep/getDepsList",
            dataType: "json",
            success: function (res) {
                $.each(res, function (i, r) {
                    $("#ks").append("<option value=" + r.depId + ">" + r.depName + "</option>");
                });
            },
            error: function () {
                alert("ajax函数发生异步");
            }
        });
    }


    /***
     * 当改变  所挂科室时    就会改变医生的下拉列表；
     * @param depid
     */
    function changeDorctor(depid) {

        if (depid == -1) {
            return;
        }
        // alert(depid);

        $.ajax({
            type: "post",
            url: "${pageContext.request.contextPath}/doctor/queryByDepId",
            data: {"depid": depid},
            success: function (res) {
                $("#docs").empty();
                // $("#docs").clean();
                $.each(res, function (i, r) {
                    $("#docs").append("<option value=" + r.doctorId + ">" + r.name + "</option>");
                })
            }
        })

    }

</script>
</body>
</html>