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
           <h:outputText value="当前人员类别:#{user_userPmsManagerBB.personTypeDes}"></h:outputText>
<f:verbatim>
       </td>
   </tr>

   <tr>
    <td height=8>
</f:verbatim>
        <h:selectOneMenu id="condiType" value="#{user_userPmsManagerBB.condiType}">
            <f:selectItem itemValue="personName" itemLabel="姓名或员工编号"></f:selectItem>
            <f:selectItem itemValue="postType" itemLabel="岗位类别"></f:selectItem>
         </h:selectOneMenu>
        <h:inputText id="condiValue" styleClass="input" value="#{user_userPmsManagerBB.condiValue}" size="20"
                     onkeypress="enterKeyDown('formUserPmsManager:btnSearch')"></h:inputText>
        <h:commandButton id="btnSearch" value="查 询" action="#{user_userPmsManagerBB.doQuery}"
                         onclick="return queryByUserName()" styleClass="button01"/>
<f:verbatim>
    </td>
    <td align="right">
</f:verbatim>
            <h:outputText value="共#{user_userPmsManagerBB.pagevo.totalPage}页"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="每页有#{user_userPmsManagerBB.pagevo.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="当前为第#{user_userPmsManagerBB.pagevo.currentPage}页"></h:outputText>
            <h:commandButton value="首页" action="#{user_userPmsManagerBB.first}" styleClass="button01"></h:commandButton>
            <h:commandButton value="上页" action="#{user_userPmsManagerBB.pre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="下页" action="#{user_userPmsManagerBB.next}" styleClass="button01"></h:commandButton>
            <h:commandButton value="尾页" action="#{user_userPmsManagerBB.last}" styleClass="button01"></h:commandButton>
<f:verbatim>
    </td>
    </tr>

    <tr>
    <td height=8 align="right" colspan="2">
</f:verbatim>
        <h:commandButton value="门户单个授权" onclick="return portalAssign();" type="button"      styleClass="button01"/>
        <h:commandButton value="门户批量授权" onclick="return portalGroupAssign();"  styleClass="button01" action="#{user_userPmsManagerBB.batchAssignPortal}"/>
        <h:commandButton value="自助业务功能授权" onclick="return singleSelfAssign()" action="#{user_userPmsManagerBB.assignSelfOper}"
                         styleClass="button01"/>
        <h:commandButton value="设置代理" onclick="return agentAssign()" type="button"  styleClass="button01" rendered="#{user_userPmsManagerBB.canAgent}"/>
        <h:commandButton value="单个授权" onclick="return singleAssign()" action="#{user_userPmsManagerBB.assignRole}"
                         styleClass="button01"/>
        <h:commandButton value="批量授权" onclick="return doPopUpRoleInfoDlg()" action="#{user_userPmsManagerBB.assignRole}"
                         styleClass="button01"/>
        <h:commandButton value="清除角色" action="#{user_userPmsManagerBB.clearRole}" onclick="return confirmClear()"
                         styleClass="button01"/>
        <h:commandButton value="查看角色" onclick="return viewRoleList()" action="" styleClass="button01"/>
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
                <h:outputText value="姓名"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.name}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText value="登录名"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.loginName}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText value="状态"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.status}"/>
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText value="性别"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.sex}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText value="人员类别"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.personType}"/>
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText value="机构"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.orgId}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText value="部门"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.deptId}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText value="管理员"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.sysOper}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText value="HR人员"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.businessUser}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText value="机构领导"/>
            </f:facet>
            <h:outputText escape="false" value="#{list.unitLeader}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText value="部门领导"/>
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
            <f:facet name="header"><h:outputText value="操作"/></f:facet>
            <h:panelGrid align="center" cellspacing="2" columns="1">
                <h:commandButton styleClass="button01" action="setpms" value="查看权限">
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
           alert('列表中没有用户！');
           return false;
       }
       if (chitem.length == null) {
           perid = chitem.value;
           if (perid == null) {
               alert('请选择要清除权限的用户！');
               return false;
           }
       } else {
           var chklen = 0;
           for (i = 0; i < chitem.length; i++) {
               if (chitem[i].checked)
                   chklen++;
           }
           if (chklen == 0) {
               alert('请选择要清除权限的用户！');
               return false;
           }
       }
       return confirm("确实要清除吗？")
   }

   function doPopUpRoleInfoDlg() {
       showx = event.screenX - event.offsetX - 250;
       showy = event.screenY - event.offsetY + 18;
       var chitem = document.forms(0).selectItem;
       if (chitem == null) {
           alert('列表中没有用户！');
           return false;
       }
       if (chitem.length == null) {
           perid = chitem.value;
           if (perid == null) {
               alert('请选择要分配的用户！');
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
               alert('请选择要分配的用户！');
               return false;
           }
       }
       retval = window.showModalDialog("/pages/user/SelRoleList.jsf", "", "dialogWidth:315px; dialogHeight:410px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
       // retval = "角色ID:管理员标示，角色ID:管理员标示...."
       if (retval == null || retval == ""){
           return false;
       }
       var items = retval.split(",");
       for (i = 0; i < items.length; i++) {
           var items2 = items[i].split(":");
           //判断，如果选择了管理员，则只允许付给一个用户
           if (items2.length > 1)
               if (items2[1] == "1" && chklen > 1)
                   alert(' 一个管理员角色只允许分配给一个用户')
       }
       document.forms[0]["formUserPmsManager:selRoleId"].value = retval;
       return true;
   }

   function portalGroupAssign() {
       showx = event.screenX - event.offsetX - 250;
       showy = event.screenY - event.offsetY + 18;
       var chitem = document.forms(0).selectItem;
       if (chitem == null) {
           alert('列表中没有用户！');
           return false;
       }
       if (chitem.length == null) {
           perid = chitem.value;
           if (perid == null) {
               alert('请选择要分配的用户！');
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
               alert('请选择要分配的用户！');
               return false;
           }
       }
       retval = window.showModalDialog("/user/SelPortalList.jsf", "", "dialogWidth:315px; dialogHeight:410px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
       // retval = "角色ID:管理员标示，角色ID:管理员标示...."
       if (retval == null || retval == ""){
           return false;
       }
       document.forms[0]["formUserPmsManager:selRoleId"].value = retval;
       return true;
   }

   function queryByUserName() {
       var personName = document.forms[0]["formUserPmsManager:condiValue"].value;
       if (personName == null || personName == "") {
           alert('请输入查询条件');
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
               alert('请选择单个用户！');
               return false;
           }
       }
       if (perid == null) {
           alert('请先选泽用户！');
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
               alert('请选择单个用户！');
               return false;
           }
       }
       if (perid == null) {
           alert('请先选泽用户！');
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
               alert('请选择单个用户！');
               return false;
           }
       }
       if (perid == null) {
           alert('请先选泽用户！');
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
               alert('请选择单个用户！');
               return false;
           }
       }
       if (perid == null) {
           alert('请先选泽用户！');
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
               alert('请选择单个用户！');
               return false;
           }
       }
       if (perid == null) {
           alert('请先选泽用户！');
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


