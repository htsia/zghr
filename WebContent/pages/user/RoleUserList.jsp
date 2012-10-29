<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function confirmDeleteUser(){
        var selcheck = document.all("selectItem");
        var ischeck=false;
        if(checkMutilSelect(selcheck)){
            return confirm("确实要移出这些用户吗？");
        }else{
            alert("请先选择要移出的用户！");
            return false;
        }
    }
</script>

<h:form id="formRoleUserList">
   <h:inputHidden id="roleId" value="#{user_roleUserListBB.roleId}"/>
   <h:inputHidden id="PageLoad" value="#{user_roleUserListBB.pageInit}"></h:inputHidden>
   <c:verbatim>
   <table width=98% height=98% cellspanning=0 cellspacing=0 align="center">
        <tr><td height=8 class="td_title">
             <font bold="true">分配<font color="red">
</c:verbatim>
             <h:outputText value="#{user_roleUserListBB.roleName}"/>
<c:verbatim>
             </font>角色的所有用户</font>

        </td>
        <td align="right" class="td_title">
</c:verbatim>
             <h:commandButton action="#{user_roleUserListBB.deleteRoleUser}" onclick="return confirmDeleteUser()" value="移 出"  styleClass="button01"></h:commandButton>
             <h:commandButton action="rolelist" value="返 回" styleClass="button01"></h:commandButton>
<c:verbatim>
        </td></tr>
        <tr>
            <td height=8></td>
        </tr>
        
        <tr><td colspan=2>
            <div style='width:100%;height:100%;overflow:auto' id=datatable>
 </c:verbatim>
              <x:dataTable value="#{user_roleUserListBB.userList}" var="list" width="100%" headerClass="td_top tr_fixrow" rowClasses="td_middle"
                         styleClass="table03"  id="dateList"  columnClasses="td_middle_center,td_middle_center,td_middle" rowIndexVar="index" 
                         border="0">
                  <h:column >
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox" name="all" onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                       <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                        <h:outputText value="#{list.personId}"/>
                        <f:verbatim escape="false">"/></div></f:verbatim>
                </h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="序号" />
					</f:facet>
					<h:outputText value="#{index+1}"></h:outputText>
				</h:column>
                  <h:column>
                       <f:facet name="header">
                           <h:outputText value="登录名"/>
                       </f:facet>
                       <h:outputText escape="false" value="#{list.loginName}"/>
                   </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="姓名"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.name}"/>
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
                        <h:outputText value="出生年月"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.birth}"/>
                </h:column>        <h:column>
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
                    <h:outputText value="岗位"/>
                </f:facet>
                <h:outputText escape="false" value="#{list.postId}"/>
            </h:column>
             <h:column>
                <f:facet name="header">
                    <h:outputText value="系统管理员"/>
                </f:facet>
                <h:outputText escape="false" value="#{list.sysOper}"/>
            </h:column>
              <h:column>
                <f:facet name="header">
                    <h:outputText value="业务用户"/>
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

             </x:dataTable>
<c:verbatim>
            </div>
        </td></tr>
    </table>
</c:verbatim>
</h:form>

<script type="text/javascript">
   setDataTableOver("formRoleUserList:dateList");
</script>
