<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
    <script language=javascript>
        function checkIds(persId) {
            if (checkMutilSelect(persId)) {
                if (confirm('确定要删除所选项目吗？'))
                {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert("请选择项目！")
                return false;
            }
        }
    </script>

<h:form id="form1">
    <x:saveState value="qry_qryModuleSettingBB"></x:saveState>
    <c:verbatim>
    <table height=98% width=98%>
    <tr><td height=8>
    </c:verbatim>
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
           <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value=" 设置总经理人员查询对应的查询方案 "/>
            </h:panelGroup>
        </h:panelGrid>
<c:verbatim>
    </td></tr>

    <tr><td height=8>
</c:verbatim>
        <h:selectOneMenu id="operate" value="#{qry_qryModuleSettingBB.oper}">
          <c:selectItems value="#{qry_qryModuleSettingBB.zjlList}"></c:selectItems>
        </h:selectOneMenu>

        <h:selectOneMenu id="qry" value="#{qry_qryModuleSettingBB.qry}">
        <c:selectItems value="#{qry_qryModuleSettingBB.zjlQryList}"></c:selectItems>
        </h:selectOneMenu>
        <h:commandButton value="保存" styleClass="button01" action="#{qry_qryModuleSettingBB.saveZJL}"></h:commandButton>
        <h:commandButton value="删除" styleClass="button01"
                     onclick="if(checkIds(document.form1.Id)){pageCodeExchange(form1);return true;}else return false;"
                     action="#{qry_qryModuleSettingBB.delete}"></h:commandButton>
        <h:commandButton value="返回" styleClass="button01" type="button" onclick="window.close()"></h:commandButton>
<c:verbatim>
    </td></tr>

    <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
 </c:verbatim>
        <h:dataTable var="list" styleClass="table03" align="center" width="95%"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle"
                     value="#{qry_qryModuleSettingBB.zjlSetList}">
            <h:column>
                <f:facet name="header">
                    <f:verbatim escape="false">
                        <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.Id)"/>
                    </f:verbatim>
                </f:facet>
                <f:verbatim escape="false">
                    <input type="checkbox" name="Id" value="</f:verbatim><h:outputText value="#{list.contentID}"/><f:verbatim>">
                </f:verbatim>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="人员" styleClass="td03"/></f:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="查询方案" styleClass="td03"/></f:facet>
                <h:outputText value="#{list.qryName}"/>
            </h:column>
        </h:dataTable>
<c:verbatim>
        </div>
    </td></tr>
    </table>
</c:verbatim>
</h:form>
