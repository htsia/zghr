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
        <h:outputText value=" 绩效管理 -> 审批考核计划"/>
        </h:panelGroup>
    </h:panelGrid>
    <br>

    <h:panelGrid align="center" width="98%" columns="1">
        <h:panelGrid columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
            <h:outputText value="审批意见"/>
            <h:selectOneMenu id="status" value="#{eva_planeditBB.planbo.aduitResult}">
                <c:selectItem itemValue="1" itemLabel="同意"/>
                <c:selectItem itemValue="0" itemLabel="不同意"/>
            </h:selectOneMenu>

            <h:outputText value="原因"/>
            <h:inputTextarea value="#{eva_planeditBB.planbo.aduitContent}" rows="3" cols="80"/>

            <h:outputText value="操作"/>
            <h:commandButton styleClass="button01" value="审批" action="#{eva_planeditBB.audit}"
                             onclick="return forCheck();"/>
        </h:panelGrid>

        <h:panelGrid columns="4" width="100%" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="名称"/>
            <h:inputText id="name" readonly="true" value="#{eva_planeditBB.planbo.planName}" />

            <h:outputText value="考核周期"/>
            <h:inputText id="planDate" readonly="true" value="#{eva_planeditBB.planbo.planDate}" />

            <h:outputText value="开始日期"/>
            <h:panelGroup>
                <h:inputText styleClass="input"  id="beginDate" value="#{eva_planeditBB.planbo.beginDate}"
                             readonly="true" alt="开始日期|0|d|50||"/>
            </h:panelGroup>

            <h:outputText value="结束日期"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="endDate" value="#{eva_planeditBB.planbo.endDate}"
                             readonly="true" alt="结束日期|0|d|50||"/>
            </h:panelGroup>


            <h:outputText value="周期类型"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="planType" code="" dict="yes" dict_num="0650"
                             readonly="true" value="#{eva_planeditBB.planbo.planType}"
                             alt="周期类型|0|s|50||" disabled="true"/>
             </h:panelGroup>

            <h:outputText value="权重方式"></h:outputText>
            <h:selectOneMenu readonly="true" value="#{eva_planeditBB.planbo.pruview}" disabled="true">
                <c:selectItem itemLabel="按个人" itemValue="0"></c:selectItem>
                <c:selectItem itemLabel="按层次关系" itemValue="1"></c:selectItem>
            </h:selectOneMenu>
            <h:outputText value="考核模型"></h:outputText>
            <h:selectOneMenu readonly="true" value="#{eva_planeditBB.planbo.evaModel}" disabled="true">
                <c:selectItem itemLabel="量表打分" itemValue="0"></c:selectItem>
                <c:selectItem itemLabel="岗位考核" itemValue="1"></c:selectItem>
                <c:selectItem itemLabel="任务考核" itemValue="2"></c:selectItem>
                <c:selectItem itemLabel="选票" itemValue="3"></c:selectItem>
            </h:selectOneMenu>
            <h:outputText value="考核客体类型" rendered="#{eva_planeditBB.planbo.evaModel=='0'}"></h:outputText>
            <h:selectOneMenu readonly="true" value="#{eva_planeditBB.planbo.planObjectType}" disabled="true" rendered="#{eva_planeditBB.planbo.evaModel=='0'}">
                <c:selectItem itemLabel="个人" itemValue="0"></c:selectItem>
                <c:selectItem itemLabel="部门" itemValue="1"></c:selectItem>
                <c:selectItem itemLabel="团队" itemValue="2"></c:selectItem>
            </h:selectOneMenu>
        </h:panelGrid>

        <h:panelGrid columns="1" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="考核计划描述"/>
            <h:outputText escape="false" value="#{eva_planeditBB.planbo.description}" />
        </h:panelGrid>

    </h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
