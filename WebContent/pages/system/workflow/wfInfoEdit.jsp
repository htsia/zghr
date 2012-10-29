<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
        function getApplyOrgs(){
            if (document.all('form1:orguid').value=="-1" || document.all('form1:orguid').value==""){
                PopUpMutilOrgTwoControl('form1:text5code','form1:text5','1','');
            }
            else{
                PopUpMutilOrgTwoControl('form1:text5code','form1:text5','1',document.all('form1:orguid').value);
            }
        }
        function TypeIDchange(){
            if (document.all("form1:name").value==""){
                var i=0;
                for(;i<document.all("form1:typeID").options.length;i++){
                   if (document.all("form1:typeID").options[i].selected){
                       document.all("form1:name").value=document.all("form1:typeID").options[i].text;
                   }
                }
            }
        }
        function forSelSource() {
            PopUpMutilCodeDlgNoSubmit('form1:classvalue', 'form1:classvaluedes', document.all("form1:sourceField").value,'');
            return false;
        }

        function doCheck() {
            if (document.all("form1:name").value==""){
                alert("��¼������!");
                return false;
            }
            if (document.all("form1:typeID").value=="" || document.all("form1:typeID").value=="-1"){
                alert("��ѡ������ģ��!");
                return false;
            }
            return true;
        }
    </script>

<x:saveState value="#{sys_workflowcfgBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit"	value="#{sys_workflowcfgBB.initEditDefine}" />

	<h:panelGrid align="center" width="98%">
		<h:panelGrid columns="2" align="right" cellspacing="2">
			<h:commandButton styleClass="button01" value="����"
				action="#{sys_workflowcfgBB.saveDefine}" onclick="return doCheck();" />
			<h:commandButton styleClass="button01" type="button" value="ȡ������"
				onclick="window.close();" />
		</h:panelGrid>

        <h:outputText escape="false" value="<font color='blue'><strong>������Ϣ</strong></font>"></h:outputText>
		<h:panelGrid columns="2" width="100%"
			columnClasses="td_form01,td_form02" align="center"
			styleClass="table03">
			  <f:verbatim>
                  <%=LanguageSupport.getResource("JGGL-1058","����")%>  
             </f:verbatim>
			<h:inputText id="name" value="#{sys_workflowcfgBB.definebo.defName}" />
 
             <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1154","����ģ��")%>  
             </f:verbatim>
			<h:selectOneMenu id="typeID"
				value="#{sys_workflowcfgBB.definebo.typeID}"
				disabled="#{sys_workflowcfgBB.definebo.defID!=null && sys_workflowcfgBB.definebo.defID!=''}">
				<c:selectItems value="#{sys_workflowcfgBB.typeList}"></c:selectItems>
			</h:selectOneMenu>
              
             <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1030","�Ƿ�����")%>  
             </f:verbatim>
			<h:selectOneMenu id="isuse"
				value="#{sys_workflowcfgBB.definebo.isuse}">
				<c:selectItem itemValue="1" itemLabel="��"></c:selectItem>
				<c:selectItem itemValue="0" itemLabel="��"></c:selectItem>
			</h:selectOneMenu>

			 <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1031","��������")%>  
             </f:verbatim>
			<h:selectOneMenu id="orguid"
				value="#{sys_workflowcfgBB.definebo.orguid}">
				<c:selectItems value="#{sys_workflowcfgBB.orgList}"></c:selectItems>
			</h:selectOneMenu>
             
             <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1032","���û���")%>  
             </f:verbatim>
			<h:panelGroup>
				<h:inputTextarea id="text5"
					value="#{sys_workflowcfgBB.definebo.deptiDes}" cols="45" rows="3"
					readonly="true" />
				<h:inputHidden id="text5code"
					value="#{sys_workflowcfgBB.definebo.deptids}" />
				<h:commandButton type="button" styleClass="button_org"
					onclick="getApplyOrgs();" />
			</h:panelGroup>
		</h:panelGrid>
         
         <h:outputText escape="false" value="<font color='blue'><strong>�����޶�����</strong></font>"></h:outputText>
		<h:panelGrid columns="2" width="100%"
			columnClasses="td_form01,td_form02" align="center"
			styleClass="table03">
		   <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1152","��ѡָ����")%>  
           </f:verbatim>
			<h:panelGroup>
				<h:inputText id="infoItemText" readonly="true" size="30"
					value="#{sys_workflowcfgBB.definebo.conFieldName}"></h:inputText>
				<h:inputHidden id="infoItemID"
					value="#{sys_workflowcfgBB.definebo.conField}"></h:inputHidden>
				<c:verbatim>
					<input type="button" class="button_select"
						onclick="selectInfoItem('A',document.all('form1:infoItemText'),document.all('form1:infoItemID'))">
				</c:verbatim>
			</h:panelGroup> 
             <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1151","��ѡ����ֵ")%>  
           </f:verbatim>
			<h:panelGroup>
				<h:inputText id="condText" readonly="true" size="30"
					value="#{sys_workflowcfgBB.definebo.conValueDes}"></h:inputText>
				<h:inputHidden id="condValue"
					value="#{sys_workflowcfgBB.definebo.conValue}"></h:inputHidden>
				<c:verbatim>
					<input type="button" class="button_select"
						onclick="PopUpMutilCodeDlgNoSubmit(document.all('form1:condValue'),document.all('form1:condText'),document.all('form1:infoItemID').value,'')">
				</c:verbatim>
			</h:panelGroup>
		</h:panelGrid>

        <h:panelGroup>
                <h:outputText escape="false" value="<font color='blue'><strong>����֪ͨ</strong></font>"></h:outputText>
                <h:selectBooleanCheckbox value="#{sys_workflowcfgBB.definebo.autoToCreateCheck}"></h:selectBooleanCheckbox>
                <h:outputText value="�Զ�֪ͨ������"></h:outputText>
        </h:panelGroup>
        <h:panelGrid columns="2" width="100%"
            columnClasses="td_form01,td_form02" align="center"
            styleClass="table03">
            <h:outputText value="��Ϣ��ʽ"></h:outputText>
            <h:inputTextarea cols="45" rows="3" value="#{sys_workflowcfgBB.definebo.endMssage}"></h:inputTextarea>

            <h:outputText value="������"></h:outputText>
             <h:panelGroup>
              <h:inputHidden id="recID" value="#{sys_workflowcfgBB.personId}"></h:inputHidden>
              <h:inputHidden id="recName" value="#{sys_workflowcfgBB.personName}"/>
              <h:commandButton value="����" styleClass="button01" onclick="return fPopUpPerDlgInSelf('form1:recName', 'form1:recID')" action="#{sys_workflowcfgBB.addPerson}"></h:commandButton>
               <c:verbatim><br><br></c:verbatim>  
             <h:dataTable value="#{sys_workflowcfgBB.receiveIDs}" var="list" align="center"  id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="95%" >
                 <h:column>
                     <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
                     <h:outputText value="#{list.personCode}"/>
                 </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����"/></c:facet>
                    <h:outputText value="#{list.name}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="��λ"/></c:facet>
                    <h:outputText value="#{list.orgName}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����"/></c:facet>
                    <h:outputText value="#{list.deptName}"/>
                </h:column>

                 <h:column>
                      <c:facet name="header"><h:outputText value="����"/></c:facet>
                      <h:commandButton value="ɾ��" styleClass="button01" action="#{sys_workflowcfgBB.deletePerson}">
                          <x:updateActionListener property="#{sys_workflowcfgBB.personId}" value="#{list.personId}"></x:updateActionListener>
                      </h:commandButton>
                 </h:column>
        </h:dataTable>
            </h:panelGroup>
        </h:panelGrid>

    </h:panelGrid>
</h:form>
<script type="text/javascript">
    document.all("form1:typeID").onchange=TypeIDchange;
</script>