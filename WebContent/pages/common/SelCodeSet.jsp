<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO"%>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeSetBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCache"%>
<%@ page import="java.util.HashMap"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%

    String dict_num = request.getParameter("dict_num");
    if (dict_num == null) return;
    String curCode = request.getParameter("curCode");
    String value = request.getParameter("value");
    CodeItemBO code = SysCacheTool.findCodeItem(dict_num,curCode);
    String treeId = "";
    if (code != null) {
        treeId = CommonFuns.filterNull(code.getTreeId());
    }
    if(value == null || "".equals(value)){
        treeId = "";
    }


%>
<html>
<head><title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script src="../../js/tree.js" language="JavaScript"></script>
    <script src="../../js/Appclient.js" language="JavaScript"></script>
</head>

<body >
<div id="tt"></div>
<script language="javascript">
    var flag = false;
    //定义树的图片对象
    var images = getTreeImage();
    //初始化树
   var tree = new newtree(images, 16, tt);
   root = tree.root;
    <%
    HashMap map = SysCache.codeSetMap;


    %>


</script>

</body>
</html>