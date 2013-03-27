<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function doSelectPost(id){
       window.showModalDialog("/user/RolePostList.jsf?roleID="+id, "", "dialogWidth:500px; dialogHeight:400px; status:0;resizable:yes");
    }
    function saveAsRole(){
        showx = event.screenX - event.offsetX - 250;
        showy = event.screenY - event.offsetY + 18;
        retval = window.showModalDialog("/user/NewRoleName.jsf", "", "dialogWidth:260px; dialogHeight:200px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");

        if (retval != null && retval!="") {
            document.forms[0]["formRoleList:newRoleName"].value = retval;
            return true;
        }
        return false;
    }
    function copyRole(){
        showx = event.screenX - event.offsetX - 250;
        showy = event.screenY - event.offsetY + 18;

        window.showModalDialog("/user/CopyRole.jsf", "", "dialogWidth:360px; dialogHeight:200px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
        return true;
    }
    function showRoleTree(){
        window.showModalDialog("/user/RoleTree.jsf", null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
    function showOperateTree(){
        window.showModalDialog("/user/BatchOperate.jsf", null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
</script>
<x:saveState value="#{user_roleManageBB}"/>
<h:form id="formRoleList">
    <h:inputHidden id="pageInit" value="#{user_roleManageBB.pageInit}"/>
    <h:inputHidden id="newRoleName" value="#{user_roleManageBB.newRoleName}"/>
    <h:inputHidden id="sourceRoleId" value="#{user_roleManageBB.sourceRoleId}"/>
    <c:verbatim>
    <table height=98% width=98% >
    <tr><td height=8>
    </c:verbatim>
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
           <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value=" ϵͳ���� ->  ��ɫ����"/>
            </h:panelGroup>

            <h:panelGrid columns="1" cellpadding="0"  align="right" border="0">
                <h:panelGroup>
                    <h:selectBooleanCheckbox value="#{user_roleManageBB.showAll}" onclick="submit();" valueChangeListener="#{user_roleManageBB.queryAll}"></h:selectBooleanCheckbox>
                    <h:outputText value="��ʾȫ����ɫ"></h:outputText>
                    <h:outputText value="  "></h:outputText>
                    <h:commandButton value="��ʾ��ɫ��"   onclick="return showRoleTree();" type="button" styleClass="button01"/>
                    <h:commandButton value="����������Ȩ"   onclick="return showOperateTree();" type="button" styleClass="button01"/>
                    <h:commandButton value="�� ��"   onclick="return checkBatchDo('selectItem')" action="#{user_roleManageBB.openRoles}" styleClass="button01"/>
                    <h:commandButton value="�� ��"   onclick="return checkBatchDo('selectItem')" action="#{user_roleManageBB.closeRoles}" styleClass="button01"/>
                    <h:commandButton value="�� ��" onclick="return copyRole();" styleClass="button01"/>
                    <h:commandButton value="�� ��" action="edit" styleClass="button01">
                        <x:updateActionListener property="#{user_editRoleBB.editStatus}" value="false"/>
                    </h:commandButton>
                    <h:commandButton value="ɾ ��"   onclick="return checkBatchDelete('selectItem')" action="#{user_roleManageBB.deleteRoles}" styleClass="button01"/>
                </h:panelGroup>
            </h:panelGrid>
        </h:panelGrid>
    <c:verbatim>
    </td></tr>

    <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
        <x:dataTable id="tbl_roleinfolist" align="center" value="#{user_roleManageBB.roleinfos}" var="list" width="97%" rowIndexVar="index" 
               styleClass="table03" headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center">
            <h:column>
                <f:facet name="header">
                    <f:verbatim escape="false">
                        <input type="checkbox" name="all"
                               onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                    </f:verbatim>
                </f:facet>
                <f:verbatim escape="false">
                    <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                <h:outputText value="#{list.roleId}"/>
                <f:verbatim escape="false">"/></div></f:verbatim>
            </h:column>
			
            <h:column>
				<f:facet name="header">
					<h:outputText value="���" />
				</f:facet>
				<h:outputText value="#{index+1}"></h:outputText>
			</h:column>
			
            <h:column>
                <f:facet name="header">
                    <h:outputText value="��ɫ����"/>
                </f:facet>
                <h:graphicImage value="/images/common/unvalidate.gif" rendered="#{list.forbidden=='1'}"></h:graphicImage>
                <h:outputText escape="false" value="#{list.roleName}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="�ϼ���ɫ"/>
                </f:facet>
                <h:outputText escape="false" value="#{list.creatorName}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="����Ȩ������"/>
                </f:facet>
                <h:panelGrid align="center">
                    <h:outputText escape="false" value="#{list.processunitid}"/>
                </h:panelGrid>
            </h:column>
            <h:column>
                <f:facet name="header">
                    <h:outputText value="ϵͳ����Ա"/>
                </f:facet>
                <h:panelGrid align="center">
                    <h:outputText escape="false" value="#{list.sysOper}"/>
                </h:panelGrid>
            </h:column>
            <h:column>
                <f:facet name="header">
                    <h:outputText value="�����쵼"/>
                </f:facet>
                <h:panelGrid align="center">
                    <h:outputText escape="false" value="#{list.unitLeader}"/>
                </h:panelGrid>
            </h:column>
            <h:column>
                <f:facet name="header">
                    <h:outputText value="�����쵼"/>
                </f:facet>
                <h:panelGrid align="center">
                    <h:outputText escape="false" value="#{list.deptLeader}"/>
                </h:panelGrid>
            </h:column>
            <h:column>
                <f:facet name="header">
                    <h:outputText value="HRרҵ��Ա"/>
                </f:facet>
                <h:panelGrid align="center">
                    <h:outputText escape="false" value="#{list.businessUser}"/>
                </h:panelGrid>
            </h:column>

             <h:column>
                <f:facet name="header">
                    <h:outputText value="CHO"/>
                </f:facet>
                <h:outputText escape="false" value="#{list.cho}"/>
            </h:column>

            <h:column>
               <f:facet name="header">
                   <h:outputText value="����"/>
               </f:facet>
               <h:selectOneRadio value="#{list.forbidden}" disabled="true">
                   <c:selectItem itemValue="1" itemLabel="��"></c:selectItem>
                   <c:selectItem itemValue="0" itemLabel="��"></c:selectItem>
               </h:selectOneRadio>
           </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="����"/></f:facet>
                <h:panelGrid align="center" cellspacing="2" columns="5">
                    <h:outputText id="display" value="ϵͳԤ�ƽ�ɫ" rendered="#{!list.canEdit}" />
                    <h:commandButton id="modify" styleClass="button01" action="edit" value="�޸�" rendered="#{list.canEdit}">
                        <x:updateActionListener property="#{user_editRoleBB.editStatus}" value="true"/>
                        <x:updateActionListener property="#{user_editRoleBB.roleId}" value="#{list.roleId}"/>
                    </h:commandButton>
                    <h:commandButton styleClass="button01" action="setpms" value="����" rendered="#{list.canEdit || list.roleId=='01'}">
                        <x:updateActionListener property="#{user_creditManageBB.pageFlag}" value="1"/>
                        <x:updateActionListener property="#{user_creditManageBB.paramId}" value="#{list.roleId}"/>
                        <x:updateActionListener property="#{user_creditManageBB.name}" value="#{list.roleName}"/>
                        <x:updateActionListener property="#{user_creditManageBB.manageFlag}" value="#{list.sysOper}"/>
                    </h:commandButton>
                    <h:commandButton styleClass="button01" action="#{user_roleManageBB.saveAsRoleInfo}" value="���" onclick="return saveAsRole()" rendered="#{list.canEdit}">
                        <x:updateActionListener property="#{user_roleManageBB.sourceRoleId}" value="#{list.roleId}"/>
                    </h:commandButton>
                     <h:commandButton id="view" styleClass="button01" action="userlist" value="�鿴�û�">
                        <x:updateActionListener property="#{user_roleUserListBB.roleId}" value="#{list.roleId}"/>
                        <x:updateActionListener property="#{user_roleUserListBB.roleName}" value="#{list.roleName}"/>
                    </h:commandButton>
                    <h:commandButton styleClass="button01" value="������λ" type="button" onclick="doSelectPost('#{list.roleId}');"></h:commandButton>
                </h:panelGrid>
            </h:column>
          </x:dataTable>
<c:verbatim>
        </div>
    </td></tr>
    </table>
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("formRoleList:tbl_roleinfolist");
</script>