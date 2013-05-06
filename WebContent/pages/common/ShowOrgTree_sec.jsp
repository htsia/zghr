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
    
    <script language="javascript">
        var cancelFlag1="<%=cancelFlag%>";
        var showGroup1="<%=Constants.TREE_SHOW_GROUP%>";
        var rightFlag1="<%=rightFlag%>";
        var rootId1="<%=rootId%>";
        var secDeptTreeId1="<%=secDeptTreeId%>";
        var treeIndex=0;
        var zTree;
		var setting = {
			data: {
				simpleData: {
					enable: true
				}
			},async: {
				enable: true,
				url:"../ajax/Org_sec.jsp",
				autoParam:["id"],
				otherParam:{"cancelFlag":cancelFlag1,"showGroup":showGroup1,"rightFlag":rightFlag1,"secDeptTreeId":secDeptTreeId1}
			},callback: {
				onAsyncSuccess: function(event, treeId, treeNode){
					treeNode.halfCheck = false;
					zTree.updateNode(treeNode);
				},onNodeCreated: function(event, treeId, treeNode){
					treeIndex++;
					if(rootId1==null || rootId1==''){
						if(treeNode.pId==null){
							treeRootId=treeNode.id;
						}
						if(treeNode.pId==treeRootId && treeIndex==2){
							zTree.expandNode(treeNode, true);
						}
					}
				},onClick: function(event, treeId, treeNode){
					parent.refreshList(treeNode.id,treeNode.pId );
				}
			}
		};
		$(function(){
			var zData=null;
			var url="../ajax/Org_sec.jsp?cancelFlag="+cancelFlag1+"&showGroup="+showGroup1+"&id=-1&rightFlag="+rightFlag1+"&rootId="+rootId1+"&secDeptTreeId="+secDeptTreeId1;
			$.post(url,function(data){
				zData=eval(data);
				zTree=$.fn.zTree.init($("#tree"), setting, zData);
				var nodes = zTree.getNodes();
		        zTree.expandNode(nodes[0], true);
			});
		});
    </script>
</head>

<body topmargin="0" leftmargin="0" BGCOLOR=<%=Constants.BGCOLOR%>>
	<div >
		<ul id="tree" class="ztree"></ul>
	</div>
</body>
</html>