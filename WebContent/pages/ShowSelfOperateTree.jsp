<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.user.pojo.bo.OperateBO"%>
<%@page import="java.util.List"%>
<%@page import="com.hr319wg.custom.dao.CommonDAO"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.user.util.MenuObj" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.user.service.UserManageService" %>
<%@ page import="com.hr319wg.user.pojo.bo.SelfOperateBO" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String moduleOperID = (String) session.getAttribute("moduleOperID");
    String subfolder = (String) session.getAttribute("subfolder");
    String bylevel = (String) session.getAttribute("bylevel");
    String ModuleID = (String) session.getAttribute("selfModuleId");
    
    String Root=(String) request.getParameter("Root");
    if (Root==null || "".equals(Root)){
        Root=SelfOperateBO.ZJLZZ_MODULEID;
    }
    String operURL="";
%>
<html>
<head><title></title>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ztree.core-3.5.min.js"></script>
    
</head>

<body topmargin="0" leftmargin="0">
	<div >
		<ul id="tree" class="ztree"></ul>
	</div>
<script language="javascript">
	var setting = {
		data: {
			simpleData: {
				enable: true
			}
		},callback: {
			onClick: function(event, treeId, treeNode){
				if (treeNode.key!=null){
		            var url = treeNode.key;
		 	       	if(url.indexOf("?")!=-1 && url.indexOf("/custom/")!=-1){
		 	       		url+="&inself=0";
		 	       	}else if(url.indexOf("/custom/")!=-1){
		 	       		url+="?inself=1";
		 	       	}
		 	        parent.refreshFun(url);
		         }
			}
		}
	};
	var zNodes =[];

    <%
        User user =  (User) session.getAttribute(Constants.USER_INFO);
        UserManageService us = (UserManageService) SysContext.getBean("user_userManageService");
        CommonDAO cd = (CommonDAO) SysContext.getBean("commondao");
        Hashtable hashMenus = us.getSelfFunction(Root, user);
        MenuObj allmenu = (MenuObj) hashMenus.get(Root);
		
         // 显示自助模块
        	if(ModuleID!=null){
        		out.println("zNodes.push({id:'"+moduleOperID+"',pId:-1,name:'"+SysCacheTool.findOperate(moduleOperID).getOperateName()+"',open:true,isParent:true})");
                if("1".equals(subfolder)){//有二级菜单
	                List<OperateBO> operList2 = cd.getAllSubOperateBOInSelf(moduleOperID, user.getUserId());
                	if(operList2 !=null ){
	                	int i=0;
    	                for(OperateBO bo : operList2){
    	                	if("1".equals(subfolder)){
    	                		out.println("zNodes.push({id:'"+bo.getOperateId()+"',pId:'"+moduleOperID+"',name:'"+bo.getOperateName()+"',open:true,isParent:true})");
    	                	}else{
    	                		out.println("zNodes.push({id:'"+bo.getOperateId()+"',pId:'"+moduleOperID+"',name:'"+bo.getOperateName()+"',key:'"+bo.getUrl()+"',icon:'/images/tree_images/book1_open.gif'})");
    	                	}
    	                	List<OperateBO> operList3 = cd.getAllOperateBOBySuperID(bo.getOperateId(), user.getUserId(), bylevel);
			                if(operList3!=null){
				                for(OperateBO bo3 : operList3){
				                	if(!"KQGL".equals(ModuleID)){
					                	if(i==0){
					                		operURL=bo3.getUrl();
					                	}
					                	i++;
				                	}
	    	                		out.println("zNodes.push({id:'"+bo3.getOperateId()+"',pId:'"+bo.getOperateId()+"',name:'"+bo3.getOperateName()+"',key:'"+bo3.getUrl()+"',icon:'/images/tree_images/book1_open.gif'})");
				                }
			                }
    	                }
                	}
                }else{
                	List<OperateBO> operList = cd.getAllOperateBO(ModuleID, user.getUserId(), bylevel);
	                if(operList!=null){
	                	int i=0;
		                for(OperateBO bo : operList){
		                	if(i==0){
		                		operURL=bo.getUrl();
		                	}
		                	i++;
   	                		out.println("zNodes.push({id:'"+bo.getOperateId()+"',pId:'"+moduleOperID+"',name:'"+bo.getOperateName()+"',key:'"+bo.getUrl()+"',icon:'/images/tree_images/book1_open.gif'})");
		                }
	                }
                }
        	}
    %>
    $(function(){
		$.fn.zTree.init($("#tree"), setting, zNodes);
	});
    if("<%=operURL%>"!=''){
    	var url = "<%=operURL%>";
       	if(url.indexOf("?")!=-1 && url.indexOf("/custom/")!=-1){
       		url+="&inself=1";
       	}else if(url.indexOf("/custom/")!=-1){
       		url+="?inself=1";
       	}
        parent.refreshFun(url);   	
    }
</script>

</body>
</html>