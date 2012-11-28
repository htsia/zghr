<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head><title></title>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ztree.core-3.5.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/Appclient.js" language="JavaScript"></script>
    <script language="javascript">
    	var rootId1=null;
	    var zTree;
		var setting = {
			data: {
				simpleData: {
					enable: true
				}
			},async: {
				enable: true,
				url:"/pages/ajax/Org.jsp",
				autoParam:["id"],
				otherParam:{"rightFlag":"1"}
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
			var url="/pages/ajax/Org.jsp?id=-1&rightFlag=1";
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