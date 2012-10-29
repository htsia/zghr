<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script language="javascript">
        function chkNull() {
            if (document.getElementById("form1:code").value == "" || document.getElementById("form1:item").value == "") {
                alert("请选择相关项目！")
                return false;
            }
            else {
                return true
            }
        }
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

</head>

<body>
<x:saveState value="#{wage_wageItemSetBB}"/>
<h:inputHidden value="#{wage_wageItemSetBB.pageInit}"/>
<h:panelGrid width="98%" align="center" columnClasses="td_title" bgcolor="#FFFFFF" cellpadding="0"
                cellspacing="0">
    <h:outputText value=" 人力成本归结"/>
</h:panelGrid>
<f:verbatim><br></f:verbatim>
<h:panelGrid columns="4" width="95%" cellpadding="0" align="center" border="0">
    <h:outputText value="发薪单位：#{wage_wageItemSetBB.unitName}"/>
    <%
    //< h:multlink value="3" paneLable="设置机构归结项,设置人员归结项,设置岗位归结项"
    //               paneLink="SetDeptItem.jsf,SetPersonItem.jsf,SetPostItem.jsf"
      //             align="center" width="100%"/>
                   %>
</h:panelGrid>
<h:form id="form1">
    <h:panelGrid width="95%" align="center"  border="0"
                    columns="2">
        <h:panelGrid align="left" width="100%" cellpadding="0" cellspacing="2" columns="5">
            <h:outputText value="指标项 "/>
            <h:selectOneMenu id="item" value="#{wage_wageItemSetBB.costFieldBo.costField}">
                <f:selectItems value="#{wage_wageItemSetBB.postItemList}"/>
            </h:selectOneMenu>
            <h:outputText value="人力成本项 "/>
            <h:selectOneMenu id="code" value="#{wage_wageItemSetBB.costFieldBo.costType}">
                <f:selectItems value="#{wage_wageItemSetBB.codeList}"/>
            </h:selectOneMenu>
            <h:commandButton id="set" styleClass="button01" value="设置"
                             onclick="if(chkNull())return true;else return false;"
                             action="#{wage_wageItemSetBB.addPostItem}"/>
        </h:panelGrid>
        <h:commandButton value="删除" styleClass="button01"
                         onclick="if(checkIds(document.form1.Id))return true;else return false;"
                         action="#{wage_wageItemSetBB.deleteItem}"/>
    </h:panelGrid>
    <f:verbatim><br></f:verbatim>
    <h:dataTable styleClass="table03" align="center" width="95%"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center"
                 value="#{wage_wageItemSetBB.postBos}"
                 var="list" border="1">
        <h:column>
            <f:facet name="header">
                <f:verbatim escape="false">
                    <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.Id)"/>
                </f:verbatim>
            </f:facet>
            <f:verbatim escape="false">
                <input type="checkbox" name="Id" value="</f:verbatim><h:outputText value="#{list.costFieldId}"/><f:verbatim>">
            </f:verbatim>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="指标项" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.fieldName}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="人力成本项" styleClass="td03"/></f:facet>
            <h:outputText value="#{list.costName}"/>
        </h:column>
    </h:dataTable>
</h:form>
</body>
</html>