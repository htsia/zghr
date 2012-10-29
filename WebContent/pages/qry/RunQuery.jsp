<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
   String qryID=request.getParameter("qryId");
%>

<h:form id="form1">
    <c:verbatim>
    <table>
       <tr><td>
    </c:verbatim>
        <h:commandButton id="doQuery" action="#{qry_querySettingBB.doQuery}" style="display:none" value="²éÑ¯"/>
    <c:verbatim>
        <input type="hidden" name="flag" value="querylist">
        <input type="hidden" name="qryId" value="<%=qryID%>">
    </td></tr>
    </table>
    </c:verbatim>
</h:form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
        </tr>
    </table>
</marquee>
<script type="text/javascript">
    function doQuery(){
       document.all('form1:doQuery').click();
    }
    function showProcessBar() {
       x =  250;
       y = 120;
       document.all('processbar').style.top = y;
       document.all('processbar').style.left = x;
       document.all('processbar').style.display = "";
    }
    showProcessBar();

    setTimeout("doQuery()",500);
</script>
