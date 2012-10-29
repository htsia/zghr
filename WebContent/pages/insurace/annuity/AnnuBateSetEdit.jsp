<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">

        function doCheck(){
            if (document.all('form1:b742701')==''){
                alert("请输入年度!")
                return false;
            }
            return true;
        }
    </script>

<x:saveState value="#{annu_BaseBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{annu_BaseBB.initEdit}"/>
    <h:panelGrid align="center" width="380">
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存"   onclick="return doCheck();" action="#{annu_BaseBB.saveBase}"/>
            <h:commandButton value="取消" styleClass="button01" type="button" onclick="window.close();"></h:commandButton>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText escape="false" value="<strong>当前年度:</strong>"/>
            <h:selectOneMenu id="b742701" value="#{annu_BaseBB.editbo.b742701}">
                  <c:selectItem itemValue="2010" itemLabel="2010年度"></c:selectItem>
                  <c:selectItem itemValue="2011" itemLabel="2011年度"></c:selectItem>
                  <c:selectItem itemValue="2012" itemLabel="2012年度"></c:selectItem>
                  <c:selectItem itemValue="2013" itemLabel="2013年度"></c:selectItem>
                  <c:selectItem itemValue="2014" itemLabel="2014年度"></c:selectItem>
            </h:selectOneMenu>
    
            <h:outputText escape="false" value="<strong>工资总额:</strong>"/>
            <h:inputText value="#{annu_BaseBB.editbo.b742702}"></h:inputText>

            <h:outputText escape="false" value="<strong>岗位工资总额:</strong>"/>
            <h:panelGroup>
                <h:inputText value="#{annu_BaseBB.editbo.b742703}"></h:inputText>
                <h:commandButton value="提取" styleClass="button01" action="#{annu_BaseBB.take}"></h:commandButton>
            </h:panelGroup>

            <h:outputText escape="false" value="<strong>年金系数:</strong>"/>
            <h:inputText value="#{annu_BaseBB.editbo.b742704}"></h:inputText>
        </h:panelGrid>
     </h:panelGrid>
</h:form>
