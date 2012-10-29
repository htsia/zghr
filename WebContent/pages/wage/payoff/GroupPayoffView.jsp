<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
</script>

<x:saveState value="#{wage_flowBB}"/>
<h:form id="form1">
    <h:inputHidden id="unitId" value="#{wage_flowBB.initViewGroup}"/>
    <c:verbatim>
    <table height=98% width=98% align="center">
    <tr><td height=8>
    </c:verbatim>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
         <h:graphicImage value="/images/tips.gif" />
         <h:outputText value="薪酬管理 -> 报盘日志"/>
       </h:panelGroup>
    </h:panelGrid>
<c:verbatim>
     </td></tr>

    <tr><td>
    <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
        <h:dataTable value="#{wage_flowBB.groupPayList}" var="list" align="center"  id="dateList"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >
            <h:column>
                <c:facet name="header"><h:outputText value="日期"/></c:facet>
                <h:outputText value="#{list.operateDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作员"/></c:facet>
                <h:outputText value="#{list.operateName}"/>
            </h:column>

        </h:dataTable>
<f:verbatim>
        </div>
    </td></tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
