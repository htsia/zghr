<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.user.ucc.ISelfInfoPowerUCC" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.user.pojo.vo.InfoSetPermissionVO" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    ArrayList list = new ArrayList();
    try {
        ISelfInfoPowerUCC ucc = (ISelfInfoPowerUCC) SysContext.getBean("user_selfinfoUccImpl");
        User user = (User) session.getAttribute(Constants.USER_INFO);
        List powerlist = ucc.getSelfInfoSet(user.getOrgId());
        for (int i = 0; i < powerlist.size(); i++) {
            InfoSetPermissionVO vo = (InfoSetPermissionVO) powerlist.get(i);
            if ("2".equals(vo.getPermission()) || "3".equals(vo.getPermission())){
               list.add(SysCacheTool.findInfoSet(vo.getSetId()));
            }
        }

    } catch (Exception e) {
%>
<script type="text/javascript">alert("<%=e.getMessage()%>")</script>
<%
    }
%>
<html>
<head>
	<title></title>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ztree.core-3.5.min.js"></script>
	<script src="/js/Appclient.js" type="text/javascript"></script>
	<script language="javascript">
		var setting = {
			data: {
				simpleData: {
					enable: true
				}
			},callback: {
				onClick: function(event, treeId, treeNode){
		 	        parent.refreshList(treeNode.setId,treeNode.setType);
				}
			}
		};
		var zNodes =[];
		<%
		    //»­Ö¸±ê¼¯
		    for(int i=0;i<list.size();i++){
		        InfoSetBO set = (InfoSetBO)list.get(i);
		        out.println("zNodes.push({id:'"+set.getSetId()+"',pId:'0',name:'"+set.getSetName()+"',setId:'"+set.getSetId()+"',setType:'"+set.getSet_rsType()+"',open:true,icon:'/images/tree_images/hfile.gif'})");
		    }
		
		%>
		$(function(){
			$.fn.zTree.init($("#tree"), setting, zNodes);
		});
	</script>
</head>

<body bgcolor="#FFFFFF"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<div >
		<ul id="tree" class="ztree"></ul>
	</div>
</body>
</html>