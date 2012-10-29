<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   <script type="text/javascript">
    	function checkData(){
        	if(document.all("form1:dirName").value==null||document.all("form1:dirName").value==""){
            	alert("项目名称不能为空！");
            	return false;
        	}
        	if(document.all("form1:seq").value==null||document.all("form1:seq").value==""){
            	alert("序号不能为空！");
            	return false;
        	}
        	if(document.all("form1:totalScore").value==null||document.all("form1:totalScore").value==""){
            	alert("总分不能为空！");
            	return false;
        	}
        	return true;
    	}
   </script>   
  <x:saveState value="#{titleContentSetBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{titleContentSetBB.initDirEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 职称管理 -> 评审内容设置"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="序号"></h:outputText>
               <h:inputText  id="seq" value="#{titleContentSetBB.dirbo.seq}"></h:inputText>
               <h:outputText value="项目名称"></h:outputText>
               <h:inputText  id="dirName" value="#{titleContentSetBB.dirbo.dirName}"></h:inputText>
               <h:outputText value="总分"></h:outputText>
               <h:inputText  id="totalScore" value="#{titleContentSetBB.dirbo.totalScore}"></h:inputText>
               <h:outputText value="优先级"></h:outputText>
               <h:inputText  id="priority" value="#{titleContentSetBB.dirbo.priority}"></h:inputText>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="保存" id="save" styleClass="button01"  action="#{titleContentSetBB.saveDir}" onclick="return checkData();"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>