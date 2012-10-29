<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

%>
<x:saveState value="#{ccp_transEditBB.partyRelation.flowId}"/>
<x:saveState value="#{ccp_transListBB}"/>
<h:form id="form1">
<h:inputHidden id="transcateType" value="0"/>
<h:panelGrid width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" styleClass="td_title">
    <h:outputText value=" "/>
    <h:outputText value="  停止党籍"/>
</h:panelGrid>
<f:verbatim><br></f:verbatim>
<h:panelGrid width="95%" border="0" align="center" cellpadding="0" cellspacing="0" columns="2">
    <h:panelGroup>
        <h:outputText value="姓名：" styleClass="td_form_required"/>
        <h:inputText id="personName" value="#{ccp_transListBB.personName}" size="20" styleClass="input"/>
        <h:outputText value=" "/>
        <h:outputText value="转出日期："/>
        <h:inputText id="leaveSDate" value="#{ccp_transListBB.leaveSDate}" size="12" styleClass="input"/>
        <h:commandButton value="" styleClass="button_date" onclick="PopUpCalendarDialog('form1:leaveSDate');return false;"/>
        <h:outputText value=" "/>
        <h:outputText value="至"/>
        <h:outputText value=" "/>
        <h:inputText id="leaveEDate" value="#{ccp_transListBB.leaveEDate}" size="12" styleClass="input"/>
        <h:commandButton value="" styleClass="button_date" onclick="PopUpCalendarDialog('form1:leaveEDate');return false;"/>
        <h:outputText value=" "/>
        <h:commandButton id="qry" value=" 查询 " styleClass="button01" action="#{ccp_transListBB.queryPersonInfo}"/>
    </h:panelGroup>
    <h:panelGrid border="0" align="right" columns="1">
        <h:panelGroup>
            <h:commandButton value="新增停止党籍人员" styleClass="button01" action="edit"/>
            <h:outputText value=" "/>
            <h:commandButton value=" 删除 " styleClass="button01"
                             onclick="javascript:if(confirm('确定要删除记录吗？')){return true} else return false;"
                             action="#{ccp_transListBB.deletePartyRelation}"/>
        </h:panelGroup>
    </h:panelGrid>
</h:panelGrid>
<f:verbatim><br></f:verbatim>
<h:dataTable width="95%" value="#{ccp_transListBB.relationvo}" var="list" id="dateList"
             headerClass="td_top" rowClasses="td_middle_center" styleClass="table03" border="1" align="center">
    <h:column>
        <f:facet name="header"><f:verbatim escape="false">
            <input type="checkbox" name="chkAll"
                   onclick="selectAll(document.form1.chkAll,document.form1.flowId)"/></f:verbatim>
        </f:facet>
        <f:verbatim escape="false"><div align="center"><input type="checkbox" name="flowId"
            value="</f:verbatim>
        <h:outputText value="#{list.flowId}"/><f:verbatim>"></div></f:verbatim>
    </h:column>
    <h:column>
        <f:facet name="header"><h:outputText value="姓名" styleClass="td_form_required"/></f:facet>
        <h:outputText value="#{list.personName}"/>
    </h:column>
    <h:column>
        <f:facet name="header"><h:outputText value="性别"/></f:facet>
        <h:outputText value="#{list.personGender}"/>
    </h:column>
    <h:column>
        <f:facet name="header"><h:outputText value="出生日期"/></f:facet>
        <h:outputText value="#{list.personBirthday}"/>
    </h:column>
    <h:column>
        <f:facet name="header"><h:outputText value="政治面貌"/></f:facet>
        <h:outputText value="#{list.partyFigure}"/>
    </h:column>
    <h:column>
        <f:facet name="header"><h:outputText value="所属党组织"/></f:facet>
        <h:outputText value="#{list.partyUnit}"/>
    </h:column>
    
    <h:column>
        <f:facet name="header"><h:outputText value="转离时间"/></f:facet>
        <h:outputText value="#{list.leaveDate}"/>
    </h:column>
    
    <h:column>
        <f:facet name="header"><h:outputText value="转离类型"/></f:facet>
        <h:outputText value="#{list.leaveType}"/>
    </h:column>
    
    <h:column>
        <f:facet name="header"><h:outputText value="操作"/></f:facet>
        <h:commandLink id="link" action="#{ccp_transEditBB.queryPartyRelation}">
            <h:outputText value="编辑"/>
            <x:updateActionListener property="#{ccp_transEditBB.partyRelation.flowId}"
                                    value="#{list.flowId}"/>
        </h:commandLink>
    </h:column>
</h:dataTable>
<h:panelGrid width="95%" align="center" columns="1" >
    <f:verbatim escape="false">
        <hrdc:pageTag submitMethod="form.all(\"form1:qry\").click()" buttonStyle="button01"/>
    </f:verbatim>
</h:panelGrid>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>

</h:form>
