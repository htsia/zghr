<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <base target="_self">
    <script type="text/javascript">
        function doAdd(){
            if (document.all("form1:personID").value==""){
                alert("请选择用户！");
                return false;
            }
            window.showModalDialog("/insurace/WageDeptPowerEdit.jsf?personID="+document.all("form1:personID").value+"&setID="+document.all("form1:setId").value, null, "dialogWidth:330px; dialogHeight:260px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
    </script>

<x:saveState value="#{ins_deptpowerBB}"/>
<h:form id="form1">
        <h:panelGrid columns="2">
            <h:panelGroup>
                <h:outputText value="薪资账套："></h:outputText>
                <h:selectOneMenu id = "setId" value="#{ins_deptpowerBB.setID}" onchange="submit()"
                              valueChangeListener="#{ins_deptpowerBB.changeSetId}">
                     <c:selectItems value="#{ins_deptpowerBB.setList}"/>
                </h:selectOneMenu>

                <h:outputText value="请选择用户"></h:outputText>
                <h:selectOneMenu id="personID" value="#{ins_deptpowerBB.personID}" onchange="submit()" valueChangeListener="#{ins_deptpowerBB.changePerson}">
                    <c:selectItems value="#{ins_deptpowerBB.personList}"></c:selectItems>
                </h:selectOneMenu>
            </h:panelGroup>

            <h:panelGrid align="right">
                   <h:commandButton value="增加" styleClass="button01" onclick="doAdd()"></h:commandButton>
            </h:panelGrid>
        </h:panelGrid>

        <h:dataTable value="#{ins_deptpowerBB.personPowerList}" var="list" align="center"
                 headerClass="td_top" columnClasses="td_middle_left,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="80%" >
        <h:column>
            <c:facet name="header"><h:outputText value="有权限部门名称"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="删除" action="#{ins_deptpowerBB.delete}"   styleClass="button01" onclick="return confirm('确认删除？')">
                <x:updateActionListener property="#{ins_deptpowerBB.wbo.itemID}" value="#{list.itemID}"></x:updateActionListener>
            </h:commandButton>
        </h:column>
    </h:dataTable>

     <h:outputText escape="false" value="<font color=red> &nbsp;&nbsp;&nbsp;&nbsp;注意:不设置时代表对全部部门有权限</font>"></h:outputText>


</h:form>
