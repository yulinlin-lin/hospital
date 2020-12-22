<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://shiro.apache.org/tags" prefix="shiro"%>
<html>
<head>
    <title>xx市第二人民医院信息管理系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="${pageContext.request.contextPath}/assets/css/dpl-min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/bui-min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/main-min.css" rel="stylesheet" type="text/css" />
</head>
<body>

<div class="header">

    <div class="dl-title">
        <!--<img src="/chinapost/Public/assets/img/top.png">-->
    </div>

    <div class="dl-log">欢迎您，<span class="dl-log-user">${sessionScope.user.no}</span>
	
	<a href="${pageContext.request.contextPath }/logout" title="退出系统" class="dl-log-quit">[退出]</a>
    </div>
</div>
<div class="content">
    <div class="dl-main-nav">
        <div class="dl-inform"><div class="dl-inform-title"><s class="dl-inform-icon dl-up"></s></div></div>
        <ul id="J_Nav"  class="nav-list ks-clear">
            <li class="nav-item dl-selected"><div class="nav-item-inner nav-home">医院管理系统</div></li>

		</ul>
    </div>
    <ul id="J_NavContent" class="dl-tab-conten">
    </ul>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-1.6.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/bui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/common/main-min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/config-min.js"></script>
<script>
    BUI.use('common/main',function(){
        var config = [
			{id:'1',menu:[
				
		{text:'快速通道',items:[
		    {id:'2',text:'挂号信息管理',href:'${pageContext.request.contextPath}/registration/index/1/5'},
		{id:'3',text:'门诊医生管理',href:'${pageContext.request.contextPath}/doctor/index/1/5'},
		{id:'4',text:'药品管理',href:'${pageContext.request.contextPath}/drugs/index/1/5'},
		/*{id:'5',text:'住院办理',href:'${pageContext.request.contextPath}/hospital/index.html'},
		{id:'6',text:'收费项目登记',href:'${pageContext.request.contextPath}/hospital/charge.html'},
		{id:'7',text:'在院发药',href:'${pageContext.request.contextPath}/hospital/dispensing.html'},
		{id:'8',text:'住院结算',href:'${pageContext.request.contextPath}/hospital/account.html'},
		{id:'9',text:'月营业额统计',href:''},
		{id:'10',text:'年营业额统计',href:''},*/
		
		{id:'11',text:'用户管理',href:'${pageContext.request.contextPath}/user/index/1/5'},
		{id:'12',text:'角色管理',href:'${pageContext.request.contextPath}/role/index/1/5'},
		{id:'13',text:'资源管理',href:'${pageContext.request.contextPath}/resource/index/1/5'},
		{id:'14',text:'密码设置	',href:'${pageContext.request.contextPath}/user/passRestPage'}
		
		]}
			
			]}
		
		];
        new PageUtil.MainPage({
            modulesConfig : config
        });
    });
</script>
</body>
</html>