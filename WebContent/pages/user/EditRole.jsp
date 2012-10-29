<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


    <script type="text/javascript">
        function getRoleInfo() {
            form = document.forms[0];
            if (form["chkUnitLeader"].checked && form["chkDeptLeader"].checked) {
                alert('不能同时选择机构领导和部门领导！')
                return false;
            }
            if (form["chkUnitLeader"].checked && form["chkHrLeader"].checked) {
                alert('不能同时选择机构领导和HR领导！')
                return false;
            }
            if (form["chkHrLeader"].checked && form["chkDeptLeader"].checked) {
                alert('不能同时选择HR领导和部门领导！')
                return false;
            }
            if (form["chkSysOper"].checked)
                form["formAddRole:sysOper"].value = "1";
            else
                form["formAddRole:sysOper"].value = "0";

            if (form["chkBusinessUser"].checked)
                form["formAddRole:businessUser"].value = "1";
            else
                form["formAddRole:businessUser"].value = "0";

            if (form["chkUnitLeader"].checked)
                form["formAddRole:unitLeader"].value = "1";
            else
                form["formAddRole:unitLeader"].value = "0";

            if (form["chkDeptLeader"].checked)
                form["formAddRole:deptLeader"].value = "1";
            else
                form["formAddRole:deptLeader"].value = "0";

            if (form["chkHrLeader"].checked)
                form["formAddRole:hrLeader"].value = "1";
            else
                form["formAddRole:hrLeader"].value = "0";

            return forsubmit(document.forms(0));
        }
        function setCheckBoxInfo() {
            form = document.forms[0];
            if (form["formAddRole:sysOper"].value == "1")
                form["chkSysOper"].checked = true;

            if (form["formAddRole:businessUser"].value == "1")
                form["chkBusinessUser"].checked = true;

            if (form["formAddRole:unitLeader"].value == "1")
                form["chkUnitLeader"].checked = true;

            if (form["formAddRole:deptLeader"].value == "1")
                form["chkDeptLeader"].checked = true;
            if (form["formAddRole:hrLeader"].value == "1")
                form["chkHrLeader"].checked = true;
        }
    </script>

<h:form id="formAddRole">
    <h:inputHidden id="pageInit" value="#{user_editRoleBB.pageInit}"/>
    <h:panelGrid columns="1" width="97%" cellpadding="0" align="center"
                    cellspacing="0" border="0" >
        <h:inputHidden id="roleId" value="#{user_editRoleBB.roleId}"/>
        <h:inputHidden id="sysOper" value="#{user_editRoleBB.sysOper}"/>
        <h:inputHidden id="deptLeader" value="#{user_editRoleBB.deptLeader}"/>
        <h:inputHidden id="unitLeader" value="#{user_editRoleBB.unitLeader}"/>
        <h:inputHidden id="hrLeader" value="#{user_editRoleBB.cho}"/>
        <h:inputHidden id="businessUser" value="#{user_editRoleBB.businessUser}"/>
        <h:inputHidden value="#{user_editRoleBB.creator}"/>
        <h:inputHidden value="#{user_editRoleBB.createTime}"/>
        <h:inputHidden id="editStatus" value="#{user_editRoleBB.editStatus}"/>
        <h:inputHidden id="lastLevelManageFlag" value="#{user_editRoleBB.lastLevelManageFlag}"/>
        <f:verbatim>
            <br/>
        </f:verbatim>
        <h:panelGrid columns="2"
                         width="97%"
                        cellpadding="0" border="1" align="center"
                         styleClass="table03" columnClasses="td_form01,td_form02">

            <h:outputText value="角色名称 "/>
            <h:inputText value="#{user_editRoleBB.roleName}" alt="角色名称|0|s|50" size="40" styleClass="input"/>

            <h:outputText value="机构权限设置类型"/>
            <h:selectOneMenu value="#{user_editRoleBB.processunitid}">
                <c:selectItems value="#{user_editRoleBB.unitList}"></c:selectItems>
            </h:selectOneMenu>

            <h:outputText value="角色身份 "/>
            <h:panelGroup>
                <f:verbatim>
                    <input id="chkBoxSysOper" type="checkbox" name="chkSysOper">IT管理员</input>
                    <input type="checkbox" name="chkBusinessUser">HR专业人员</input>
                    <input type="checkbox" name="chkUnitLeader">机构领导</input>
                    <input type="checkbox" name="chkDeptLeader">部门领导</input>
                    <input type="checkbox" name="chkHrLeader">HR领导</input>
                </f:verbatim>
            </h:panelGroup>

            <h:outputText value="描述"/>
            <h:inputTextarea cols="50" rows="5" value="#{user_editRoleBB.description}"/>

            <h:outputText value="是否禁用"/>
            <h:selectOneRadio value="#{user_editRoleBB.forbidden}">
                <c:selectItem itemValue="1" itemLabel="是"></c:selectItem>
                <c:selectItem itemValue="0" itemLabel="否"></c:selectItem>
            </h:selectOneRadio>

           <h:outputText value="是否用作模板"/>
           <h:selectOneRadio value="#{user_editRoleBB.template}">
               <c:selectItem itemValue="1" itemLabel="是"></c:selectItem>
               <c:selectItem itemValue="0" itemLabel="否"></c:selectItem>
           </h:selectOneRadio>
        </h:panelGrid>


        <h:panelGrid columns="2" width="20%" cellpadding="0"
                        align="center" border="0">
            <h:commandButton value="保 存" onclick="return getRoleInfo()" action="#{user_editRoleBB.saveRoleInfo}"
                             styleClass="button01"/>
            <h:commandButton value="返 回" action="rolelist" styleClass="button01">
            </h:commandButton>
        </h:panelGrid>
    </h:panelGrid>
    <script type="text/javascript">
        if (document.forms[0]["formAddRole:editStatus"].value == "true")
            setCheckBoxInfo();

        // 如果是最底层管理员，禁止建系统管理员角色
        if (document.forms[0]["formAddRole:lastLevelManageFlag"].value == "1")
            document.all("chkBoxSysOper").disabled = true;
    </script>
</h:form>
