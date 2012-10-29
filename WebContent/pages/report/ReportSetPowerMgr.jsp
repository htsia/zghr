<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<script type="text/javascript">
     function checkSave(){
         if (document.all('form1:userID').value=='' || document.all('form1:userID').value=='-1'){
             alert("请选择用户!")
             return false;
         }
         if (document.all('form1:rptSet').value=='' || document.all('form1:rptSet').value=='-1'){
             alert("请选择表套!")
             return false;
         }

         return true;
     }
</script>
<x:saveState value="#{Rpt_SetPowerMgrBB}" />
<h:form id="form1">
	<h:inputHidden  value="#{Rpt_SetPowerMgrBB.pageInit}"></h:inputHidden>
	<h:panelGrid width="98%" columns="1" align="center">
		<h:panelGrid columns="9" align="left">
			<h:outputText value="选择用户"></h:outputText>
			<h:panelGroup>
				<h:selectOneMenu onchange="submit();"   id="userID"
					value="#{Rpt_SetPowerMgrBB.newDetailValue}"
					valueChangeListener="#{Rpt_SetPowerMgrBB.changeDetailValue}">
					<c:selectItems value="#{Rpt_SetPowerMgrBB.detailList}"></c:selectItems>
				</h:selectOneMenu>
			</h:panelGroup>

            <h:panelGroup>
                <h:selectOneMenu   id="rptSet" value="#{Rpt_SetPowerMgrBB.rptSet}">
                    <c:selectItems value="#{Rpt_SetPowerMgrBB.rptSetList}"></c:selectItems>
                </h:selectOneMenu>
                <h:commandButton styleClass="button01"  value="添加" onclick="return checkSave();" action="#{Rpt_SetPowerMgrBB.save}" />
            </h:panelGroup>

			<h:commandButton styleClass="button01" value="删除"
				action="#{Rpt_SetPowerMgrBB.deleteBatch}"
				onclick="return checkBatchDelete('selected_ids');" />
		</h:panelGrid>
	</h:panelGrid>
    <f:verbatim>
        <br>
    </f:verbatim>

    <x:dataTable value="#{Rpt_SetPowerMgrBB.itemList}" id="dateList"
        headerClass="td_top" rowIndexVar="index" var="list"  align="center"
        styleClass="table03" border="1" width="400"
        columnClasses="td_middle_center,td_middle_center,td_middle_left">
        <h:column >
            <c:facet name="header" >
                <c:verbatim escape="false">
                    <input type="checkbox" name="chkAll"
                        onclick="selectAll(document.form1.chkAll,document.form1.selected_ids);"/>
                </c:verbatim>
            </c:facet>
            <c:verbatim escape="false">
                <input type="checkbox" name="selected_ids"
                    value="</c:verbatim>
              <h:outputText value="#{list.itemId}"/>
              <c:verbatim>">
            </c:verbatim>
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText value="表套" styleClass="td03" />
            </f:facet>
            <h:outputText value="#{list.setName}" />
        </h:column>
    </x:dataTable>

</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>





