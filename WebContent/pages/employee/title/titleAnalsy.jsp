<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
function showDetail(id){
	window.showModalDialog("/employee/title/ShowPersonTitle.jsf?personType="+document.all('form1:personType').value+"&orgId="+document.all('form1:orgId').value+"&level="+id, "", "dialogWidth:650px; dialogHeight:450px; status:0;resizable:yes");
	return false;
}
function forSel() {
    if(PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'')){
           document.all("form1:refresh").click();
    }
 }
</script>

<x:saveState value="#{empTitleAnalsyBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{empTitleAnalsyBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="orgId" value="#{empTitleAnalsyBB.orgId}"></h:inputHidden>
	<h:inputHidden id="personType" value="#{empTitleAnalsyBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{empTitleAnalsyBB.personTypeValue}"/>
    <h:commandButton id="refresh" style="display:none" action="#{empTitleAnalsyBB.doQuery}"></h:commandButton>
	<c:verbatim>
		<table height=98% width=98% align="center" border="0" cellspacing="0" cellpadding="0">
            <tr><td class="td_page"><input name="simple1" type="button" id=15 next=20 class="button01" value="选择人员类别"
                           onclick="forSel();"></c:verbatim><h:outputText value="#{empTitleAnalsyBB.personTypeDesc}"></h:outputText><c:verbatim></td><td align="right" class="td_page"><b>合计：</c:verbatim>
		<h:outputText value="#{empTitleAnalsyBB.allCount}"></h:outputText>
	<c:verbatim></b>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
			<tr>
				<td height="150" colspan="2">
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{empTitleAnalsyBB.personTitleList}" 
					id="dateList" var="list" align="center" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="100%">
					 <h:column>
                        <f:facet name="header">
                            <h:outputText value="级别"/>
                        </f:facet>
                        <h:outputText value="#{list.levelName}"/>
                    </h:column>
					<h:column>
                        <f:facet name="header">
                            <h:outputText value="人数"/>
                        </f:facet>
                        <h:commandLink value="#{list.count}" onclick="showDetail('#{list.titleLevel}')"></h:commandLink>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="比例"/>
                        </f:facet>
                        <h:outputText value="#{list.percent}"/>
                    </h:column>
				</x:dataTable>
				<c:verbatim>
	</div>
	</td></tr>
	<tr><td colspan="2" align="center" valign="top" height="350">
        <jsp:include page="/pages/qry/StaticResultPie.jsp?height=350&width=500"></jsp:include>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>

<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
