<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
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
    </script>

<x:saveState value="#{wage_baseInputBB}"/>
<h:form id="form1">
<h:inputHidden value="#{wage_baseInputBB.pageInit}"/>
    <c:verbatim><br></c:verbatim>
    <h:panelGrid columns="2" width="95%"  styleClass="table03" align="center" columnClasses="td_top,td_top">
        <h:outputText value="发薪单位:#{wage_baseInputBB.unitName}"/>
        <h:outputText value="账套名称:#{wage_baseInputBB.setName}"/>

        <h:outputText value="选择输入项："/>
        <h:selectManyCheckbox value="#{wage_baseInputBB.selectFields}" layout="pageDirection" id="inputField">
            <c:selectItems value="#{wage_baseInputBB.fieldsList}"/>
        </h:selectManyCheckbox>
    </h:panelGrid>

    <c:verbatim escape="false"><br></c:verbatim>

    <h:panelGrid columns="4" cellspacing="3" align="right">
        <h:commandButton  styleClass="button01" type="button" value="全部选择" onclick="DoSelectAll(true);" />
        <h:commandButton  styleClass="button01" type="button" value="全部取消" onclick="DoSelectAll(false);" />
        <h:commandButton styleClass="button01" value="确认" action="#{wage_baseInputBB.queryPersonInput}"
                         onclick="if(!checkMutilSelect(form1.all('form1:inputField'))){alert('请选择输入项');return false;}else{return true;}"/>
        <h:commandButton styleClass="button01" type="button" value="取消" onclick="window.close()"/>
    </h:panelGrid>

    <c:verbatim escape="false"><br></c:verbatim>

    <h:panelGrid columns="1" cellspacing="0" align="center" width="95%" >
        <h:outputText value="已选择人员列表"/>
        <h:dataTable value="#{wage_baseInputBB.personlist}" var="list" id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                     styleClass="table03" width="100%" >
            <h:column>
                <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                <h:outputText value="#{list.name}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="员工编号"/></c:facet>
                <h:outputText value="#{list.personCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="工作单位"/></c:facet>
                <h:outputText value="#{list.orgId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="薪资部门"/></c:facet>
                <h:outputText value="#{list.deptSort}"/>
            </h:column>

        </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>