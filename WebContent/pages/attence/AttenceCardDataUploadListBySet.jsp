<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{att_DataUploadBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden id="perSelSet" value="#{att_DataUploadBB.initEdit}"/>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <br />
				<h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left">
						<h:panelGroup>
                <h:outputText value=" "/>
                <h:commandButton styleClass="button01" value="保存到数据库" action="#{att_DataUploadBB.saveFileBySet}"/>

                <h:outputText value=" "/>
                <h:commandButton styleClass="button01" value="返回" action="upload"/>
						</h:panelGroup>
					</h:panelGrid>
					<h:panelGrid align="right" columns="2">
					<h:panelGroup>
        <h:outputLink  target="_blank" rendered="#{att_DataUploadBB.showError}" style="color:red" value="#{att_DataUploadBB.errorFileUrl}">
            <h:outputText value="上传文件数据有错误，点击下载错误数据文件"/>
        </h:outputLink>
						</h:panelGroup>
					</h:panelGrid>
					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim>
					 <x:dataTable
					value="#{att_DataUploadBB.attencelogboss}" var="list"
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
							<h:outputText value="员工编号" />
						</c:facet>
						<h:outputText value="#{list.personSeq}" />
					</h:column>
					
										<h:column>
						<c:facet name="header">
							<h:outputText value="员工姓名" />
						</c:facet>
						<h:outputText value="#{list.personName}" />
					</h:column>
					
															<h:column>
						<c:facet name="header">
							<h:outputText value="打卡日期" />
						</c:facet>
						<h:outputText value="#{list.cardDate}" />
					</h:column>
					
																				<h:column>
						<c:facet name="header">
							<h:outputText value="打卡时间" />
						</c:facet>
						<h:outputText value="#{list.cardTime}" />
					</h:column>
					
																									<h:column>
						<c:facet name="header">
							<h:outputText value="考勤机名称" />
						</c:facet>
						<h:outputText value="#{list.machineName}" />
					</h:column>
					
																														<h:column>
						<c:facet name="header">
							<h:outputText value="进出标示" />
						</c:facet>
						<h:outputText value="#{list.flag}" />
					</h:column>
					
				</x:dataTable>
					<c:verbatim></div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
