<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.wage.ucc.impl.WagePersonQueryUCC" %>
<%@ page import="com.hr319wg.sys.api.WageAPI" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head><title>
</title></head>
<script type="text/javascript" src="../../js/tree.js"></script>
<script type="text/javascript" src="../../js/Appclient.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
<body topmarge="0" leftmarge="0">
<input type="button" value="取消选择" class="button01" onclick="window.returnValue = '';window.close();">
<div id="dt"></div>

<script type="text/javascript">
    var img = getTreeImage();
    //初始化树
    var tree = new newtree(img, 16, dt);
    root = tree.root;
    <%
       String personID=(String)request.getParameter("personID");
       WageAPI wageapi=(WageAPI)SysContext.getBean("wage_api");
       try{
           String setID=wageapi.querySetByPersonID(personID);
           WagePersonQueryUCC rc=(WagePersonQueryUCC)SysContext.getBean("wage_PersonQueryUccImpl");
           String dept[]=rc.getDeptList(setID);
            for(int i=0;i<dept.length;i++){
                String str = "    tree.add(root,'last','" + dept[i] + "', 'T" + dept[i] + "','','CODE','fold','','');";
                out.println(str);
            }
        }
        catch(Exception e){

        }
    %>
    tree.expandAll(false);
    tree.onclick = function(srcNode) {
            window.returnValue = srcNode.label.innerText;
            window.close();
        }
</script>
</body>
</html>