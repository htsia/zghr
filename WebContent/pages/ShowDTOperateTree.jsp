<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.user.util.MenuObj" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.user.service.UserManageService" %>
<%@ page import="com.hr319wg.user.pojo.bo.DeskTopOperateBO" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String ModuleID = (String) session.getAttribute("selfModuleId");
%>
<html>
<head>
    <title></title>
    <link href="/css/styleDesktop.css" rel="stylesheet" type="text/css"/>
    <script src="<%=request.getContextPath()%>/js/tree.js" language="JavaScript"></script>
    <script src="<%=request.getContextPath()%>/js/Appclient.js" language="JavaScript"></script>
</head>

<body topmargin="0" leftmargin="0" BGCOLOR=<%=Constants.BGCOLOR%>>
<div id="tt">
</div>
<script language="javascript">
    //定义树的图片对象
    inLead=1;
    var images = getTreeImage();
    //初始化树
    var tree = new newtree(images, 16, tt);
    <%
        User user =  (User) session.getAttribute(Constants.USER_INFO);
        UserManageService us = (UserManageService) SysContext.getBean("user_userManageService");
        Hashtable hashMenus = us.getDesktopFunction(DeskTopOperateBO.ZJLZZ_MODULEID, user);
        MenuObj allmenu = (MenuObj) hashMenus.get(DeskTopOperateBO.ZJLZZ_MODULEID);

        if (ModuleID==null || "".equals(ModuleID)){  // 显示全部菜单
            String icon="database";
            for(int i=0;allmenu.getMenus()!=null && i<allmenu.getMenus().size();i++){
                MenuObj childmenu=(MenuObj)allmenu.getMenus().get(i);
                if (childmenu.getUrl()==null || "".equals(childmenu.getUrl())){
                    icon="database";
                }
                else{
                   icon="book_open";
                }
                out.println("tree.add(tree.root, 'last', '"+childmenu.getName()+"', 'n' + '"+childmenu.getOperateId()+"', '"+childmenu.getUrl()+"', '', '"+icon+"', '', '');");
                for(int j=0;childmenu.getMenus()!=null && j<childmenu.getMenus().size();j++){
                    MenuObj childchildmenu=(MenuObj)childmenu.getMenus().get(j);
                    if (childchildmenu.getUrl()==null || "".equals(childchildmenu.getUrl())){
                        icon="database";
                    }
                    else{
                       icon="book_open";
                    }
                    out.println("tree.add(tree.nodes['n'+'"+childmenu.getOperateId()+"'], 'last', '"+childchildmenu.getName()+"', 'n' + '"+childchildmenu.getOperateId()+"', '"+childchildmenu.getUrl()+"', '', '"+icon+"', '', '');");
                    for(int k=0;childchildmenu.getMenus()!=null && k<childchildmenu.getMenus().size();k++){
                        MenuObj childchildchildmenu=(MenuObj)childchildmenu.getMenus().get(k);
                        if (childchildchildmenu.getUrl()==null || "".equals(childchildchildmenu.getUrl())){
                            icon="database";
                        }
                        else{
                           icon="book_open";
                        }

                        out.println("tree.add(tree.nodes['n'+'"+childchildmenu.getOperateId()+"'], 'last', '"+childchildchildmenu.getName()+"', 'n' + '"+childchildchildmenu.getOperateId()+"', '"+childchildchildmenu.getUrl()+"', '', '"+icon+"', '', '');");
                    }
                }
            }
        }
        else{   // 显示某个功能项的下级菜单
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
                   icon="file";
                }
                out.println("tree.add(tree.nodes['n'+'"+ModuleID+"'], 'last', '"+childmenu.getName()+"', 'n' + '"+childmenu.getOperateId()+"', \""+childmenu.getUrl()+"\", '', '"+icon+"', '', '');");
                for(int j=0;childmenu.getMenus()!=null && j<childmenu.getMenus().size();j++){
                    MenuObj childchildmenu=(MenuObj)childmenu.getMenus().get(j);
                    if (childchildmenu.getUrl()==null || "".equals(childchildmenu.getUrl())){
                        icon="folder";
                    }
                    else{
                       icon="file";
                    }
                    out.println("tree.add(tree.nodes['n'+'"+childmenu.getOperateId()+"'], 'last', '"+childchildmenu.getName()+"', 'n' + '"+childchildmenu.getOperateId()+"', \""+childchildmenu.getUrl()+"\", '', '"+icon+"', '', '');");
                    for(int k=0;childchildmenu.getMenus()!=null && k<childchildmenu.getMenus().size();k++){
                        MenuObj childchildchildmenu=(MenuObj)childchildmenu.getMenus().get(k);
                        if (childchildchildmenu.getUrl()==null || "".equals(childchildchildmenu.getUrl())){
                            icon="folder";
                        }
                        else{
                           icon="file";
                        }
                        out.println("tree.add(tree.nodes['n'+'"+childchildmenu.getOperateId()+"'], 'last', '"+childchildchildmenu.getName()+"', 'n' + '"+childchildchildmenu.getOperateId()+"', \""+childchildchildmenu.getUrl()+"\", '', '"+icon+"', '', '');");
                    }
                }
            }
        }
    %>
    tree.onclick = function(srcNode) {
        //debugger;
        if (srcNode.key2!=null && srcNode.key2!="" && srcNode.key2!="null"){
            parent.refreshFun(srcNode.key2);
        }
    }
</script>

</body>
</html>