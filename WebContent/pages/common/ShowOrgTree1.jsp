<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.org.pojo.bo.OrgBO"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String cancelFlag=CommonFuns.filterNull(request.getParameter("cancelFlag"));
    String rootId = CommonFuns.filterNull(request.getParameter("rootId"));
    String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));
    
    String secDeptTreeId=null;
    String secDeptId = CommonFuns.filterNull(request.getParameter("secDeptId"));
    if(secDeptId!=null && !"".equals(secDeptId) && !"null".equals(secDeptId)){
	    OrgBO org = SysCacheTool.findOrgById(secDeptId.substring(4));
	    secDeptTreeId=org.getTreeId();
    }
    if(rightFlag == null || "".equals(rightFlag.trim())){
         rightFlag = "1";
    }
%>
<html>
<head><title></title>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ztree.core-3.5.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/Appclient.js" language="JavaScript"></script>
    <script language="javascript">
		var zNodes = [];
		var setting = {
				data: {
					simpleData: {
						enable: true
					}
				},
				async: {
					enable: true,
					url:"../ajax/Org1.jsp",
					autoParam:["id", "name=n", "level=lv"],
					otherParam:{"otherParam":"zTreeAsyncTest"}
				}
			};
			$(document).ready(function(){
				$.fn.zTree.init($("#tree"), setting);
			});
        $(function(){
			$.fn.zTree.init($("#tree"), setting, zNodes);
		});
    </script>
</head>

<body topmargin="0" leftmargin="0" BGCOLOR=<%=Constants.BGCOLOR%>>
	<div >
		<ul id="tree" class="ztree"></ul>
	</div>

</body>
</html>