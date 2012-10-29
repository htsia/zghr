<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{wage_flowBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_flowBB.pageInit}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
         <h:graphicImage value="/images/tips.gif" />
         <h:outputText value="н����� -> н�ʷ���"/>
       </h:panelGroup>
    </h:panelGrid>


    <h:panelGrid width="80%" align="center">
        <h:panelGroup>
            <h:outputText escape="false" value="<strong>��н��λ��</strong>"></h:outputText>
            <h:inputText id="unitName" readonly="true" value="#{wage_flowBB.unitName}"/>
            <h:inputHidden id="unitId" value="#{wage_flowBB.unitId}"></h:inputHidden>
            <h:commandButton value="�л�����" styleClass="button01" rendered="#{wage_flowBB.canChangeOrg}" onclick="return fPopUpWageUnitDlg2('form1:unitId','form1:unitName','true');" action="#{wage_flowBB.list}"></h:commandButton>

            <h:panelGrid   align="right" cellpadding="2" cellspacing="2">
                <h:commandLink action="history" value="�鿴��ʷ" rendered="false"/>
            </h:panelGrid>
        </h:panelGroup>

        <h:dataTable value="#{wage_flowBB.list}" var="list"   id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle,td_middle_center"
                     styleClass="table03" width="100%">
            <h:column>
                <c:facet name="header"><h:outputText value="��������"/></c:facet>
                <h:outputText value="#{list.setName}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="ҵ������"/></c:facet>
                <h:outputText value="#{list.date}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:outputText value="#{list.desc}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="״̬"/></c:facet>
                <h:outputText value="#{list.statusName}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:commandButton styleClass="button01" action="#{wage_flowBB.findDate}" value="����" rendered="#{list.isPayoffing}">
                    <x:updateActionListener property="#{wage_flowBB.date.dateId}" value="#{list.dateId}"/>
                    <x:updateActionListener property="#{wage_flowBB.setName}" value="#{list.setName}"/>
                </h:commandButton>
                <h:commandButton value="�鿴����" id="showFlow" type="button" onclick="return showWorkFlowLogByLinkID('#{list.dateId}')" styleClass="button01" rendered="#{wage_dateBB.workFlow=='1'}"></h:commandButton>
            </h:column>
        </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>