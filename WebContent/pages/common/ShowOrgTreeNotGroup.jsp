
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String cancelFlag=CommonFuns.filterNull(request.getParameter("cancelFlag"));
    String rootId = CommonFuns.filterNull(request.getParameter("rootId"));
    String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));
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
        var rightFlag1="<%=rightFlag%>";
        var rootId1="<%=rootId%>";
        var zTree;
		var setting = {
			data: {
				simpleData: {
					enable: true
				}
			},async: {
				enable: true,
				url:"../ajax/Org.jsp",
				autoParam:["id"],
				otherParam:{"cancelFlag":cancelFlag1,"rightFlag":rightFlag1}
			},callback: {
				onAsyncSuccess: function(event, treeId, treeNode){
					treeNode.halfCheck = false;
					zTree.updateNode(treeNode);
				},onNodeCreated: function(event, treeId, treeNode){
					if(rootId1==null || rootId1==''){
						if(treeNode.pId==null){
							treeRootId=treeNode.id;
						}
						if(treeNode.pId==treeRootId){
							zTree.expandNode(treeNode, true);
						}
					}
				},onClick: function(event, treeId, treeNode){
					parent.refreshList(treeNode.id);
				}
			}
		};
		$(function(){
			var zData=null;
			var url="../ajax/Org.jsp?cancelFlag="+cancelFlag1+"&id=-1&rightFlag="+rightFlag1+"&rootId="+rootId1;
			$.post(url,function(data){
				zData=eval(data);
				zTree=$.fn.zTree.init($("#tree"), setting, zData);
				var nodes = zTree.getNodes();
		        zTree.expandNode(nodes[0], true);
			});
		});
    </script>
</head>

<body topmargin="0" leftmargin="0">
	<div >
		<ul id="tree" class="ztree"></ul>
	</div>
</body>
</html>