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
<head><title>
</title></head>

<body bgcolor="#FFFFFF"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<div id="dt"></div>
<script type="text/javascript" src="/js/tree.js"></script>
<script src="/js/Appclient.js" type="text/javascript"></script>
<script language="javascript">
<%
    if ("1".equals(request.getParameter("inLead"))){
       out.println("    inLead=1;");
    }
%>
    var setId = "";
    var flag = true;
    //定义树的图片对象
    var images = new getTreeImage();
    //初始化树
    var tree = new newtree(images, 16, dt);
    root = tree.root;

<%
    //画指标集
    for(int i=0;i<list.size();i++){
        InfoSetBO set = (InfoSetBO)list.get(i);
        String str =set.getSetId() + " = tree.add(root,'last','" + set.getSetName() + "','" + set.getSetId() + "','"+set.getSet_rsType()+"','','file','','');";
        out.println(str);
    }

%>
   tree.expandAll(false);
    //展开根节点
    try {
        rootNodes =root.children;
        for (i = 0; i < rootNodes.length; i++) {
                rootNodes[i].expand(true);
        }
    } catch(e) {

    }

   tree.onclick = function(node) {
       if(node.key2 != null && node.key2 != ""){
            parent.refreshList(node.getKey(),node.key2);
       }else{
           return ;
       }
   }
   //document.oncontextmenu=function(e){return false;}
</script>
</body>
</html>