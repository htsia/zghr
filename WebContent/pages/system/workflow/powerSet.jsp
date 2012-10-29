<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<script type="text/javascript">
   function addRole(){
       retval = window.showModalDialog("/pages/user/SelRoleList.jsf", "", "dialogWidth:315px; dialogHeight:410px; status:0;resizable:yes");
       // retval = "��ɫID:����Ա��ʾ����ɫID:����Ա��ʾ...."
       if (retval == null || retval == ""){
           return false;
       }
       document.all("form1:roles").value=retval;
       return true;
   }
</script>

<x:saveState value="#{sys_workflowcfgBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{sys_workflowcfgBB.initNodePower}"/>
    <h:inputHidden value="#{sys_workflowcfgBB.nodeid}"></h:inputHidden>
    <f:verbatim>
    <table height=98% width=98%>
     <tr><td height=8 align="right">
</f:verbatim>
           <h:inputHidden id="roles" ></h:inputHidden>
           <h:commandButton value="���ӽ�ɫ" onclick="return addRole();" styleClass="button01" action="#{sys_workflowcfgBB.addRole}" />
<f:verbatim>    
     </td></tr>

     <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <h:dataTable id="dateList" align="center" value="#{sys_workflowcfgBB.powerList}" var="list" width="97%" 
               styleClass="table03" headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center">
            <h:column>
                <f:facet name="header">
                    <f:verbatim>
					   <%=LanguageSupport.getResource("XTGL-1064", "��ɫ����")%>
				   </f:verbatim>
                </f:facet>
                <h:outputText escape="false" value="#{list.roleName}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                     <f:verbatim>
					   <%=LanguageSupport.getResource("XTGL-1066", "����Ȩ������")%>
				   </f:verbatim>
                </f:facet>
                <h:panelGrid align="center">
                    <h:outputText escape="false" value="#{list.processunitid}"/>
                </h:panelGrid>
            </h:column>
            <h:column>
                <f:facet name="header">
                     <f:verbatim>
					   <%=LanguageSupport.getResource("XTGL-1067", "ϵͳ����Ա")%>
				   </f:verbatim>
                </f:facet>
                <h:panelGrid align="center">
                    <h:outputText escape="false" value="#{list.sysOper}"/>
                </h:panelGrid>
            </h:column>
            <h:column>
                <f:facet name="header">
                      <f:verbatim>
					   <%=LanguageSupport.getResource("XTGL-1068", "�����쵼")%>
				   </f:verbatim>
                </f:facet>
                <h:panelGrid align="center">
                    <h:outputText escape="false" value="#{list.unitLeader}"/>
                </h:panelGrid>
            </h:column>
            <h:column>
                <f:facet name="header">
                       <f:verbatim>
					   <%=LanguageSupport.getResource("XTGL-1069", "�����쵼")%>
				   </f:verbatim>
                </f:facet>
                <h:panelGrid align="center">
                    <h:outputText escape="false" value="#{list.deptLeader}"/>
                </h:panelGrid>
            </h:column>
            <h:column>
                <f:facet name="header">
                     <f:verbatim>
					   <%=LanguageSupport.getResource("XTGL-1070", "HRרҵ��Ա")%>
				   </f:verbatim>
                </f:facet>
                <h:panelGrid align="center">
                    <h:outputText escape="false" value="#{list.businessUser}"/>
                </h:panelGrid>
            </h:column>
             <h:column>
                <f:facet name="header">
                    <h:outputText value="CHO"/>
                </f:facet>
                <h:panelGrid align="center">
                    <h:outputText escape="false" value="#{list.cho}"/>
                </h:panelGrid>
            </h:column>
            <h:column>
                <f:facet name="header">
                       <f:verbatim>
					   <%=LanguageSupport.getResource("YXGL-1026", "����")%>
				   </f:verbatim>
                </f:facet>
                <h:panelGrid align="center" cellspacing="2" columns="5">
                    <h:outputText id="display" value="ϵͳԤ�ƽ�ɫ" rendered="#{!list.canEdit}" />
                    <h:commandButton value="ɾ��" styleClass="button01" action="#{sys_workflowcfgBB.deleteRole}">
                        <x:updateActionListener property="#{sys_workflowcfgBB.roleid}" value="#{list.roleId}"></x:updateActionListener>
                    </h:commandButton>
                </h:panelGrid>
            </h:column>
          </h:dataTable>
<f:verbatim>
        </div>
     </td></tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
    setDataTableOver("form1:dateList");
</script>
