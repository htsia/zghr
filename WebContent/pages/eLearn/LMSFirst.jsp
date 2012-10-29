<%@ page import="com.hr319wg.eLearn.pojo.bo.elearnStudyBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.scorm.LMSConstants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
<head></head>
<base target="_self">
<link href="/css/style.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/js/Appclient.js"></script>

<body>
<script type="text/javascript" language="javascript">

</script>
<%
    elearnStudyBO eb = (elearnStudyBO) session.getAttribute(LMSConstants.SES_STUDY);
%>
<form id="form1">
    <table width=80% align="center" valign="middle">
        <tr><td align="center" valign="middle" height="300">
            <%
                out.println("<span style='font-size:18px;font-weight:bold;align:center' >欢迎您学习：" + CommonFuns.filterNull(eb.getCourseName())+"</span>");
            %>
        </td></tr>

        <tr><td align="right">
           <input  value="开始学习" class="button01" type="button" onclick="parent.firstStudy();">
        </td></tr>
    </table>
</form>
</body>
</html>

