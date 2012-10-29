<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
	function doAddPerson() {
		window.showModalDialog("/employee/info/addReEnter.jsf", "",
				"dialogWidth:455px; dialogHeight:300px; status:0;resizable:no");
		return true;
	}
    function queryAll(){
        document.all('form1:month').value='';
        return true;
    }
</script>

<x:saveState value="#{emp_engageBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{emp_engageBB.initReEnter}"></h:inputHidden>
	<h:panelGrid width="100%">
		<h:panelGrid width="98%" columns="2" styleClass="td_title"
			align="center">
			<h:panelGroup>
				<h:graphicImage value="/images/tips.gif" />
				 <f:verbatim>
			         离职人员重新上岗
		        </f:verbatim>
			</h:panelGroup>

			<h:panelGrid align="right">
				<h:panelGroup>
					<h:outputText escape="false" value="#{emp_engageBB.auditCheck}"
						rendered="#{emp_engageBB.auditCheck!=''}"></h:outputText>
			   <f:verbatim>
			         <%=LanguageSupport.getResource("RYGL-2256","月份")%>:
		        </f:verbatim>
					<h:inputText readonly="true" id="month"
						value="#{emp_engageBB.month}"></h:inputText>
					<h:commandButton type="button" styleClass="button_date"
						onclick="PopUpCalendarDlg_OnlyMonth('form1:month')" />
					<h:commandButton styleClass="button01" value="查询"></h:commandButton>
                    <h:commandButton styleClass="button01" value="全部" onclick="return queryAll();"></h:commandButton>
                    <h:commandButton styleClass="button01" value="新增"	onclick="doAddPerson()"></h:commandButton>
				</h:panelGroup>
			</h:panelGrid>
		</h:panelGrid>
		<h:panelGrid align="right" styleClass="locked_top">
			<h:panelGroup>
			    <f:verbatim>
			         <%=LanguageSupport.getResource("COMM-1043","记录数")%>
			    </f:verbatim>
				<h:outputText value="#{emp_engageBB.pagevo.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				 <f:verbatim>
			         <%=LanguageSupport.getResource("COMM-1044","页数")%>:
			     </f:verbatim>
				<h:outputText value="#{emp_engageBB.pagevo.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				 <f:verbatim>
			          <%=LanguageSupport.getResource("COMM-1045","每页有")%>
			    </f:verbatim>
				<h:outputText value="#{emp_engageBB.pagevo.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				 <f:verbatim>
			           <%=LanguageSupport.getResource("COMM-1046","当前为第")%>
			    </f:verbatim>
				<h:outputText value="#{emp_engageBB.pagevo.currentPage}"></h:outputText>
				 <f:verbatim>
			           <%=LanguageSupport.getResource("COMM-1047","页")%>
			    </f:verbatim>
				  
				<h:commandButton value="首页" action="#{emp_engageBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="上页" action="#{emp_engageBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="下页" action="#{emp_engageBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="尾页" action="#{emp_engageBB.last}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
		<h:dataTable value="#{emp_engageBB.personList}" var="list"
			align="center" id="dateList" headerClass="td_top"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
			styleClass="table03" width="90%">

			<h:column>
				<c:facet name="header">
				      <f:verbatim>
			               上岗时间
			    		</f:verbatim>
				</c:facet>
				<h:outputText value="#{list.engageDate}" />
			</h:column>

            <h:column>
                <c:facet name="header">
                      <f:verbatim>
                       <%=LanguageSupport.getResource("RYGL-2136","员工姓名")%>
                        </f:verbatim>
                </c:facet>
                <h:outputText value="#{list.persName}" />
            </h:column>

			<h:column>
				<c:facet name="header">
				     <f:verbatim>
			           单位
			    	</f:verbatim>
				</c:facet>
				<h:outputText value="#{list.engageOrgName}" />
			</h:column>

			<h:column>
				<c:facet name="header">
				    <f:verbatim>
			           入职部门
			         </f:verbatim>
				</c:facet>
				<h:outputText value="#{list.engageDeptName}" />
			</h:column>

		</h:dataTable>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>