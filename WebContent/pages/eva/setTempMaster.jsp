<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<f:verbatim>
    <script type="text/javascript">
    function doSet(masterId,objectId) {
    	window.showModalDialog("/eva/setPurview.jsf?objectID="+objectId+"&masterID="+masterId, null, "dialogWidth:350px; dialogHeight:200px;center:center;resizable:yes;status:yes;scroll:yes;");
    }
    </script>
</f:verbatim>
<x:saveState value="#{eva_objectBB}" />
<h:form id="form1">
	<h:inputHidden value="#{eva_objectBB.initPage}"></h:inputHidden>
	<c:verbatim>
		<table height="98%" width="98%" align="center">
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim> 
				<x:dataTable value="#{eva_objectBB.tempMasterPersonList}" width="100%"
					var="list" rowIndexVar="index" align="center" id="dateList"
					headerClass="td_top"
					columnClasses="td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03">
					<h:column>
						<c:facet name="header">
							<h:outputText value="序号" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="姓名" />
						</c:facet>
						<h:outputText value="#{list.masterPName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="设为考核主体" styleClass="button01"  onclick="doSet('#{list.masterID}','#{eva_objectBB.objectID}');">
						</h:commandButton>
					</h:column>
				</x:dataTable> <c:verbatim></div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>