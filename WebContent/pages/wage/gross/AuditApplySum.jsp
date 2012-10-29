<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{wage_grossauditBB}"/>
<h:form id="form1">
<c:verbatim>
    <table  width=100%>
     <tr><td height=8>
</c:verbatim>
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF">
           <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value=" 集团薪酬管控 -> 审批追加"/>
            </h:panelGroup>
        </h:panelGrid>
    <c:verbatim>
     </td></tr>


      <tr><td height=8 align="right">
</c:verbatim>
    <h:dataTable value="#{wage_grossauditBB.applyList}" var="list" align="center"  id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >
            <h:column>
                <c:facet name="header"><h:outputText value="申请日期"/></c:facet>
                <h:outputText value="#{list.applyDate}"/>
            </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="申请单位"/></c:facet>
            <h:outputText value="#{list.orgName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="追加项目"/></c:facet>
            <h:outputText value="#{list.fieldName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="追加额度"/></c:facet>
            <h:outputText value="#{list.applySum}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="申请原因"/></c:facet>
            <h:outputText value="#{list.applyReason}"/>
        </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="同意" styleClass="button01" action="#{wage_grossauditBB.doOK}">
                    <x:updateActionListener property="#{wage_grossauditBB.itemID}" value="#{list.itemID}"></x:updateActionListener>
                </h:commandButton>
                <h:commandButton value="不同意" styleClass="button01" action="#{wage_grossauditBB.doNO}">
                    <x:updateActionListener property="#{wage_grossauditBB.itemID}" value="#{list.itemID}"></x:updateActionListener>
                </h:commandButton>
            </h:column>
        </h:dataTable>
<c:verbatim>
      </td></tr>
     </table>
    </c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>

