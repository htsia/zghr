<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script language="javascript">
   function DoSelectAll(isSelect){
        var size = document.all('form1:inputField').length;
        for (var i = 0; i < size; i++) {
            document.all('form1:inputField')[i].checked=isSelect;
        }
    }
    function check(){
        if ((document.all("form1:template").value=="-1" || document.all("form1:template").value=="")
             &&   !checkMutilSelect(form1.all('form1:inputField'))){
            alert('��ѡ��������');
            return false;
        }else{
            return true;
        }
    }
</script>

<x:saveState value="#{wage_setInputBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_setInputBB.pageInit}"/>
    <h:inputHidden value="#{wage_setInputBB.isTry}"/>
    <h:panelGrid columns="2" width="95%" styleClass="table03" align="center" columnClasses="td_top,td_top">
        <h:outputText escape="false" value="<strong>��н��λ</strong>:#{wage_setInputBB.unitName}"/>
        <h:outputText escape="false" value="<strong>��������</strong>:#{wage_setInputBB.setName}"/>

        <h:outputText escape="false" value="<strong>ѡ�������</strong>"/>
        <h:selectManyCheckbox value="#{wage_setInputBB.inputField}" layout="pageDirection" id="inputField">
            <c:selectItems value="#{wage_setInputBB.inputList}"/>
        </h:selectManyCheckbox>
    </h:panelGrid>

    <c:verbatim escape="false"><br></c:verbatim>

    <h:panelGrid columns="4" cellspacing="4" align="right">
        <h:selectOneMenu  id="template"  value="#{wage_setInputBB.template}" >
             <f:selectItems value="#{wage_setInputBB.templateList}" ></f:selectItems>
        </h:selectOneMenu>

        <h:commandButton  styleClass="button01" type="button" value="ȫ��ѡ��" onclick="DoSelectAll(true);" />
        <h:commandButton  styleClass="button01" type="button" value="ȫ��ȡ��" onclick="DoSelectAll(false);" />
        <h:commandButton styleClass="button01" value="ȷ��" action="#{wage_setInputBB.queryPersonInput}"
                         onclick="return check();">
            
        </h:commandButton>
        <h:commandButton styleClass="button01" type="button" value="ȡ��" onclick="window.close()"/>
    </h:panelGrid>

    <c:verbatim escape="false"><br></c:verbatim>

    <h:panelGrid columns="1" cellspacing="0" align="center" width="95%" >
        <h:outputText escape="false" value="<strong>��ѡ����Ա�б�</strong>"/>
        <h:dataTable value="#{wage_setInputBB.personlist}" var="list"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                     styleClass="table03" width="100%" >
            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:outputText value="#{list.name}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
                <h:outputText value="#{list.personCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="������λ"/></c:facet>
                <h:outputText value="#{list.orgId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:outputText value="#{list.deptId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="ְ��"/></c:facet>
                <h:outputText value="#{list.postLevel}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="���ʹ�ϵ���ڵ�λ"/></c:facet>
                <h:outputText value="#{list.gongZiGX}"/>
            </h:column>
        </h:dataTable>
    </h:panelGrid>
</h:form>
