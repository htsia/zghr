<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.org.ucc.IOrgSumItemUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.org.pojo.bo.EmpOrgSumItemBO" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
<head>
    <title></title>
     <link href="/css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%
    String ColName = "";
    if ("TOMCAT".equals(CommonFuns.getAppType())){
        ColName=CommonFuns.getParaFromURL(request.getQueryString(),"ColName");
    }
    else{
        ColName=request.getParameter("ColName");
    }
    String Col = request.getParameter("Col");
%>
<table width="96%" align="center">
   <tr>
     <td>
         <strong>项目属性:</strong><br>
         <%
             IOrgSumItemUCC orgsumucc = (IOrgSumItemUCC) SysContext.getBean("org_OrgSumItemUCC");
             EmpOrgSumItemBO bo = orgsumucc.queryOrgSumItemByID(Col);
             if (bo!=null) out.println(bo.getDescription());
         %>
     </td>
     </tr>

     <tr> 
     <td>
         <strong>统计信息:</strong><br>
         <iframe height="250" src='/common/activepage/ShowStatic.jsf?ColName=<%=ColName%>&Col=<%=Col%>'></iframe>
     </td>
   </tr>
</table>
</body>
</html>