<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.org.ucc.IOrgUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String ListType=CommonFuns.filterNull(request.getParameter("ListType"));
%>
<html>
<head><title></title>
    <script src="<%=request.getContextPath()%>/js/tree.js" language="JavaScript"></script>
    
</head>

<body topmargin="0" leftmargin="0">
<div id="tt"></div>
<script language="javascript">
    //定义树的图片对象
    var images = getTreeImage();
    //初始化树
    var tree = new newtree(images, 16, tt);

    <%
       IOrgUCC orgucc = (IOrgUCC) SysContext.getBean("org_orgUCC");
       List list=orgucc.getOrgListByBodyType(ListType,null);
       for(int i=0;i<list.size();i++){
          OrgBO orgbo=(OrgBO)list.get(i);
          out.println("tree.add(tree.root, 'last', '"+orgbo.getName()+"', 'n"+orgbo.getOrgId()+"', "+orgbo.getOrgId()+", '', 'group', '', '');");
       }
    %>
    //定义树的节点的扩展方法
    tree.onexpand = function(srcNode) {
        if (srcNode.first.label.innerText == "loading..."){
            showTree(srcNode.key2, "1", "");
        }
        return true;
    }

    tree.onclick = function(srcNode) {
        parent.refreshList(srcNode.key2);
    }
</script>

</body>
</html>