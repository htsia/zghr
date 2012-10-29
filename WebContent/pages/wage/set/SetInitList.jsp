<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function doAdd(){
            window.showModalDialog("/wage/set/WageSetInitEdit.jsf?setId="+document.all("form1:setId").value+"&unitId="+document.all("form1:unitId").value+"&setName="+document.all("form1:setName").value, null, "dialogWidth:330px; dialogHeight:150px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function forModify(id) {
            window.showModalDialog("/wage/set/WageSetInitEdit.jsf?itemID="+id+"&setId="+document.all("form1:setId").value+"&unitId="+document.all("form1:unitId").value+"&setName="+document.all("form1:setName").value, null, "dialogWidth:330px; dialogHeight:150px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function viewFormula(fid){
            window.showModalDialog("/wage/base/FormulaView.jsf?formulaid=" + fid, null, "dialogWidth:800px; dialogHeight:380px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
    </script>

<x:saveState value="#{wage_setInitBB}"/>
<h:form id="form1">
    <h:inputHidden id="setId" value="#{wage_setInitBB.setId}"/>
    <h:inputHidden id="unitId" value="#{wage_setInitBB.unitId}"/>
    <h:inputHidden id="setName" value="#{wage_setInitBB.setName}"/>

    <h:panelGrid columns="1" cellspacing="2" width="75%"  align="center" >
        <h:panelGrid align="right">
            <h:panelGroup>
                <h:commandButton value="增加" styleClass="button01" onclick="doAdd();" action="#{wage_setInitBB.list}"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>
        <h:outputText value="薪资账套：#{wage_setInitBB.setName}"/>
        <h:dataTable value="#{wage_setInitBB.itemList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{list.seq}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="名称"/></c:facet>
            <h:outputText value="#{list.formularName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="描述"/></c:facet>
            <h:outputText value="#{list.formularDesc}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="查看" onclick="return viewFormula('#{list.formularId}')"   styleClass="button01" >
                </h:commandButton>
            <h:commandButton value="删除" action="#{wage_setInitBB.delete}"   styleClass="button01" onclick="return confirm('确认删除？')">
                <x:updateActionListener property="#{wage_setInitBB.wageinit.itemId}" value="#{list.itemId}"></x:updateActionListener>
            </h:commandButton>
        </h:column>
    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
