<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function doPopUpRoleInfoDlg() {
        retval = window.showModalDialog("/pages/user/SelRoleList.jsf", "", "dialogWidth:315px; dialogHeight:410px; center:center; status:0;resizable:no");
        // retval = "角色ID:管理员标示，角色ID:管理员标示...."
        if (retval == null || retval == ""){
            return false;
        }
        document.forms[0]["formRoleList:selRoleId"].value = retval;
        return true;
    }
</script>
<x:saveState value="#{user_roleManageBB}"/>
<h:form id="formRoleList">
    <h:inputHidden id="pageInit" value="#{user_roleManageBB.initOperateRole}"/>
    <h:inputHidden value="#{user_roleManageBB.operID}"/>
    <h:inputHidden id="selRoleId" value="#{user_roleManageBB.sourceRoleId}"/>
    <c:verbatim>
    <table height=98% width=98% >
    <tr><td height=8>
        <strong>拥有该操作权限角色：</strong>
    </td>
        <td>
    </c:verbatim>
        <h:commandButton value="增加" styleClass="button01" onclick="return doPopUpRoleInfoDlg();" action="#{user_roleManageBB.addOperateRoles}"></h:commandButton>
        <h:commandButton value="删除" onclick="return checkBatchDelete('selectItem')" styleClass="button01" action="#{user_roleManageBB.deleteOperateRoles}"></h:commandButton>
    <c:verbatim>
        </td>
    </tr>

    <tr><td colspan="2">
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
        <h:dataTable id="tbl_roleinfolist" align="center" value="#{user_roleManageBB.roleinfos}" var="list" width="97%"
               styleClass="table03" headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center">
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
                    <h:outputText value="角色名称"/>
                </f:facet>
                <h:graphicImage value="/images/common/unvalidate.gif" rendered="#{list.forbidden=='1'}"></h:graphicImage>
                <h:outputText escape="false" value="#{list.roleName}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="上级角色"/>
                </f:facet>
                <h:outputText escape="false" value="#{list.creatorName}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="机构权限类型"/>
                </f:facet>
                <h:panelGrid align="center">
                    <h:outputText escape="false" value="#{list.processunitid}"/>
                </h:panelGrid>
            </h:column>

            <h:column>
               <f:facet name="header">
                   <h:outputText value="禁用"/>
               </f:facet>
               <h:selectOneRadio value="#{list.forbidden}" disabled="true">
                   <c:selectItem itemValue="1" itemLabel="是"></c:selectItem>
                   <c:selectItem itemValue="0" itemLabel="否"></c:selectItem>
               </h:selectOneRadio>
           </h:column>

          </h:dataTable>
<c:verbatim>
        </div>
    </td></tr>
    </table>
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("formRoleList:tbl_roleinfolist");
</script>


