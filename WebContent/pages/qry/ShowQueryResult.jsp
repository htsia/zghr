<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
<%
   String qryid=request.getParameter("qryId");
%>
<link href="/css/style.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript">
    function forView(frm,fk,other){
        alert(fk);
    }
</script>
<body>
    <br>
    <table width="98%" height=96% border="0" cellspacing="0" cellpadding="0" align=center>
       <tr>
           <td align="right" height=16>
               <input id="Radio1" type="radio" name="mode" checked onclick="document.main.location.href='/qry/PhotoListFrame.jsf?qryId=<%=qryid%>';"/>照片模式
               <input id="Radio2" type="radio" name="mode" onclick="document.main.location.href='/qry/ActiveListFrame.jsf?qryId=<%=qryid%>';"/>列表模式
               <input type="button" onclick="doExport();" value="导出" class="button01">
           </td>
       </tr>
        <tr><td height=8></td></tr>
       <tr><td valign="top">
           <iframe id="main" name="main" height="100%" frameborder="0" width="100%" src="/qry/PhotoListFrame.jsf?qryId=<%=qryid%>"></iframe>
        </td></tr>
    </table>
</body>
</html>