<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script src="<%=request.getContextPath()%>/js/jquery.js" type="text/javascript"></script>
<script type="text/javascript">
	function forsave(){
		var date = $("input[code]");
		var am1=date[0];
		var am2=date[1];
		var am3=date[2];
		var am4=date[3];
		var pm1=date[4];
		var pm2=date[5];
		var pm3=date[6];
		var pm4=date[7];
		if(am1==null && am2==null && am3==null && am4==null && pm1==null && pm2==null && pm3==null && pm4==null){
			alert("请填写打卡时间");
			return false;
		}else if(pm4<pm3 || pm3<pm2 || pm2<pm1 || pm1 < am4 || am4<am3 || am3 < am2 || am2<am1 ){
			alert("请填写上午上班时间");
			return false;
		}
	}
</script>
<x:saveState value="#{att_class_detailBB}"/>
<h:inputHidden value="#{att_class_detailBB.pageInit}"/>
<h:form id="form1">
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="设置时段 -> #{att_class_detailBB.className}" />
		</h:panelGroup>
	</h:panelGrid>
	<c:verbatim>
		<table height=80% width=98% align="center">
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim>
					<x:dataTable value="#{att_class_detailBB.detailList}" var="list" 
					rowIndexVar="index" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="90%" border="0">

					<h:column>
						<c:facet name="header">
							<h:outputText value="序号" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="时刻名称" />
						</c:facet>
						<h:outputText value="#{list.itemName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="时间"  />
						</c:facet>
						<h:inputText code="#{list.itemID}" value="#{list.itemTime}" readonly="true" size="10" styleClass="input" onclick="WdatePicker({startDate:'%H:%m',dateFmt:'HH:mm'})"/>
					</h:column>
				</x:dataTable> 
				<h:panelGrid>
					<h:commandButton onclick="return forsave()" value="保存" action="#{att_class_detailBB.saveClassDetail}"/>
				</h:panelGrid>
				<c:verbatim>
				<input type="button" onclick="forsave();"/>
				</div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
</body>
