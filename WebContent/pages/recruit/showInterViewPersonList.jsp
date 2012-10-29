<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
         function showPerson(detailId){
        	 window.showModalDialog("/recruit/interviewResumeDetail.jsf?detailId="+detailId, null, "dialogWidth:600px; dialogHeight:600px; status:0;resizable:yes");
        	 return true;
         }
         
    </script>

<x:saveState value="#{onlineviewlistBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{onlineviewlistBB.personListInit}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim>
					<h:panelGrid align="left" columns="1">
						<h:outputLabel value="面试人员列表"></h:outputLabel>
					</h:panelGrid>
				 <c:verbatim></td>
			</tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{onlineviewlistBB.interviewPersonList}" rowIndexVar="index"
					id="dateList" var="list" align="center" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="100%">
					<h:column>
		               <c:facet name="header"><h:outputText value="序号"/></c:facet>
		               <h:outputText value="#{index+1}"/>
       				 </h:column>
					 <h:column>
                        <f:facet name="header">
                            <h:outputText value="姓名"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.personName}"/>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="应聘职位"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.postName}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="应聘时间"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyDate}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="面试结果"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.ivResultDes}"/>
                    </h:column>
                    <h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="面试" styleClass="button01" onclick="showPerson('#{list.detailId}')" rendered="#{list.status=='2'}"></h:commandButton>
					</h:column>
				</x:dataTable>
				<c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>

<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
