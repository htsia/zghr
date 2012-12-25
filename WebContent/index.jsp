<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>czgm</title>
	<script type="text/javascript">
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 35;
            document.all("main").style.height=mainHeight+"px";
        }
    </script>
</head>
<body>
<table height="100%">
	<tr valign="top">
		<td height="600" width="100">
			<div>考核设置</div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/EvaRoleList.jsf">绩效角色定义admin</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/auditGroup.jsf">评审团维护</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/RelSetIndex.jsf">考核关系管理</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/eva/EvaGrade.jsf">考核等级管理</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/Set360KeyLib.jsf">360指标库管理</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/KpiLibSet.jsf">KPI指标库管理</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/Set360TempLib.jsf">360模版管理</a></div>
			<div>考核计划</div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/PlanList.jsf">考核计划管理</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/planKeySetIndex.jsf">指标构建</a></div>
			<div>实施与管理</div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/Person360AuditCtr.jsf">360考核监控</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/DeptKpiAuditCtr.jsf">部门KPI考核监控</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/PersonKpiAuditCtr.jsf">个人KPI考核监控</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/regStudentGrade.jsf">录入学生评价</a></div>
			<div>绩效评估与分析</div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/caclEvaPlan.jsf">结果计算</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/auditEvaPlan.jsf">结果审批</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/publicEvaPlan.jsf">结果发布</a></div>
		</td>
		<td>
			<iframe name="main" height="900" width="800"></iframe>
		</td>
	</tr>
</table>
</body>
</html>