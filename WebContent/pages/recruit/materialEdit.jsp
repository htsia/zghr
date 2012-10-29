<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

      <script type="text/javascript">
      function checksave(){
    	  if(document.all('form1:materiallName').value=="" || document.all('form1:description').value=="")
          {
          alert("请填写完整信息！");
          return false;
          }
         return true;
      }
       	function forBack(form){
             window.close();
       }
      </script>
  
   <x:saveState value="#{recruit_materialeditBB}" />
  <h:form id="form1" enctype="multipart/form-data">
      <h:inputHidden id="initEdit" value="#{recruit_materialeditBB.initEdit}"></h:inputHidden>
      <h:inputHidden id="materiallID" value="#{recruit_materialeditBB.materialbo.materiallID}"></h:inputHidden>
       <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 业务设置 -> 材料信息维护"/>
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="面试材料名称"></h:outputText>
               <h:inputText id="materiallName" value="#{recruit_materialeditBB.materialbo.materiallName}"></h:inputText>
				
               <h:outputText value="描述"></h:outputText>
               <h:inputTextarea id="description" value="#{recruit_materialeditBB.materialbo.description}" rows="3" cols="50">
               </h:inputTextarea>
               <h:outputText value="附件"></h:outputText>
              <h:panelGroup>
              		<x:inputFileUpload styleClass="input" id="excelFile" value="#{recruit_materialeditBB.excelFile}"  storage="file" size="25" />
 					<h:commandButton value="上传"  styleClass="button01" action="#{recruit_materialeditBB.uploadFile}"/>
 					<h:outputText value="(.doc)"></h:outputText>
              </h:panelGroup>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="保存" id="save" onclick="return checksave()"  action="#{recruit_materialeditBB.save}" styleClass="button01"/>
           </h:panelGrid>
           
           </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
