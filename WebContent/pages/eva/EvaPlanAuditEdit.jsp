<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function forCheck() {
        if(forsubmit(document.forms(0))){
             return true;
        }
        else{
            return false;
        }
    }
</script>

<x:saveState value="#{eva_planeditBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{eva_planeditBB.initAudit}"></h:inputHidden>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" ��Ч���� -> �������˼ƻ�"/>
        </h:panelGroup>
    </h:panelGrid>
    <br>

    <h:panelGrid align="center" width="98%" columns="1">
        <h:panelGrid columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
            <h:outputText value="�������"/>
            <h:selectOneMenu id="status" value="#{eva_planeditBB.planbo.aduitResult}">
                <c:selectItem itemValue="1" itemLabel="ͬ��"/>
                <c:selectItem itemValue="0" itemLabel="��ͬ��"/>
            </h:selectOneMenu>

            <h:outputText value="ԭ��"/>
            <h:inputTextarea value="#{eva_planeditBB.planbo.aduitContent}" rows="3" cols="80"/>

            <h:outputText value="����"/>
            <h:commandButton styleClass="button01" value="����" action="#{eva_planeditBB.audit}"
                             onclick="return forCheck();"/>
        </h:panelGrid>

        <h:panelGrid columns="4" width="100%" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="����"/>
            <h:inputText id="name" readonly="true" value="#{eva_planeditBB.planbo.planName}" />

            <h:outputText value="��������"/>
            <h:inputText id="planDate" readonly="true" value="#{eva_planeditBB.planbo.planDate}" />

            <h:outputText value="��ʼ����"/>
            <h:panelGroup>
                <h:inputText styleClass="input"  id="beginDate" value="#{eva_planeditBB.planbo.beginDate}"
                             readonly="true" alt="��ʼ����|0|d|50||"/>
            </h:panelGroup>

            <h:outputText value="��������"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="endDate" value="#{eva_planeditBB.planbo.endDate}"
                             readonly="true" alt="��������|0|d|50||"/>
            </h:panelGroup>


            <h:outputText value="��������"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="planType" code="" dict="yes" dict_num="0650"
                             readonly="true" value="#{eva_planeditBB.planbo.planType}"
                             alt="��������|0|s|50||" disabled="true"/>
             </h:panelGroup>

            <h:outputText value="Ȩ�ط�ʽ"></h:outputText>
            <h:selectOneMenu readonly="true" value="#{eva_planeditBB.planbo.pruview}" disabled="true">
                <c:selectItem itemLabel="������" itemValue="0"></c:selectItem>
                <c:selectItem itemLabel="����ι�ϵ" itemValue="1"></c:selectItem>
            </h:selectOneMenu>
            <h:outputText value="����ģ��"></h:outputText>
            <h:selectOneMenu readonly="true" value="#{eva_planeditBB.planbo.evaModel}" disabled="true">
                <c:selectItem itemLabel="������" itemValue="0"></c:selectItem>
                <c:selectItem itemLabel="��λ����" itemValue="1"></c:selectItem>
                <c:selectItem itemLabel="���񿼺�" itemValue="2"></c:selectItem>
                <c:selectItem itemLabel="ѡƱ" itemValue="3"></c:selectItem>
            </h:selectOneMenu>
            <h:outputText value="���˿�������" rendered="#{eva_planeditBB.planbo.evaModel=='0'}"></h:outputText>
            <h:selectOneMenu readonly="true" value="#{eva_planeditBB.planbo.planObjectType}" disabled="true" rendered="#{eva_planeditBB.planbo.evaModel=='0'}">
                <c:selectItem itemLabel="����" itemValue="0"></c:selectItem>
                <c:selectItem itemLabel="����" itemValue="1"></c:selectItem>
                <c:selectItem itemLabel="�Ŷ�" itemValue="2"></c:selectItem>
            </h:selectOneMenu>
        </h:panelGrid>

        <h:panelGrid columns="1" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="���˼ƻ�����"/>
            <h:outputText escape="false" value="#{eva_planeditBB.planbo.description}" />
        </h:panelGrid>

    </h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
