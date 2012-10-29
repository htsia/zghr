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
    <script src="<%=request.getContextPath()%>/js/tree.js" language="JavaScript"></script>
    <script src="<%=request.getContextPath()%>/js/Appclient.js" language="JavaScript"></script>
</head>

<body topmargin="0" leftmargin="0">
<div id="tt"></div>
<script language="javascript">
    //定义树的图片对象
    var images = getTreeImage();
    //初始化树
    var tree = new newtree(images, 16, tt);
    <%
        User user =  (User) session.getAttribute(Constants.USER_INFO);
        Hashtable hashMenus = user.getPmsMenus();
        MenuObj menu=(MenuObj)hashMenus.get(ModuleID);
        String icon="database";
        out.println("tree.add(tree.root, 'last', '"+menu.getName()+"', 'n' + '"+ModuleID+"', '', '', '"+icon+"', '', '');");
        for(int i=0;menu.getMenus()!=null && i<menu.getMenus().size();i++){
            MenuObj childmenu=(MenuObj)menu.getMenus().get(i);
            if (childmenu.getUrl()==null || "".equals(childmenu.getUrl())){
                icon="database";
            }
            else{
               icon="book_open";
            }
            out.println("tree.add(tree.nodes['n'+'"+ModuleID+"'], 'last', '"+childmenu.getName()+"', 'n' + '"+childmenu.getOperateId()+"', \""+childmenu.getUrl()+"\", '', '"+icon+"', '', '');");
            for(int j=0;childmenu.getMenus()!=null && j<childmenu.getMenus().size();j++){
                MenuObj childchildmenu=(MenuObj)childmenu.getMenus().get(j);
                if (childchildmenu.getUrl()==null || "".equals(childchildmenu.getUrl())){
                    icon="database";
                }
                else{
                   icon="book_open";
                }
                out.println("tree.add(tree.nodes['n'+'"+childmenu.getOperateId()+"'], 'last', '"+childchildmenu.getName()+"', 'n' + '"+childchildmenu.getOperateId()+"', \""+childchildmenu.getUrl()+"\", '', '"+icon+"', '', '');");
                for(int k=0;childchildmenu.getMenus()!=null && k<childchildmenu.getMenus().size();k++){
                    MenuObj childchildchildmenu=(MenuObj)childchildmenu.getMenus().get(k);
                    if (childchildchildmenu.getUrl()==null || "".equals(childchildchildmenu.getUrl())){
                        icon="database";
                    }
                    else{
                       icon="book_open";
                    }
                    out.println("tree.add(tree.nodes['n'+'"+childchildmenu.getOperateId()+"'], 'last', '"+childchildchildmenu.getName()+"', 'n' + '"+childchildchildmenu.getOperateId()+"', \""+childchildchildmenu.getUrl()+"\", '', '"+icon+"', '', '');");
                }
            }
        }
    %>
    tree.onclick = function(srcNode) {
        //debugger;
        if (srcNode.key2!=null && srcNode.key2!="" && srcNode.key2!="null"){
            var url = srcNode.key2;
	       	if(url.indexOf("?")!=-1 && url.indexOf("/custom/")!=-1){
	       		url+="&inself=0";
	       	}else if(url.indexOf("/custom/")!=-1){
	       		url+="?inself=0";
	       	}
	        parent.refreshFun(url);
        }
    }
</script>

</body>
</html>