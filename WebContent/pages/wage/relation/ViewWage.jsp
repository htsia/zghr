<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<x:saveState value="#{wage_salaryRelationBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_salaryRelationBB.viewWage}"/>

    <h:panelGrid width="98%"  align="center" columnClasses="td_title" bgcolor="#FFFFFF" cellpadding="0"
                    cellspacing="0">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="薪酬基本信息"/>
        </h:panelGroup>
    </h:panelGrid>
    <br>
    <x:dataTable rowIndexVar="index" id="userdata" width="100%" align="center"
             value="#{wage_salaryRelationBB.baseInfoList}" var="paylist"  headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03">
           <h:column>
                <f:facet name="header">
                    <h:outputText value="序号"></h:outputText>
                </f:facet>
                <h:outputText value="#{index+1}"  style="#{paylist[3]}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="项目"></h:outputText>
                </f:facet>
                <h:outputText value="#{paylist[0]}"  style="#{paylist[3]}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="金额"></h:outputText>
                </f:facet>
                <h:outputText value="#{paylist[1]}"  style="#{paylist[3]}"/>
            </h:column>
        </x:dataTable>
</h:form>

