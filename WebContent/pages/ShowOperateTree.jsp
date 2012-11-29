<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.oa319wg.user.pojo.vo.OAUser" %>
<%@ page import="com.hr319wg.user.util.MenuObj" %>
<%@ page import="com.oa319wg.user.pojo.bo.OAOperateBO" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String ModuleID = (String) session.getAttribute("moduleId");
    if (ModuleID == null && "".equals(ModuleID)) {
        ModuleID = OperateBO.PERMODULEID;
    }
%>
<html>
<head><title></title>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ztree.core-3.5.min.js"></script>
    
    <script type="text/javascript">
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
			 	       		url+="?inself=0";
			 	       	}
			 	        parent.refreshFun(url);
			         }
				}
			}
		};
		var zNodes =[];
    	<%
	        User user =  (User) session.getAttribute(Constants.USER_INFO);
	        Hashtable hashMenus = user.getPmsMenus();
	        MenuObj menu=(MenuObj)hashMenus.get(ModuleID);
	        out.println("zNodes.push({id:'"+menu.getOperateId()+"',pId:-1,name:'"+menu.getName()+"',open:true,isParent:true})");
	        for(int i=0;menu.getMenus()!=null && i<menu.getMenus().size();i++){
	            MenuObj childmenu=(MenuObj)menu.getMenus().get(i);
	            if (childmenu.getUrl()==null || "".equals(childmenu.getUrl())){
	            	out.println("zNodes.push({id:'"+childmenu.getOperateId()+"',pId:'"+menu.getOperateId()+"',name:'"+childmenu.getName()+"',open:true,isParent:true})");
	            }else{
	            	out.println("zNodes.push({id:'"+childmenu.getOperateId()+"',pId:'"+menu.getOperateId()+"',name:'"+childmenu.getName()+"',key:\""+childmenu.getUrl()+"\",icon:'/images/tree_images/book1_open.gif'})");
	            }
	            for(int j=0;childmenu.getMenus()!=null && j<childmenu.getMenus().size();j++){
	                MenuObj childchildmenu=(MenuObj)childmenu.getMenus().get(j);
	                if (childchildmenu.getUrl()==null || "".equals(childchildmenu.getUrl())){
	                	out.println("zNodes.push({id:'"+childchildmenu.getOperateId()+"',pId:'"+childmenu.getOperateId()+"',name:'"+childchildmenu.getName()+"',open:true,isParent:true})");
		            }else{
		            	out.println("zNodes.push({id:'"+childchildmenu.getOperateId()+"',pId:'"+childmenu.getOperateId()+"',name:'"+childchildmenu.getName()+"',key:\""+childchildmenu.getUrl()+"\",icon:'/images/tree_images/book1_open.gif'})");
		            }
	                for(int k=0;childchildmenu.getMenus()!=null && k<childchildmenu.getMenus().size();k++){
	                    MenuObj childchildchildmenu=(MenuObj)childchildmenu.getMenus().get(k);
	                    if (childchildchildmenu.getUrl()==null || "".equals(childchildchildmenu.getUrl())){
	                    	out.println("zNodes.push({id:'"+childchildchildmenu.getOperateId()+"',pId:'"+childchildmenu.getOperateId()+"',name:'"+childchildchildmenu.getName()+"',open:true,isParent:true})");
			            }else{
			            	out.println("zNodes.push({id:'"+childchildchildmenu.getOperateId()+"',pId:'"+childchildmenu.getOperateId()+"',name:'"+childchildchildmenu.getName()+"',key:\""+childchildchildmenu.getUrl()+"\",icon:'/images/tree_images/book1_open.gif'})");
			            }
	                }
	            }
	        }
	    %>
		$(function(){
			$.fn.zTree.init($("#tree"), setting, zNodes);
		});
    </script>
</head>

<body topmargin="0" leftmargin="0">
	<div >
		<ul id="tree" class="ztree"></ul>
	</div>
</body>
</html>