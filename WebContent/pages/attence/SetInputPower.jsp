<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function doAdd(){
            window.showModalDialog("/attence/AttInputPowerEdit.jsf?personID="+document.all("form1:personID").value+"&setID="+document.all("form1:setId").value, null, "dialogWidth:330px; dialogHeight:260px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
    </script>

<x:saveState value="#{att_inputBB}"/>
<h:form id="form1">
    <h:inputHidden  value="#{att_inputBB.pageInit}"/>
    <h:inputHidden id="setId" value="#{att_inputBB.setID}"/>

    <h:panelGrid columns="1" cellspacing="2" width="98%"  align="center" >
        <h:panelGrid columns="2">
            <h:panelGroup>
                <h:outputText value="薪资账套：#{att_inputBB.setName}"/>
                <c:verbatim>&nbsp;&nbsp;</c:verbatim>

                <h:outputText value="请选择用户"></h:outputText>
                <h:selectOneMenu id="personID" value="#{att_inputBB.personID}" onchange="submit()" valueChangeListener="#{att_inputBB.changePerson}">
                    <c:selectItems value="#{att_inputBB.personList}"></c:selectItems>
                </h:selectOneMenu>
            </h:panelGroup>

            <h:panelGrid align="right">
                   <h:commandButton value="增加" styleClass="button01" onclick="doAdd()"></h:commandButton>
            </h:panelGrid>
        </h:panelGrid>

        <h:dataTable value="#{att_inputBB.powerList}" var="list" align="center"  id="dateList"
                 headerClass="td_top" columnClasses="td_middle_left,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="100%" >
        <h:column>
            <c:facet name="header"><h:outputText value="有权限项目名称"/></c:facet>
            <h:outputText value="#{list.itemName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="删除" action="#{att_inputBB.delete}"   styleClass="button01" onclick="return confirm('确认删除？')">
                <x:updateActionListener property="#{att_inputBB.wbo.powerID}" value="#{list.powerID}"></x:updateActionListener>
            </h:commandButton>
        </h:column>
    </h:dataTable>
        <h:outputText escape="false" value="<font color=red>注意:不设置时代表对全部项目有权限</font>"></h:outputText>
    </h:panelGrid>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
