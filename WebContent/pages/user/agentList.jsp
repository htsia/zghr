<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{user_userPmsManagerBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{user_userPmsManagerBB.initAgent}"></h:inputHidden>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value=" 系统管理 ->  代理设置"/>
        </h:panelGroup>
        <h:panelGroup>
            <h:inputHidden id="recID" value="#{user_userPmsManagerBB.personID}"></h:inputHidden>
            <h:inputHidden id="recName" value="#{user_userPmsManagerBB.personName}"/>
            <h:commandButton styleClass="button01" action="#{user_userPmsManagerBB.addAgent}" value="增加" onclick="return fPopUpPerDlg('form1:recName', 'form1:recID', '','0');" />
        </h:panelGroup>
    </h:panelGrid>


    <h:panelGrid  width="95%" border="0" cellpadding="0" cellspacing="6" columns="1">
     <h:panelGroup>
         <h:outputText value="被代理人=>"></h:outputText>
         <h:outputText value="编号:#{user_userPmsManagerBB.person.personCode}"></h:outputText>
         <h:outputText value="姓名:#{user_userPmsManagerBB.person.name}"></h:outputText>
     </h:panelGroup>


    <x:dataTable id="bookListTable" value="#{user_userPmsManagerBB.agentList}" var="list" align="center"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="rowdex">

        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{rowdex+1}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="员工编号"/></c:facet>
            <h:outputText value="#{list.personCode}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>


        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:panelGrid columns="5" align="center" cellspacing="2">
                <h:commandButton value="删除" styleClass="button01"
                                 action="#{user_userPmsManagerBB.Delete}" onclick="return confirm('确认删除？')">
                    <x:updateActionListener property="#{user_userPmsManagerBB.itemID}" value="#{list.itemID}"/>
                </h:commandButton>
            </h:panelGrid>
        </h:column>
    </x:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:bookListTable");
</script>