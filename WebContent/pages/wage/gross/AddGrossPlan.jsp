<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<html>
<head>
    <title>新增计划</title>
    
</head>
<script type="text/javascript">
    function doSubmit(){
       if (document.all('form1:year').value==""){
           alert("请选择年度！");
           return false;
       }
       return true;
    }
</script>
<body>

<x:saveState value="#{wage_grossBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_grossBB.beginAdd}"/>
        <h:panelGrid columns="2" width="98%"  align="center"
                        styleClass="table03"  columnClasses="td_form01,td_form02" >
            <h:outputText value="年度 "/>
            <h:selectOneMenu id="year" value="#{wage_grossBB.wgb.grossYear}">
                <c:selectItem itemValue="2008" itemLabel="2008"/>
                <c:selectItem itemValue="2009" itemLabel="2009"/>
                <c:selectItem itemValue="2010" itemLabel="2010"/>
                <c:selectItem itemValue="2011" itemLabel="2011"/>
                <c:selectItem itemValue="2012" itemLabel="2012"/>
            </h:selectOneMenu>

            <h:outputText value="说明 "/>
            <h:inputTextarea cols="60" rows="4" value="#{wage_grossBB.wgb.grossDes}"/>
        </h:panelGrid>

        <h:panelGrid columns="3"  cellpadding="0" cellspacing="4" align="right">
             <h:commandButton id="submit" styleClass="button01" value="确定"
                             onclick="doSubmit();"
                             action="#{wage_grossBB.SavePlan}">
             </h:commandButton>
             <h:commandButton id="cancel" styleClass="button01" value="关闭"   onclick="window.close();"/>
        </h:panelGrid>
</h:form>
</body>
</html>