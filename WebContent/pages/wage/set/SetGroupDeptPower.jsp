<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function doAdd(){
            window.showModalDialog("/wage/set/WageDeptPowerEdit.jsf?personID="+document.all("form1:personID").value+"&setID="+document.all("form1:setId").value, null, "dialogWidth:330px; dialogHeight:160px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
    </script>

<x:saveState value="#{wage_deptBB}"/>
<h:form id="form1">
    <h:inputHidden  value="#{wage_deptBB.pageInit}"/>
    <h:inputHidden id="setId" value="#{wage_deptBB.setID}"/>

    <h:panelGrid columns="1" cellspacing="2" width="98%"  align="center" >
        <h:panelGrid columns="2">
            <h:panelGroup>
                <h:outputText value="н�����ף�#{wage_deptBB.setName}"/>
                <c:verbatim>&nbsp;&nbsp;</c:verbatim>

                <h:outputText value="��ѡ���û�"></h:outputText>
                <h:selectOneMenu id="personID" value="#{wage_deptBB.personID}" onchange="submit()" valueChangeListener="#{wage_deptBB.changePerson}">
                    <c:selectItems value="#{wage_deptBB.grouppersonList}"></c:selectItems>
                </h:selectOneMenu>
            </h:panelGroup>

            <h:panelGrid align="right">
                   <h:commandButton value="����" styleClass="button01" onclick="doAdd();"></h:commandButton>
            </h:panelGrid>
        </h:panelGrid>

        <h:dataTable value="#{wage_deptBB.personPowerList}" var="list" align="center"  id="dateList"
                 headerClass="td_top" columnClasses="td_middle_left,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="100%" >
        <h:column>
            <c:facet name="header"><h:outputText value="��Ȩ�޲�������"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="ɾ��" action="#{wage_deptpowerBB.delete}"   styleClass="button01" onclick="return confirm('ȷ��ɾ����')">
                <x:updateActionListener property="#{wage_deptpowerBB.wbo.itemID}" value="#{list.itemID}"></x:updateActionListener>
            </h:commandButton>
        </h:column>
    </h:dataTable>
        <h:outputText escape="false" value="<font color=red>ע��:������ʱ�����ȫ��������Ȩ��</font>"></h:outputText>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>