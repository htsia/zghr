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
			<div>��������</div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/EvaRoleList.jsf">��Ч��ɫ����admin</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/auditGroup.jsf">������ά��</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/RelSetIndex.jsf">���˹�ϵ����</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/eva/EvaGrade.jsf">���˵ȼ�����</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/Set360KeyLib.jsf">360ָ������</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/KpiLibSet.jsf">KPIָ������</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/Set360TempLib.jsf">360ģ�����</a></div>
			<div>���˼ƻ�</div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/PlanList.jsf">���˼ƻ�����</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/planKeySetIndex.jsf">ָ�깹��</a></div>
			<div>ʵʩ�����</div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/Person360AuditCtr.jsf">360���˼��</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/DeptKpiAuditCtr.jsf">����KPI���˼��</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/PersonKpiAuditCtr.jsf">����KPI���˼��</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/regStudentGrade.jsf">¼��ѧ������</a></div>
			<div>��Ч���������</div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/caclEvaPlan.jsf">�������</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/auditEvaPlan.jsf">�������</a></div>
			<div><a target="main" href="main.jsp?username=admin&url=/xys/eva/publicEvaPlan.jsf">�������</a></div>
		</td>
		<td>
			<iframe name="main" height="900" width="800"></iframe>
		</td>
	</tr>
</table>
</body>
</html>