<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    	function checkform1(){
             if (document.all('form1:prepassword').value==""){
                alert("原始密码不能为空");
                return false;
             }
             if (document.all('form1:password1').value==""){
                 alert("密码不能为空");
                 return false;
             }
             if (document.all('form1:password2').value==""){
                 alert("请再次输入密码");
                 return false;
             }
             if (document.all('form1:password2').value!=document.all('form1:password1').value){
                 alert("两次输入的密码不一致");
                 return false;
             }
             return true;
         }
        function checkform(){
            if(checkform1()){
            	return forsubmit(document.forms(0)); 
            }
            return false;
        }
       	function forBack(form){
             window.close();
       }
      </script>
  
  <x:saveState value="#{resumePasswordEditBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{resumePasswordEditBB.pageInit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value="密码修改"/>
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="姓名"></h:outputText>
               <h:inputText value="#{resumePasswordEditBB.personbo.a001001}" readonly="true"></h:inputText>
				<h:outputText value="原密码"></h:outputText>
               <h:inputText value="#{resumePasswordEditBB.password}"  id="prepassword"></h:inputText>
				<h:outputText value="新密码"></h:outputText>
               <h:inputText value="#{resumePasswordEditBB.personbo.password}" id="password1"></h:inputText>
               <h:outputText value="再次输入新密码"></h:outputText>
               <h:inputText value="#{resumePasswordEditBB.personbo.password}" id="password2"></h:inputText>
              </h:panelGrid>
			<h:panelGrid align="right">
              <h:commandButton value="修改" id="modifu" action="#{resumePasswordEditBB.modifyPawword}" styleClass="button01" onclick="checkform()"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
  <script type="text/javascript">
    interpret(document.forms(0));
</script>
