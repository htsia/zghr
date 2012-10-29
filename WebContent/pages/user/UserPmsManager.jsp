<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{user_userPmsManagerBB}"/>
<h:form id="formUserPmsManager">
<h:commandButton id="doQuery" action="#{user_userPmsManagerBB.doQuery}" style="display:none"/>
<h:inputHidden id="queryType" value="#{user_userPmsManagerBB.queryType}"/>
<h:inputHidden id="selOrgId" value="#{user_userPmsManagerBB.selOrgId}"/>
<h:inputHidden id="selRoleId" value="#{user_userPmsManagerBB.selRoleId}"/>
<h:inputHidden id="pageInit" value="#{user_userPmsManagerBB.pageInit}"/>
<h:inputHidden id="orgId" value="#{user_userPmsManagerBB.orgId}"/>
<h:inputHidden id="personType" value="#{user_userPmsManagerBB.personType}"/>
<f:verbatim>
<table height="98%" width="100%" cellpadding="0"  align="center" border="0" >
   <tr>
       <td height=8 colspan="2">
</f:verbatim>
           <h:outputText value="��ǰ��Ա���:#{user_userPmsManagerBB.personTypeDes}"></h:outputText>
<f:verbatim>
       </td>
   </tr>

   <tr>
    <td height=8>
</f:verbatim>
        <h:selectOneMenu id="condiType" value="#{user_userPmsManagerBB.condiType}">
            <f:selectItem itemValue="personName" itemLabel="������Ա�����"></f:selectItem>
            <f:selectItem itemValue="postType" itemLabel="��λ���"></f:selectItem>
         </h:selectOneMenu>
        <h:inputText id="condiValue" styleClass="input" value="#{user_userPmsManagerBB.condiValue}" size="20"
                     onkeypress="enterKeyDown('formUserPmsManager:btnSearch')"></h:inputText>
        <h:commandButton id="btnSearch" value="�� ѯ" action="#{user_userPmsManagerBB.doQuery}"
                         onclick="return queryByUserName()" styleClass="button01"/>
<f:verbatim>
    </td>
    <td align="right">
</f:verbatim>
            <h:outputText value="��#{user_userPmsManagerBB.pagevo.totalPage}ҳ"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="ÿҳ��#{user_userPmsManagerBB.pagevo.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="��ǰΪ��#{user_userPmsManagerBB.pagevo.currentPage}ҳ"></h:outputText>
            <h:commandButton value="��ҳ" action="#{user_userPmsManagerBB.first}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{user_userPmsManagerBB.pre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{user_userPmsManagerBB.next}" styleClass="button01"></h:commandButton>
            <h:commandButton value="βҳ" action="#{user_userPmsManagerBB.last}" styleClass="button01"></h:commandButton>
<f:verbatim>
    </td>
    </tr>

    <tr>
    <td height=8 align="right" colspan="2">
</f:verbatim>
        <h:commandButton value="�Ż�������Ȩ" onclick="return portalAssign();" type="button"      styleClass="button01"/>
        <h:commandButton value="�Ż�������Ȩ" onclick="return portalGroupAssign();"  styleClass="button01" action="#{user_userPmsManagerBB.batchAssignPortal}"/>
        <h:commandButton value="����ҵ������Ȩ" onclick="return singleSelfAssign()" action="#{user_userPmsManagerBB.assignSelfOper}"
                         styleClass="button01"/>
        <h:commandButton value="���ô���" onclick="return agentAssign()" type="button"  styleClass="button01" rendered="#{user_userPmsManagerBB.canAgent}"/>
        <h:commandButton value="������Ȩ" onclick="return singleAssign()" action="#{user_userPmsManagerBB.assignRole}"
                         styleClass="button01"/>
        <h:commandButton value="������Ȩ" onclick="return doPopUpRoleInfoDlg()" action="#{user_userPmsManagerBB.assignRole}"
                         styleClass="button01"/>
        <h:commandButton value="�����ɫ" action="#{user_userPmsManagerBB.clearRole}" onclick="return confirmClear()"
                         styleClass="button01"/>
        <h:commandButton value="�鿴��ɫ" onclick="return viewRoleList()" action="" styleClass="button01"/>
<f:verbatim>
    </td>
    </tr>

    <tr><td colspan="2">
    <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <h:dataTable value="#{user_userPmsManagerBB.personList}" var="list" width="100%"      id="dataList"
                styleClass="table03" headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center">
        <h:column>
            <f:facet name="header">
                <f:verbatim escape="false">
                    <input type="checkbox" name="all"
                           onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                </f:verbatim>
            </f:facet>

            <f:verbatim escape="false">
                <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim><h:outputText value="#{list.personId}"/><f:verbatim escape="false">"/></div></f:verbatim>
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText value="����"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.name}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText value="��¼��"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.loginName}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText value="״̬"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.status}"/>
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText value="�Ա�"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.sex}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText value="��Ա���"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.personType}"/>
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText value="����"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.orgId}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText value="����"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.deptId}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText value="����Ա"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.sysOper}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText value="HR��Ա"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.businessUser}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText value="�����쵼"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.unitLeader}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText value="�����쵼"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.deptLeader}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText value="CHO"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.cho}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="����"/></f:facet>
            <h:panelGrid align="center" cellspacing="2" columns="1">
                <h:commandButton styleClass="button01" action="setpms" value="�鿴Ȩ��">
                    <x:updateActionListener property="#{user_creditManageBB.pageFlag}" value="2"/>
                    <x:updateActionListener property="#{user_creditManageBB.paramId}" value="#{list.personId}"/>
                    <x:updateActionListener property="#{user_creditManageBB.name}" value="#{list.name}"/>
                    <x:updateActionListener property="#{user_creditManageBB.condiValue}"  value="#{user_userPmsManagerBB.condiValue}"/>
                    <x:updateActionListener property="#{user_creditManageBB.condiType}"  value="#{user_userPmsManagerBB.condiType}"/>
                    <x:updateActionListener property="#{user_creditManageBB.orgId}" value="#{user_userPmsManagerBB.orgId}"/>
                    <x:updateActionListener property="#{user_creditManageBB.personType}"
                                            value="#{user_userPmsManagerBB.personType}"/>
                    <x:updateActionListener property="#{user_creditManageBB.queryType}"
                                            value="#{user_userPmsManagerBB.queryType}"/>

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
<script type="text/javascript">
   setDataTableOver("formUserPmsManager:dataList");
   function confirmClear() {
       var chitem = document.forms(0).selectItem;
       if (chitem == null) {
           alert('�б���û���û���');
           return false;
       }
       if (chitem.length == null) {
           perid = chitem.value;
           if (perid == null) {
               alert('��ѡ��Ҫ���Ȩ�޵��û���');
               return false;
           }
       } else {
           var chklen = 0;
           for (i = 0; i < chitem.length; i++) {
               if (chitem[i].checked)
                   chklen++;
           }
           if (chklen == 0) {
               alert('��ѡ��Ҫ���Ȩ�޵��û���');
               return false;
           }
       }
       return confirm("ȷʵҪ�����")
   }

   function doPopUpRoleInfoDlg() {
       showx = event.screenX - event.offsetX - 250;
       showy = event.screenY - event.offsetY + 18;
       var chitem = document.forms(0).selectItem;
       if (chitem == null) {
           alert('�б���û���û���');
           return false;
       }
       if (chitem.length == null) {
           perid = chitem.value;
           if (perid == null) {
               alert('��ѡ��Ҫ������û���');
               return false;
           }
       }
       else {
           var chklen = 0;
           for (i = 0; i < chitem.length; i++) {
               if (chitem[i].checked)
                   chklen++;
           }
           if (chklen == 0) {
               alert('��ѡ��Ҫ������û���');
               return false;
           }
       }
       retval = window.showModalDialog("/pages/user/SelRoleList.jsf", "", "dialogWidth:315px; dialogHeight:410px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
       // retval = "��ɫID:����Ա��ʾ����ɫID:����Ա��ʾ...."
       if (retval == null || retval == ""){
           return false;
       }
       var items = retval.split(",");
       for (i = 0; i < items.length; i++) {
           var items2 = items[i].split(":");
           //�жϣ����ѡ���˹���Ա����ֻ������һ���û�
           if (items2.length > 1)
               if (items2[1] == "1" && chklen > 1)
                   alert(' һ������Ա��ɫֻ��������һ���û�')
       }
       document.forms[0]["formUserPmsManager:selRoleId"].value = retval;
       return true;
   }

   function portalGroupAssign() {
       showx = event.screenX - event.offsetX - 250;
       showy = event.screenY - event.offsetY + 18;
       var chitem = document.forms(0).selectItem;
       if (chitem == null) {
           alert('�б���û���û���');
           return false;
       }
       if (chitem.length == null) {
           perid = chitem.value;
           if (perid == null) {
               alert('��ѡ��Ҫ������û���');
               return false;
           }
       }
       else {
           var chklen = 0;
           for (i = 0; i < chitem.length; i++) {
               if (chitem[i].checked)
                   chklen++;
           }
           if (chklen == 0) {
               alert('��ѡ��Ҫ������û���');
               return false;
           }
       }
       retval = window.showModalDialog("/user/SelPortalList.jsf", "", "dialogWidth:315px; dialogHeight:410px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
       // retval = "��ɫID:����Ա��ʾ����ɫID:����Ա��ʾ...."
       if (retval == null || retval == ""){
           return false;
       }
       document.forms[0]["formUserPmsManager:selRoleId"].value = retval;
       return true;
   }

   function queryByUserName() {
       var personName = document.forms[0]["formUserPmsManager:condiValue"].value;
       if (personName == null || personName == "") {
           alert('�������ѯ����');
           return false;
       }

       return true;
   }
   function  portalAssign(){
       var chitem = document.forms(0).selectItem;
       if (chitem == null) return;
       var chklen = 0;
       var perid;
       //  debugger;
       if (chitem.length == null) {
           perid = chitem.value;
       } else {
           for (i = 0; i < chitem.length; i++) {
               if (chitem[i].checked)
               {
                   perid = chitem[i].value;
                   chklen++;
               }
           }
           if (chklen > 1) {
               alert('��ѡ�񵥸��û���');
               return false;
           }
       }
       if (perid == null) {
           alert('����ѡ���û���');
           return false;
       }

       showx = event.screenX - event.offsetX - 250;
       showy = event.screenY - event.offsetY + 18;

       retval = window.showModalDialog("/user/UserPortalList.jsf?userId=" + perid, "", "dialogWidth:315px; dialogHeight:410px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
       if (retval!="" && retval!=null){
           document.forms[0]["formUserPmsManager:selRoleId"].value = retval;
           return true;
       }
       else{
           return false;
       }
   }
   function singleAssign() {
       var chitem = document.forms(0).selectItem;
       if (chitem == null) return;
       var chklen = 0;
       var perid;
       //  debugger;
       if (chitem.length == null) {
           perid = chitem.value;
       } else {
           for (i = 0; i < chitem.length; i++) {
               if (chitem[i].checked)
               {
                   perid = chitem[i].value;
                   chklen++;
               }
           }
           if (chklen > 1) {
               alert('��ѡ�񵥸��û���');
               return false;
           }
       }
       if (perid == null) {
           alert('����ѡ���û���');
           return false;
       }

       showx = event.screenX - event.offsetX - 250;
       showy = event.screenY - event.offsetY + 18;

       retval = window.showModalDialog("/user/SingleSelRoleList.jsf?userId=" + perid, "", "dialogWidth:315px; dialogHeight:410px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
       if (retval!="" && retval!=null){
           document.forms[0]["formUserPmsManager:selRoleId"].value = retval;
           return true;
       }
       else{
           return false;
       }
   }

   function singleSelfAssign() {
       var chitem = document.forms(0).selectItem;
       if (chitem == null) return;
       var chklen = 0;
       var perid;
       //  debugger;
       if (chitem.length == null) {
           perid = chitem.value;
       } else {
           for (i = 0; i < chitem.length; i++) {
               if (chitem[i].checked)
               {
                   perid = chitem[i].value;
                   chklen++;
               }
           }
           if (chklen > 1) {
               alert('��ѡ�񵥸��û���');
               return false;
           }
       }
       if (perid == null) {
           alert('����ѡ���û���');
           return false;
       }

       showx = event.screenX - event.offsetX - 250;
       showy = event.screenY - event.offsetY + 18;

       retval = window.showModalDialog("/user/SingleSelSelf.jsf?userId=" + perid, "", "dialogWidth:315px; dialogHeight:410px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
       if (retval!="0" && retval!=null){
           document.forms[0]["formUserPmsManager:selRoleId"].value = retval;
           return true;
       }
       else{
           return false;
       }
   }

   function agentAssign() {
       var chitem = document.forms(0).selectItem;
       if (chitem == null) return;
       var chklen = 0;
       var perid;
       //  debugger;
       if (chitem.length == null) {
           perid = chitem.value;
       } else {
           for (i = 0; i < chitem.length; i++) {
               if (chitem[i].checked)
               {
                   perid = chitem[i].value;
                   chklen++;
               }
           }
           if (chklen > 1) {
               alert('��ѡ�񵥸��û���');
               return false;
           }
       }
       if (perid == null) {
           alert('����ѡ���û���');
           return false;
       }
       showx = event.screenX - event.offsetX - 250;

       showy = event.screenY - event.offsetY + 18;

       retval = window.showModalDialog("/user/agentList.jsf?personId=" + perid, "", "dialogWidth:315px; dialogHeight:410px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
       return false;
   }

   function viewRoleList() {
       var chitem = document.forms(0).selectItem;
       if (chitem == null) return;
       var chklen = 0;
       var perid;
       //  debugger;
       if (chitem.length == null) {
           perid = chitem.value;
       } else {
           for (i = 0; i < chitem.length; i++) {
               if (chitem[i].checked)
               {
                   perid = chitem[i].value;
                   chklen++;
               }
           }
           if (chklen > 1) {
               alert('��ѡ�񵥸��û���');
               return false;
           }
       }
       if (perid == null) {
           alert('����ѡ���û���');
           return false;
       }
       //debugger;
       showx = event.screenX - event.offsetX - 250;
       // + deltaX;
       showy = event.screenY - event.offsetY + 18;
       // + deltaY;
       retval = window.showModalDialog("/pages/user/UserRoleList.jsf?userId=" + perid, "", "dialogWidth:200px; dialogHeight:250px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
       //debugger;
       return false;
   }
    
</script>


