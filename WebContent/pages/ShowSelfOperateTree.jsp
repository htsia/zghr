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
    <script src="<%=request.getContextPath()%>/js/tree.js" language="JavaScript"></script>
    <script src="<%=request.getContextPath()%>/js/Appclient.js" language="JavaScript"></script>
</head>

<body topmargin="0" leftmargin="0">
<div id="tt">
</div>
<script language="javascript">
    //定义树的图片对象
    var images = getTreeImage();
    //初始化树
    var tree = new newtree(images, 16, tt);
    <%
        User user =  (User) session.getAttribute(Constants.USER_INFO);
        UserManageService us = (UserManageService) SysContext.getBean("user_userManageService");
        CommonDAO cd = (CommonDAO) SysContext.getBean("commondao");
        Hashtable hashMenus = us.getSelfFunction(Root, user);
        MenuObj allmenu = (MenuObj) hashMenus.get(Root);
		
        if (ModuleID==null || "".equals(ModuleID)){  // 显示全部菜单
            String icon="folder";
            for(int i=0;allmenu.getMenus()!=null && i<allmenu.getMenus().size();i++){
                MenuObj childmenu=(MenuObj)allmenu.getMenus().get(i);
                if (childmenu.getUrl()==null || "".equals(childmenu.getUrl())){
                    icon="folder";
                }
                else{
                   icon="book_open";
                }
                out.println("tree.add(tree.root, 'last', '"+childmenu.getName()+"', 'n' + '"+childmenu.getOperateId()+"', '"+childmenu.getUrl()+"', '', '"+icon+"', '', '');");
                for(int j=0;childmenu.getMenus()!=null && j<childmenu.getMenus().size();j++){
                    MenuObj childchildmenu=(MenuObj)childmenu.getMenus().get(j);
                    if (childchildmenu.getUrl()==null || "".equals(childchildmenu.getUrl())){
                        icon="folder";
                    }
                    else{
                       icon="book_open";
                    }
                    out.println("tree.add(tree.nodes['n'+'"+childmenu.getOperateId()+"'], 'last', '"+childchildmenu.getName()+"', 'n' + '"+childchildmenu.getOperateId()+"', '"+childchildmenu.getUrl()+"', '', '"+icon+"', '', '');");
                    for(int k=0;childchildmenu.getMenus()!=null && k<childchildmenu.getMenus().size();k++){
                        MenuObj childchildchildmenu=(MenuObj)childchildmenu.getMenus().get(k);
                        if (childchildchildmenu.getUrl()==null || "".equals(childchildchildmenu.getUrl())){
                            icon="folder";
                        }
                        else{
                           icon="book_open";
                        }

                        out.println("tree.add(tree.nodes['n'+'"+childchildmenu.getOperateId()+"'], 'last', '"+childchildchildmenu.getName()+"', 'n' + '"+childchildchildmenu.getOperateId()+"', '"+childchildchildmenu.getUrl()+"', '', '"+icon+"', '', '');");
                    }
                }
            }
        }
        else{   // 显示自助模块
        	if(ModuleID!=null && ModuleID.endsWith("GL")){
        		if("KQGL".equals(ModuleID)){
               		operURL="/custom/attence/attLeaveQuery.jsf";
            	}
        		String icon="folder";
                out.println("tree.add(tree.root, 'last', '"+SysCacheTool.findOperate(moduleOperID).getOperateName()+"', 'n' + '"+ModuleID+"', '', '', '"+icon+"', '', '');");
                if("1".equals(subfolder)){//有二级菜单
	                List<OperateBO> operList2 = cd.getAllSubOperateBOInSelf(moduleOperID, user.getUserId());
                	if(operList2 !=null ){
	                	int i=0;
    	                for(OperateBO bo : operList2){
			        		icon="folder";
    	                	out.println("tree.add(tree.nodes['n'+'"+ModuleID+"'], 'last', '"+bo.getOperateName()+"', 'n' + '"+bo.getOperateId()+"', \""+bo.getUrl()+"\", '', '"+icon+"', '', '');");
    	                	List<OperateBO> operList3 = cd.getAllOperateBOBySuperID(bo.getOperateId(), user.getUserId(), bylevel);
			                if(operList3!=null){
				                icon="book_open";
				                for(OperateBO bo3 : operList3){
				                	if(!"KQGL".equals(ModuleID)){
					                	if(i==0){
					                		operURL=bo3.getUrl();
					                	}
					                	i++;
				                	}
				                	out.println("tree.add(tree.nodes['n'+'"+bo.getOperateId()+"'], 'last', '"+bo3.getOperateName()+"', 'n' + '"+bo3.getOperateId()+"', \""+bo3.getUrl()+"\", '', '"+icon+"', '', '');");
				                }
			                }
    	                }
                	}
                }else{
	                icon="book_open";
                	List<OperateBO> operList = cd.getAllOperateBO(ModuleID, user.getUserId(), bylevel);
	                if(operList!=null){
	                	int i=0;
		                for(OperateBO bo : operList){
		                	if(i==0){
		                		operURL=bo.getUrl();
		                	}
		                	i++;
		                	out.println("tree.add(tree.nodes['n'+'"+ModuleID+"'], 'last', '"+bo.getOperateName()+"', 'n' + '"+bo.getOperateId()+"', \""+bo.getUrl()+"\", '', '"+icon+"', '', '');");
		                	
		                }
	                }
                }
        	}else{
        		MenuObj menu=null;
                for(int i=0;i<allmenu.getMenus().size();i++){
                   if (((MenuObj)allmenu.getMenus().get(i)).getOperateId().equals(ModuleID)){
                      menu=(MenuObj)allmenu.getMenus().get(i);
                      break;
                    }
                }
                String icon="folder";
                out.println("tree.add(tree.root, 'last', '"+menu.getName()+"', 'n' + '"+ModuleID+"', '', '', '"+icon+"', '', '');");
                for(int i=0;menu.getMenus()!=null && i<menu.getMenus().size();i++){
                    MenuObj childmenu=(MenuObj)menu.getMenus().get(i);
                    if (childmenu.getUrl()==null || "".equals(childmenu.getUrl())){
                        icon="folder";
                    }
                    else{
                       icon="book_open";
                    }
                    out.println("tree.add(tree.nodes['n'+'"+ModuleID+"'], 'last', '"+childmenu.getName()+"', 'n' + '"+childmenu.getOperateId()+"', \""+childmenu.getUrl()+"\", '', '"+icon+"', '', '');");
                    for(int j=0;childmenu.getMenus()!=null && j<childmenu.getMenus().size();j++){
                        MenuObj childchildmenu=(MenuObj)childmenu.getMenus().get(j);
                        if (childchildmenu.getUrl()==null || "".equals(childchildmenu.getUrl())){
                            icon="folder";
                        }
                        else{
                           icon="book_open";
                        }
                        out.println("tree.add(tree.nodes['n'+'"+childmenu.getOperateId()+"'], 'last', '"+childchildmenu.getName()+"', 'n' + '"+childchildmenu.getOperateId()+"', \""+childchildmenu.getUrl()+"\", '', '"+icon+"', '', '');");
                        for(int k=0;childchildmenu.getMenus()!=null && k<childchildmenu.getMenus().size();k++){
                            MenuObj childchildchildmenu=(MenuObj)childchildmenu.getMenus().get(k);
                            if (childchildchildmenu.getUrl()==null || "".equals(childchildchildmenu.getUrl())){
                                icon="folder";
                            }
                            else{
                               icon="book_open";
                            }
                            out.println("tree.add(tree.nodes['n'+'"+childchildmenu.getOperateId()+"'], 'last', '"+childchildchildmenu.getName()+"', 'n' + '"+childchildchildmenu.getOperateId()+"', \""+childchildchildmenu.getUrl()+"\", '', '"+icon+"', '', '');");
                        }
                    }
                }        		
        	}
        }
    %>
    tree.onclick = function(srcNode) {
        //debugger;
        if (srcNode.key2!=null && srcNode.key2!="" && srcNode.key2!="null"){
        	var url = srcNode.key2;
        	if(url.indexOf("?")!=-1 && url.indexOf("/custom/")!=-1){
        		url+="&inself=1";
        	}else if(url.indexOf("/custom/")!=-1){
        		url+="?inself=1";
        	}
            parent.refreshFun(url);
        }
    }
    if("<%=operURL%>"!=''){
    	var url = "<%=operURL%>";
    	<%
    		String approtype=String.valueOf(session.getAttribute("approtype"));
    	    session.removeAttribute("approtype");
    		if(approtype!=null && !"".equals(approtype) && !"null".equals(approtype)){
    			String[]auditUrls={"attLeaveAudit","attOutAudit","attOvertimeAudit","attRestAudit"};
    			int index=Integer.valueOf(approtype);
    			%>
    			url="/custom/attence/<%=auditUrls[index]%>.jsf";
    			<%
    		}
    	%>
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