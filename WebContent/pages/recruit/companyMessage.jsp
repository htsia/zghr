<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{getToEmployBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{getToEmployBB.pageInit}"></h:inputHidden>
    <c:verbatim>
   <table height=98% width=100% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif">外部招聘->单位简介</td>
        </tr>
       <tr><td align="right" height=8></td></tr>
	   <tr><td align="center"><img alt="单位简介" src="/images/outterrecuit/zgxr.jpg"></td></tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
