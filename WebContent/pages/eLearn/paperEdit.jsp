<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

   
    <script type="text/javascript">
      function doCheck(){
          if (document.all('form1:name').value==null || document.all('form1:name').value==""){
              alert("请输入名称");
              return false;
          }
          return true;
      }
    </script>

<x:saveState value="#{eLearn_paperLibBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eLearn_paperLibBB.pageInit}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{eLearn_paperLibBB.SavePaper}"
                            onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="内容"/>
            <h:inputTextarea id="name" value="#{eLearn_paperLibBB.paperbo.name}" cols="60" rows="6"/>

            <h:outputText value="应用范围"></h:outputText>
            <h:selectOneMenu value="#{eLearn_paperLibBB.paperbo.orgID}">
                     <c:selectItems value="#{eLearn_paperLibBB.orgList}"></c:selectItems>
            </h:selectOneMenu>

            <h:outputText id="cap" value="描述"/>
            <h:inputTextarea id="lowvalue" rows="3" cols="60" value="#{eLearn_paperLibBB.paperbo.description}" />

            <h:outputText  value="总分"/>
            <h:inputText  value="#{eLearn_paperLibBB.paperbo.totalscore}" />

            <h:outputText  value="试卷类型"/>
            <h:selectOneRadio  value="#{eLearn_paperLibBB.paperbo.paperType}" disabled="#{eLearn_paperLibBB.paperbo.paperType!=null && eLearn_paperLibBB.paperbo.paperType!=''}">
                <c:selectItem itemValue="0" itemLabel="固定试卷"></c:selectItem>
                <c:selectItem itemValue="1" itemLabel="随机生成"></c:selectItem>
            </h:selectOneRadio>

            <h:outputText  value="是否启用"/>
            <h:selectOneRadio value="#{eLearn_paperLibBB.paperbo.isUse}">
                <c:selectItem itemValue="0" itemLabel="否"></c:selectItem>
                <c:selectItem itemValue="1" itemLabel="是"></c:selectItem>
            </h:selectOneRadio>

        </h:panelGrid>
    </h:panelGrid>
</h:form>

