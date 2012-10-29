<%@ page contentType="text/html;charset=GBK" language="java" %>
<link href="/css/style.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/js/Appclient.js"></script>
    <script type="text/javascript">
    function forView(form, id, type) {
       
    }
</script>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<form>
     <table height=98%  width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td height=8 class="td_title"><img src="/images/tips.gif" alt="">省直申报标准对照</td>
        </tr>
        <tr>
            <td>
            	<iframe name="list" frameborder="0" height="400" scrolling="no" width="100%"
                                            src="/org/info/OrgInfoDetailList.jsf?setId=B200&flag=2&fk=1007588&type=0"></iframe>
            </td>
        </tr>
    </table>
</form>
