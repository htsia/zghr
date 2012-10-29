<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.oa319wg.user.pojo.vo.OAUser" %>
<%@ page import="com.hr319wg.user.util.MenuObj" %>
<%@ page import="com.oa319wg.user.pojo.bo.OAOperateBO" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String ModuleID = request.getParameter("ModuleID");
    if (ModuleID == null || "".equals(ModuleID)) {
        ModuleID = OAOperateBO.OAMODULE_XXZX;
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
        OAUser user = (OAUser) session.getAttribute(Constants.OA_USER_INFO);
        Hashtable hashMenus = user.getOperMenus();
        MenuObj menu=(MenuObj)hashMenus.get(ModuleID);
        out.println("tree.add(tree.root, 'last', '"+menu.getName()+"', 'n' + '"+ModuleID+"', '"+ModuleID+"', '', 'folder', '', '');");
        for(int i=0;menu.getMenus()!=null && i<menu.getMenus().size();i++){
            MenuObj childmenu=(MenuObj)menu.getMenus().get(i);
            out.println("tree.add(tree.nodes['n'+'"+ModuleID+"'], 'last', '"+childmenu.getName()+"', 'n' + '"+childmenu.getOperateId()+"', '"+childmenu.getUrl()+"', '', 'folder', '', '');");
            for(int j=0;childmenu.getMenus()!=null && j<childmenu.getMenus().size();j++){
                MenuObj childchildmenu=(MenuObj)childmenu.getMenus().get(j);
                out.println("tree.add(tree.nodes['n'+'"+childmenu.getOperateId()+"'], 'last', '"+childchildmenu.getName()+"', 'n' + '"+childchildmenu.getOperateId()+"', '"+childchildmenu.getUrl()+"', '', 'folder', '', '');");
                for(int k=0;childchildmenu.getMenus()!=null && k<childchildmenu.getMenus().size();k++){
                    MenuObj childchildchildmenu=(MenuObj)childchildmenu.getMenus().get(k);
                    out.println("tree.add(tree.nodes['n'+'"+childchildmenu.getOperateId()+"'], 'last', '"+childchildchildmenu.getName()+"', 'n' + '"+childchildchildmenu.getOperateId()+"', '"+childchildchildmenu.getUrl()+"', '', 'folder', '', '');");
                }
            }
        }
    %>
    tree.onclick = function(srcNode) {
        parent.refreshFun(srcNode.key2);
    }
</script>

</body>
</html>