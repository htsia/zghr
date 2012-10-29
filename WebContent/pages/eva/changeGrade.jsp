<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

   
    <script type="text/javascript">
  
    </script>

<x:saveState value="#{eva_resultAuditBB}"/>
<h:form id="form1">
        <h:inputHidden id="pageInit" value="#{eva_resultAuditBB.initObject}"/>
        <h:inputHidden value="#{eva_resultAuditBB.isVittual}"></h:inputHidden>
        <c:verbatim>
        <br>
        <table width="98%"  align="center" class="table03">
            <tr>
                <td class="td_form01">打分等级</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputText  id="name" value="#{eva_resultAuditBB.objectbo.gradeName}" readonly="true"></h:inputText>
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01">调整等级</td>
                <td class="td_form02">
 </c:verbatim>
                   <h:selectOneMenu value="#{eva_resultAuditBB.objectbo.gradeItem}" rendered="#{eva_resultAuditBB.isVittual=='0'}">
                   		<c:selectItems value="#{eva_resultAuditBB.gardeList}"/>
                   </h:selectOneMenu>
                   <h:selectOneMenu value="#{eva_resultAuditBB.objectbo.sumGrade}" rendered="#{eva_resultAuditBB.isVittual=='1'}">
                   		<c:selectItems value="#{eva_resultAuditBB.gardeList}"/>
                   </h:selectOneMenu>
<c:verbatim>
                </td>
            </tr>

        </table>
    <table width="98%">
        <tr>
            <td align="right">
</c:verbatim>
                <h:commandButton value="保存"  action="#{eva_resultAuditBB.changeGrade}" styleClass="button01" />
<c:verbatim>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>