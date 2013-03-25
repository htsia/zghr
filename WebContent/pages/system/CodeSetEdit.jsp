<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

	<h:form id="formCodeSetEdit">
        <h:inputHidden id="pageInit" value="#{sys_codeSetEditBB.pageInit}"/>
        <h:inputHidden value="#{sys_codeSetEditBB.setId}"/>
        <h:inputHidden value="#{sys_codeSetEditBB.editStatus}"/>

        <h:panelGrid columns="1" width="97%" cellpadding="0" align="center"
			cellspacing="0" border="0" >

			<h:panelGrid columns="2" width="97%" cellpadding="0" border="1" align="center" styleClass="table03"  columnClasses="td_form01,td_form02">
                 <f:verbatim>
				   <%=LanguageSupport.getResource("XTGL-1009", "���뼯����")%>
		         </f:verbatim>
				<h:inputText value="#{sys_codeSetEditBB.cs.setName}"   alt="���뼯����|0|s|50" styleClass="input" />
                 
                  <f:verbatim>
				   <%=LanguageSupport.getResource("XTGL-1008", "�������")%>
		         </f:verbatim>
				<h:inputText value="#{sys_codeSetEditBB.cs.setDesc}"  alt="�������|1|s|50" styleClass="input" />
                
				 <f:verbatim>
				   <%=LanguageSupport.getResource("XTGL-1010", "¼���ʶ")%>
		         </f:verbatim>
				<h:selectOneMenu value="#{sys_codeSetEditBB.cs.setLayer}">
					<f:selectItem itemValue="0" itemLabel="¼�뵽������"   />
					<f:selectItem itemValue="1" itemLabel="¼�뵽��ײ��" />
				</h:selectOneMenu>

				 <f:verbatim>
				   <%=LanguageSupport.getResource("XTGL-1006", "����/����")%>
		         </f:verbatim>
				<h:selectOneRadio value="#{sys_codeSetEditBB.cs.setStatus}">
					<f:selectItem itemValue="1" itemLabel="����" />
					<f:selectItem itemValue="0" itemLabel="����" />
				</h:selectOneRadio>

                 <f:verbatim>
				   <%=LanguageSupport.getResource("XTGL-1134", "�Ƿ��������")%>
		         </f:verbatim>
                <h:selectOneRadio value="#{sys_codeSetEditBB.cs.scaleCode}">
                      <c:selectItem itemValue="1" itemLabel="��"></c:selectItem>
                      <c:selectItem itemValue="0" itemLabel="��"></c:selectItem>
                </h:selectOneRadio>

            </h:panelGrid>

			<f:verbatim>
				<br>
			</f:verbatim>
			<h:panelGrid columns="2" width="20%" cellpadding="0"
				align="center" border="0">
				<h:commandButton value="�� ��" action="#{sys_codeSetEditBB.saveCodeSet}" styleClass="button01" />
				<h:commandButton value="�� ��" action="setlist" styleClass="button01" >
                </h:commandButton>
            </h:panelGrid>
		</h:panelGrid>
	</h:form>
