<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function forFlowFlag() {
            var setId = form1.all("form1:setId").value;
            if (setId != null && setId != "") {
                var flownew ;
                if (form1.all("form1:flowFlag")[1].checked) {
                    flownew = form1.all("form1:flowFlag")[1].value;
                    if (flow != flownew && flow !='00900') {
                        form1.all("form1:flowFlag")[2].checked = true;
                    }
                } else if (form1.all("form1:flowFlag")[2].checked) {
                    flownew = form1.all("form1:flowFlag")[2].value;
                    if (flow != flownew && flow !='00900') {
                        form1.all("form1:flowFlag")[1].checked = true;
                        alert("参与流程分配账套不能修改为不参与流程分配帐套");
                    }
                }
            }
        }

        function selectDeptInfoItem() {
            showx = event.screenX - event.offsetX - 150;
            showy = event.screenY - event.offsetY + 18;

            retval = window.showModalDialog("/pages/wage/base/DeptInfoItem.jsp", "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
            if (retval != null) {
                rs = retval.split("|");
                //debugger;
                document.all("form1:deptItem").value = rs[0];
                return true;
            }
            return false;
        }

        function selectInfoItem() {
            showx = event.screenX - event.offsetX - 150;
            showy = event.screenY - event.offsetY + 18;

            retval = window.showModalDialog("/pages/wage/base/DeptInfoItem.jsp", "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
            if (retval != null) {
                rs = retval.split("|");
                //debugger;
                document.all("form1:infoItem").value = rs[0];
                return true;
            }
            return false;
        }

    </script>

<x:saveState value="#{wage_setBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_setBB.initPersonPower}" id="initPersonPower"/>
    <h:inputHidden value="#{wage_setBB.wageset.unitId}" id="unitId"/>
    <h:inputHidden value="#{wage_setBB.wageset.setId}" id="setId"/>
    <c:verbatim><br></c:verbatim>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="账套名称"/>
            <h:inputText id="name" readonly="true" value="#{wage_setBB.wageset.name}" alt="账套名称|0" size="40" maxlength="40"/>

            <h:outputText value="账套描述"/>
            <h:inputTextarea id="desc" readonly="true" value="#{wage_setBB.wageset.desc}" cols="60" rows="5"/>

            <h:outputText escape="false" value="帐套只允许以下人员使用:<br>(不设置时不控制权限)"></h:outputText>
            <h:panelGrid width="98%" align="center">
                <h:panelGrid width="98%" align="right">
                    <h:panelGroup>
                        <h:selectOneMenu id="personID" value="#{wage_setBB.pid}" onchange="submit()" valueChangeListener="#{wage_deptBB.changePerson}">
                            <c:selectItems value="#{wage_setBB.personList}"></c:selectItems>
                        </h:selectOneMenu>

                        <h:commandButton value="增加"  action="#{wage_setBB.addPerson}" styleClass="button01"></h:commandButton>
                    </h:panelGroup>
                </h:panelGrid>
                
                <h:dataTable value="#{wage_setBB.operPersons}" var="list" align="center"
                             headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                             styleClass="table03" width="90%" >
                    <h:column>
                        <c:facet name="header"><h:outputText value="员工编码"/></c:facet>
                        <h:outputText value="#{list.personCode}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                        <h:outputText value="#{list.name}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="操作"/></c:facet>
                         <h:commandButton styleClass="button01" value="删除" action="#{wage_setBB.delPerson}">
                             <x:updateActionListener property="#{wage_setBB.pid}" value="#{list.personId}"/>
                         </h:commandButton>
                    </h:column>
               </h:dataTable>
            </h:panelGrid>
        </h:panelGrid>

        <h:panelGrid columns="2" align="center" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{wage_setBB.savePower}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="javascript:self.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
