<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language="javascript" src="<%=request.getContextPath()%>/js/tree2.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function selNode(){
        var selRoleId="";
        selRoleId=getAllSelectValue(document.forms(0).selectItem,",");
        if(selRoleId==""){
            alert('请选择角色！');
            return false;
        }
        window.returnValue = selRoleId;
        window.close();
        return false;

    }
    function winClose(){
        window.returnValue="";
        window.close();
        return false;
    }
</script>

<x:saveState value="#{sys_portalBB}"/>
<f:view>
<h:form id="formRoleList">
<f:verbatim>
    <div class='table03' style="width:100%;height:90%;overflow:auto" >
</f:verbatim>

<h:panelGrid columns="1" width="97%" cellpadding="0" align="center"  cellspacing="0" border="0" >
<h:dataTable value="#{sys_portalBB.portList}" var="list" width="97%"
             headerClass="td_top" rowClasses="td_middle"
             styleClass="table03"  border="1">
    <h:column>
        <f:facet name="header">
            <f:verbatim escape="false">
                <input type="checkbox" name="all"
                       onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
            </f:verbatim>
        </f:facet>
        <f:verbatim escape="false">
            <input type="checkbox" name="selectItem" value="</f:verbatim>
        <h:outputText value="#{list.itemID}"/>
        <f:verbatim escape="false">"/></f:verbatim>
    </h:column>

    <h:column>
        <f:facet name="header">
            <h:outputText value="应用名称"/>
        </f:facet>
        <h:outputText escape="false" value="#{list.itemName}"/>
    </h:column>
</h:dataTable>
</h:panelGrid>

    <f:verbatim>
      </div>
    </f:verbatim>

    <h:panelGrid columns="1" width="100%" cellpadding="0"  align="center" border="0">
        <h:panelGrid align="right" columns="2">
            <h:commandButton value="确 定" onclick="return selNode()"  styleClass="button01"/>
            <h:commandButton value="取 消" onclick="return winClose()" styleClass="button01"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>

</f:view>
