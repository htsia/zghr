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
			                <h:outputText value="记录数:#{deptauditdetailBB.mypage.totalRecord}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="页数:#{deptauditdetailBB.mypage.totalPage}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="每页有#{deptauditdetailBB.mypage.pageSize}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="当前为第#{deptauditdetailBB.mypage.currentPage}页"></h:outputText>
			           		<h:commandButton value="首页" action="#{deptauditdetailBB.first}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="上页" action="#{deptauditdetailBB.pre}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="下页" action="#{deptauditdetailBB.next}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="尾页" action="#{deptauditdetailBB.last}" styleClass="button01"></h:commandButton>
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
		               <c:facet name="header"><h:outputText value="序号"/></c:facet>
		               <h:outputText value="#{index+1}"/>
       				 </h:column>
					 <h:column>
                        <f:facet name="header">
                            <h:outputText value="姓名"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.auditor}"/>
                    </h:column>
					<h:column>
                        <f:facet name="header">
                            <h:outputText value="部门"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.deptId}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="评审时间"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.auditDate}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="打分"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.score}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="结果"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.resultDes}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="原因"/>
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
