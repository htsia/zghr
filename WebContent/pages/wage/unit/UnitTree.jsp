<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageUnitBO" %>
<%@ page import="com.hr319wg.user.pojo.bo.RoleInfoBO" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    User user = (User) session.getAttribute(Constants.USER_INFO);

    String paramUnitId = request.getParameter("unitId");

    PersonBO person = SysCacheTool.findPersonById(user.getUserId());
    WageUnitBO unit = SysCacheTool.findWageUnit(person.getGongZiGX());

    if (unit == null) return;
    String treeId = "";
    boolean flag = false;
    if (user.ischo() && (User.AllUNIT.equals(user.getprocessUnit()) || RoleInfoBO.ORGTYPE_USD.equals(user.getprocessUnit()))) {
        treeId = "001";
    }
    else{
        treeId = unit.getTreeId();
    }

    String target = treeId;
    if (paramUnitId != null && !"".equals(paramUnitId)) {
        WageUnitBO paramunit = SysCacheTool.findWageUnit(paramUnitId);
        target = paramunit.getTreeId();
    }
%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ztree.core-3.5.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language="javascript">
	    var zTree;
		var setting = {
			data: {
				simpleData: {
					enable: true
				}
			},async: {
				enable: true,
				url:"/pages/ajax/WageUnit.jsp",
				autoParam:["id"]
			},callback: {
				onAsyncSuccess: function(event, treeId, treeNode){
					treeNode.halfCheck = false;
					zTree.updateNode(treeNode);
				},onClick: function(event, treeId, treeNode){
					parent.refreshList(treeNode.id, treeNode.childNum);
				}
			}
		};
		$(function(){
			var zData=null;
			var url="/pages/ajax/WageUnit.jsp?id=-1";
			$.post(url,function(data){
				zData=eval(data);
				zTree=$.fn.zTree.init($("#tree"), setting, zData);
				var nodes = zTree.getNodes();
		        zTree.expandNode(nodes[0], true);
			});
		});
    </script>
</head>

<body>
	<div >
		<ul id="tree" class="ztree"></ul>
	</div>
</body>
</html>