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
		window.showModalDialog("/employee/info/addEngage.jsf", "",	"dialogWidth:425px; dialogHeight:240px; status:0;resizable:no");
		return true;
	}
    function queryAll(){
        document.all('form1:month').value='';
        return true;
    }
    function selectOrg(){
        PopUpOrgOnlyDlgTwoControl("form1:orgID","form1:orgName","1");
        return true;
    }
</script>

<x:saveState value="#{emp_engageBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{emp_engageBB.pageInit}"></h:inputHidden>
	<h:panelGrid width="100%">
		<h:panelGrid width="98%" columns="2" styleClass="td_title"
			align="center">
			<h:panelGroup>
				<h:graphicImage value="/images/tips.gif" />
				 <f:verbatim>
			         <%=LanguageSupport.getResource("RYGL-2310","��Ƹ��Ա����")%>
		        </f:verbatim>
			</h:panelGroup>

			<h:panelGrid align="right">
				<h:panelGroup>
					<h:outputText escape="false" value="#{emp_engageBB.auditCheck}"
						rendered="#{emp_engageBB.auditCheck!=''}"></h:outputText>
			   <f:verbatim>
			         <%=LanguageSupport.getResource("RYGL-2256","�·�")%>:
		        </f:verbatim>
					<h:inputText readonly="true" id="month"
						value="#{emp_engageBB.month}"></h:inputText>
					<h:commandButton type="button" styleClass="button_select"
						onclick="PopUpCalendarDlg_OnlyMonth('form1:month')" />
					<h:commandButton styleClass="button01" value="��ѯ"></h:commandButton>
                    <h:commandButton styleClass="button01" value="ȫ��" onclick="return queryAll();"></h:commandButton>
                    <h:commandButton styleClass="button01" value="����"	onclick="doAddPerson()"></h:commandButton>
				</h:panelGroup>
			</h:panelGrid>
		</h:panelGrid>
		<h:panelGrid width="98%" styleClass="locked_top" columns="2">
            <h:panelGrid align="left" columns="4" width="50%">
                <h:outputText value="��ǰ��λ:"></h:outputText>
                <h:outputText id="orgName" value="#{emp_engageBB.orgName}"></h:outputText>
                <h:inputHidden id="orgID" value="#{emp_engageBB.orgID}"></h:inputHidden>
                <h:commandButton value="�л���λ"  styleClass="button01" rendered="#{emp_engageBB.showChangeUnit}" onclick="return selectOrg();"></h:commandButton>
            </h:panelGrid>

            <h:panelGrid align="right">
            <h:panelGroup>
			    <f:verbatim>
			         <%=LanguageSupport.getResource("COMM-1043","��¼��")%>
			    </f:verbatim>
				<h:outputText value="#{emp_engageBB.pagevo.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				 <f:verbatim>
			         <%=LanguageSupport.getResource("COMM-1044","ҳ��")%>:
			     </f:verbatim>
				<h:outputText value="#{emp_engageBB.pagevo.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				 <f:verbatim>
			          <%=LanguageSupport.getResource("COMM-1045","ÿҳ��")%>
			    </f:verbatim>
				<h:outputText value="#{emp_engageBB.pagevo.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				 <f:verbatim>
			           <%=LanguageSupport.getResource("COMM-1046","��ǰΪ��")%>
			    </f:verbatim>
				<h:outputText value="#{emp_engageBB.pagevo.currentPage}"></h:outputText>
				 <f:verbatim>
			           <%=LanguageSupport.getResource("COMM-1047","ҳ")%>
			    </f:verbatim>
				  
				<h:commandButton value="��ҳ" action="#{emp_engageBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{emp_engageBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{emp_engageBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="βҳ" action="#{emp_engageBB.last}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
            </h:panelGrid>
        </h:panelGrid>
		<h:dataTable value="#{emp_engageBB.personList}" var="list"
			align="center" id="dateList" headerClass="td_top"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
			styleClass="table03" width="90%">

			<h:column>
				<c:facet name="header">
				      <f:verbatim>
			           <%=LanguageSupport.getResource("RYGL-2311","��Ƹʱ��")%>
			    		</f:verbatim>
				</c:facet>
				<h:outputText value="#{list.engageDate}" />
			</h:column>

			<h:column>
				<c:facet name="header">
				     <f:verbatim>
			           <%=LanguageSupport.getResource("RYGL-2312","��Ƹ��λ")%>
			    		</f:verbatim>
				</c:facet>
				<h:outputText value="#{list.engageOrgName}" />
			</h:column>

			<h:column>
				<c:facet name="header">
				    <f:verbatim>
			           <%=LanguageSupport.getResource("RYGL-2313","��Ƹ����")%>
			    		</f:verbatim>
				</c:facet>
				<h:outputText value="#{list.engageDeptName}" />
			</h:column>

			<h:column>
				<c:facet name="header">
				      <f:verbatim>
			           <%=LanguageSupport.getResource("RYGL-2136","Ա������")%>
			    		</f:verbatim>
				</c:facet>
				<h:outputText value="#{list.persName}" />
			</h:column>

            <h:column>
                <c:facet name="header">
                      <f:verbatim>
                       <%=LanguageSupport.getResource("COMM-0011","����")%>
                       </f:verbatim>
                </c:facet>
                <h:commandButton value="ȡ����Ƹ" styleClass="button01" onclick="return Confirm('ȷ��ȡ����Ƹ��?');" action="#{emp_engageBB.cancel}">
                    <x:updateActionListener property="#{emp_engageBB.itemID}" value="#{list.itemID}"/>
                </h:commandButton>
            </h:column>

		</h:dataTable>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>