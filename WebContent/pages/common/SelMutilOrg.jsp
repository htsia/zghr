<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String dict_num = request.getParameter("dict_num");
    if (dict_num == null) return;
    String curCode = request.getParameter("curCode");
    String codes = "";
    String trees = "";

    if (curCode != null && !"".equals(curCode)) {
        String[] codeArrray = curCode.split(",");
        for (int i = 0; i < codeArrray.length; i++) {
            OrgBO org = SysCacheTool.findOrgById(codeArrray[i]);
            if (org != null)
                trees += ",'" + org.getTreeId() + "'";
        }
        trees = trees.substring(1);
    }

    String value = request.getParameter("value");
    if (value == null || "".equals(value)) {
        trees = null;
    }
%>
<html>
<head><title></title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ztree.excheck-3.5.min.js"></script>
<script language="javascript">
	var zTree;
	var setting = {
		check: {
			enable: true,
			chkboxType :{ "Y" : "", "N" : "" }
		},
		data: {
			simpleData: {
				enable: true
			}
		},async: {
			enable: true,
			url:"../ajax/Org.jsp",
			autoParam:["id"]
		},callback: {
			onAsyncSuccess: function(event, treeId, treeNode){
				treeNode.halfCheck = false;
				zTree.updateNode(treeNode);
			},onClick: function(event, treeId, treeNode){
				window.returnValue = treeNode.id+"|"+treeNode.name;
	            window.close();
			}
		}
	};
	$(function(){
		var zData=null;
		var url="../ajax/Org.jsp?id=-1&rightFlag=<%=CommonFuns.filterNull(request.getParameter("rightFlag"))%>&rootId=<%=CommonFuns.filterNull(request.getParameter("rootId"))%>";
		$.post(url,function(data){
			zData=eval(data);
			zTree=$.fn.zTree.init($("#tree"), setting, zData);
			var nodes = zTree.getNodes();
	        zTree.expandNode(nodes[0], true);
		});
	});
	function doSel(){
		var zTree = $.fn.zTree.getZTreeObj("tree");
		var chks = zTree.getCheckedNodes(true);
		if(chks.length>0){
			var ids="";
			var names="";
			for(var i=0;i<chks.length;i++){
				ids+=chks[i].id;
				names+=chks[i].name;
				if(i+1<chks.length){
					ids+=",";
					names+=",";
				}
			}
			window.returnValue = ids+"|"+names;
	        window.close();
		}else{
			alert("请选择机构");			
		}
	}
	function doClear(){
		window.returnValue = null;
        window.close();
	}
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
 <table>
   <tr><td align="left">
    <input type="button" value="选择" onclick="doSel()" class="button01">
    <input type="button" value="取消选择" onclick="doClear()" class="button01">
   </tr>

   <tr><td>
 	<div >
		<ul id="tree" class="ztree"></ul>
	</div>
   </td></tr>
</table>
</body>
</html>