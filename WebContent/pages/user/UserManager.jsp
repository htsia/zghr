<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"  %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script language=javascript src="/pages/user/usermanager.js"></script>
<x:saveState value="#{user_userManagerBB}"/>
<h:form id="formUserManager">
    <h:commandButton id="doQuery" action="#{user_userManagerBB.doQuery}" style="display:none"/>
    <h:inputHidden id="queryType" value="#{user_userManagerBB.queryType}"/>
    <h:inputHidden id="selOrgId" value="#{user_userManagerBB.selOrgId}"/>
    <h:inputHidden id="pageInit" value="#{user_userManagerBB.pageInit}"/>
    <h:inputHidden id="orgId" value="#{user_userManagerBB.orgId}"/>
    <h:inputHidden id="personType" value="#{user_userManagerBB.personType}"/>

    <f:verbatim>
    <table width="97%" height="98%" cellpadding="0" align="center"  cellspacing="0" border="0" >
        <tr><td height=8>
</f:verbatim>
            <h:panelGrid columns="1" width="100%" cellpadding="0" align="right" border="0" >
                <h:outputText value="当前人员类别:#{user_userManagerBB.personTypeDes}"></h:outputText>

                <h:panelGrid columns="6">
                    <h:panelGroup>
                        <h:outputText value="姓名或员工编号"></h:outputText>
                        <h:inputText id="condiValue" styleClass="input" value="#{user_userManagerBB.condiValue}" size="20" onkeypress="enterKeyDown('formUserManager:btnSearch')"></h:inputText>
                        <h:commandButton id="btnSearch" value="查 询" action="#{user_userManagerBB.queryUserList}" onclick="return queryByUserName()" styleClass="button01"/>
                    </h:panelGroup>
                    <h:selectOneRadio value="#{user_userManagerBB.showType}" onclick="submit()" valueChangeListener="#{user_userManagerBB.changeShowType}">
                        <c:selectItem itemLabel="显示全部" itemValue="2"></c:selectItem>
                        <c:selectItem itemLabel="显示启用" itemValue="1"></c:selectItem>
                        <c:selectItem itemLabel="显示禁用" itemValue="0"></c:selectItem>
                    </h:selectOneRadio>
                    <h:commandButton value="导出Excel" action="#{user_userManagerBB.downloadFile}" styleClass="button01"/>
                    <h:outputText value="   "></h:outputText>
                    <h:commandButton value="导入授权" type="button" styleClass="button01" onclick="importLicFile();" style="display:none"/>
                    <h:commandButton value="导入令牌" type="button" styleClass="button01" onclick="importTokenFile();" rendered="#{sys_commonInfoBB.enableOTP}"/>
                </h:panelGrid>

                <h:panelGrid align="left">
                    <h:panelGroup>
                        <h:commandButton value="启 用" action="#{user_userManagerBB.makeStatusOpen}" styleClass="button01"/>
                        <h:commandButton value="禁 用" action="#{user_userManagerBB.makeStatusBan}" styleClass="button01"/>
                        <h:commandButton value="允许管理" action="#{user_userManagerBB.makeCurrentLevelUser}" styleClass="button01"/>
                        <h:commandButton value="取消管理" action="#{user_userManagerBB.cancelCurrentLevelUser}" styleClass="button01"/>
                        <h:commandButton value="强制取消" action="#{user_userManagerBB.cancelUser}" rendered="#{user_userManagerBB.sysman}" styleClass="button01"/>
                        <h:commandButton value="修改自助级别"  action="#{user_userManagerBB.doQuery}" styleClass="button01" onclick="domodiLevel();"/>
                        <h:commandButton value="修改用户信息" onclick="return editUserInfo()" rendered="#{sys_commonInfoBB.modiUserMode=='1'}" action="#{user_userManagerBB.doQuery}" styleClass="button01"/>
                        <h:commandButton value="修改登录名" onclick="return editLoginName();" rendered="#{sys_commonInfoBB.modiUserMode=='2'}" action="#{user_userManagerBB.doQuery}" styleClass="button01"/>
                        <h:commandButton value="修改用户密码" onclick="return editUserPassword()" type="button" styleClass="button01" rendered="#{sys_commonInfoBB.enableModiPass}"/>
                        <h:commandButton value="登录需改密码" action="#{user_userManagerBB.setNextModi}" styleClass="button01" rendered="#{sys_commonInfoBB.enableModiPass}"/>
                        <h:commandButton value="发I型卡" onclick="return deployCard()" type="button" styleClass="button01" rendered="#{sys_commonInfoBB.enableLoginCard}"/>
                        <h:commandButton value="发动态口令卡" onclick="return deployOTPCard()"  rendered="#{sys_commonInfoBB.enableOTP}" action="#{user_userManagerBB.doQuery}" styleClass="button01" />
                    </h:panelGroup>
                </h:panelGrid>

                <h:panelGrid align="right" styleClass="locked_top">
                    <h:panelGroup>
                        <h:outputText value="共#{user_userManagerBB.pagevo.totalPage}页"></h:outputText>
                        <h:outputText value="  "></h:outputText>
                        <h:outputText value="每页有#{user_userManagerBB.pagevo.pageSize}"></h:outputText>
                        <h:outputText value="  "></h:outputText>
                        <h:outputText value="当前为第#{user_userManagerBB.pagevo.currentPage}页"></h:outputText>
                        <h:commandButton value="首页" action="#{user_userManagerBB.first}" styleClass="button01"></h:commandButton>
                        <h:commandButton value="上页" action="#{user_userManagerBB.pre}" styleClass="button01"></h:commandButton>
                        <h:commandButton value="下页" action="#{user_userManagerBB.next}" styleClass="button01"></h:commandButton>
                        <h:commandButton value="尾页" action="#{user_userManagerBB.last}" styleClass="button01"></h:commandButton>
                    </h:panelGroup>
                </h:panelGrid>

            </h:panelGrid>
<f:verbatim>
        </td></tr>

        <tr><td>
         <div style='width:100%;height:100%;overflow:auto' id=datatable>    
</f:verbatim>
              <h:dataTable value="#{user_userManagerBB.personList}" var="list" width="100%" id="dateList"
                    styleClass="table03" headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center">
                <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox"  name="all"
                                   onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                    <h:outputText value="#{list.personId}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
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
                          <h:outputText value="登录验证模式"/>
                      </f:facet>
                      <h:outputText escape="false" value="#{list.loginTypeDes}"/>
                  </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="人员类别"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.personType}"/>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="管理该用户的角色"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.belongRoleId}"/>
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
                        <h:outputText value="岗位类别"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.postType}"/>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="自助级别"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.infoLevel}"/>
                </h:column>
            </h:dataTable>
<f:verbatim>
         </div>
        </td></tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("formUserManager:dateList");
</script>
