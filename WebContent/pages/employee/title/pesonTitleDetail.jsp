<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
</script>

<x:saveState value="#{deptauditdetailBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{deptauditdetailBB.pageInit}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center" >
            <tr>
            <td  height="10" align="right" valign="top">
            	</c:verbatim>
			          <h:panelGrid align="right" columns="2">
			             <h:panelGroup>
			                <h:outputText value="��¼��:#{deptauditdetailBB.mypage.totalRecord}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="ҳ��:#{deptauditdetailBB.mypage.totalPage}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="ÿҳ��#{deptauditdetailBB.mypage.pageSize}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="��ǰΪ��#{deptauditdetailBB.mypage.currentPage}ҳ"></h:outputText>
			           		<h:commandButton value="��ҳ" action="#{deptauditdetailBB.first}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="��ҳ" action="#{deptauditdetailBB.pre}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="��ҳ" action="#{deptauditdetailBB.next}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="βҳ" action="#{deptauditdetailBB.last}" styleClass="button01"></h:commandButton>
			            </h:panelGroup>
			          
			          </h:panelGrid>
            	<c:verbatim>
            	</td>
            </tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{deptauditdetailBB.scoreList}" rowIndexVar="index"
					id="dateList" var="list" align="center" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="100%">
					<h:column>
		               <c:facet name="header"><h:outputText value="���"/></c:facet>
		               <h:outputText value="#{index+1}"/>
       				 </h:column>
					 <h:column>
                        <f:facet name="header">
                            <h:outputText value="����"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.auditor}"/>
                    </h:column>
					<h:column>
                        <f:facet name="header">
                            <h:outputText value="����"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.deptId}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="����ʱ��"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.auditDate}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="���"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.score}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="���"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.resultDes}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="ԭ��"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.auditReason}"/>
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
