<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function doOK(){
            window.returnValue=document.all('form1:writeDiffField').value+"|"+document.all('form1:writeDiffMode').value+"|"+document.all('form1:writeDiffTimes').value;
            window.close();
        }
        function doRet(){
            window.returnValue="";
            window.close();
        }

    </script>

  <x:saveState value="#{wage_diffBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{wage_diffBB.writeDiff}"/>
      <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="回填字段"></h:outputText>
            <h:selectOneMenu id="writeDiffField" value="#{wage_diffBB.writeDiffField}">
                <c:selectItems value="#{wage_diffBB.writeDiffFieldList}"></c:selectItems>
            </h:selectOneMenu>

             <h:outputText value="回填倍数"></h:outputText>
             <h:inputText id="writeDiffTimes" value="#{wage_diffBB.writeDiffTimes}"></h:inputText>

             <h:outputText value="回填方法"></h:outputText>
             <h:selectOneMenu id="writeDiffMode" value="#{wage_diffBB.writeDiffMode}">
                 <c:selectItem itemLabel="覆盖" itemValue="0"></c:selectItem>
                 <c:selectItem itemLabel="和已有值相加" itemValue="1"></c:selectItem>
             </h:selectOneMenu>

             <h:outputText value="操作"></h:outputText>
             <h:panelGroup>
                 <h:commandButton value="保存" type="button" styleClass="button01" onclick="doOK();"></h:commandButton>
                 <h:commandButton value="返回" type="button" styleClass="button01" onclick="doRet();"></h:commandButton>
             </h:panelGroup>
      </h:panelGrid>
  </h:form>
