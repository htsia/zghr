<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
</script>

<x:saveState value="#{empResverDupyPersonMgrBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{empResverDupyPersonMgrBB.pageInit}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center" >
            <tr>
            <td  height="10" align="right" valign="top">
            	</c:verbatim>
			          <h:panelGrid align="right" columns="2">
			             <h:panelGroup>
			                <f:verbatim>
			                	<%=LanguageSupport.getResource("COMM-1043","记录数")%>:
			                </f:verbatim>
			                <h:outputText value="#{empResverDupyPersonMgrBB.mypage.totalRecord}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				             <f:verbatim>
			                	<%=LanguageSupport.getResource("COMM-1044","页数")%>:
			                </f:verbatim>
				            <h:outputText value="#{empResverDupyPersonMgrBB.mypage.totalPage}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <f:verbatim>
			                	<%=LanguageSupport.getResource("COMM-1045","每页有")%>
			                </f:verbatim>
				            <h:outputText value="#{empResverDupyPersonMgrBB.mypage.pageSize}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				             <f:verbatim>
			                	<%=LanguageSupport.getResource("COMM-1046","当前为第")%>
			                </f:verbatim>
				            <h:outputText value="#{empResverDupyPersonMgrBB.mypage.currentPage}"></h:outputText>
				            <f:verbatim>
			                	<%=LanguageSupport.getResource("COMM-1047","页")%>
			                </f:verbatim>
			           		<h:commandButton value="首页" action="#{empResverDupyPersonMgrBB.first}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="上页" action="#{empResverDupyPersonMgrBB.pre}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="下页" action="#{empResverDupyPersonMgrBB.next}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="尾页" action="#{empResverDupyPersonMgrBB.last}" styleClass="button01"></h:commandButton>
				            <h:outputText value="  "></h:outputText>
				 			<h:commandButton styleClass="button01" value="选择" onclick="return fPopUpBackPerTreeDlg('');" action="#{empResverDupyPersonMgrBB.selPerson}" />
			            </h:panelGroup>
			          
			          </h:panelGrid>
            	<c:verbatim>
            	</td>
            </tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{empResverDupyPersonMgrBB.personList}" rowIndexVar="index"
					id="dateList" var="list" align="center" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="100%">
					<h:column>
		               <c:facet name="header">
		                     <f:verbatim>
			                	<%=LanguageSupport.getResource("XTGL-1099","序号")%>
			                </f:verbatim>
		                 </c:facet>
		               <h:outputText value="#{index+1}"/>
       				 </h:column>
					 <h:column>
                        <f:facet name="header">
                              <f:verbatim>
			                	<%=LanguageSupport.getResource("MSG-0010","姓名")%>
			                </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.personName}"/>
                    </h:column>
					<h:column>
                        <f:facet name="header">
                            <f:verbatim>
			                	<%=LanguageSupport.getResource("YXGL-1028","机构")%>
			                </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.orgName}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                        <f:verbatim>
			                	<%=LanguageSupport.getResource("YXGL-1029","部门")%>
			                </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.deptName}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                              <f:verbatim>
			                	<%=LanguageSupport.getResource("XTGL-1184","岗位")%>
			                </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.postName}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                             <f:verbatim>
			                	<%=LanguageSupport.getResource("RYGL-2309","确定时间")%>
			                </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.time}"/>
                    </h:column>
                    <h:column>
						<c:facet name="header">
						    <f:verbatim>
			                	<%=LanguageSupport.getResource("YXGL-1026","操作")%>
			                </f:verbatim>
						</c:facet>
						<h:commandButton value="删除" action="#{empResverDupyPersonMgrBB.deleteItem}" styleClass="button01">
							<x:updateActionListener property="#{empResverDupyPersonMgrBB.subId}" value="#{list.subId}"/>
						</h:commandButton>
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
