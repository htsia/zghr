<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

   
    <script type="text/javascript">
    </script>

<x:saveState value="#{evaauitGroupMgrBB}"/>
<h:form id="form1">
        <h:inputHidden id="pageInit" value="#{evaauitGroupMgrBB.initEdit}"/>
        <h:inputHidden id="planId" value="#{evaauitGroupMgrBB.planId}"></h:inputHidden>
        <c:verbatim>
        <br>
        <table width="98%"  align="center" class="table03">
            
            <tr>
                <td class="td_form01">∆¿…ÛÕ≈√˚≥∆</td>
                <td class="td_form02">
 </c:verbatim>
                    <h:inputText  id="percent" value="#{evaauitGroupMgrBB.groupbo.groupName}"></h:inputText>
<c:verbatim>
                </td>
            </tr>

        </table>
    <table width="98%">
        <tr>
            <td align="right">
</c:verbatim>
                <h:commandButton value="±£¥Ê"  action="#{evaauitGroupMgrBB.saveGroup}" styleClass="button01" />
<c:verbatim>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>