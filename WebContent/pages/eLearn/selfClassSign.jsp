<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

  <script type="text/javascript">
  </script>
  
  <x:saveState value="#{eLearn_courcebb}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{eLearn_courcebb.initsign}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value="培训班管理-> 增加培训班"/>
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
             	<h:outputText value="培训班名称"></h:outputText>
               	<h:inputText readonly="true" value="#{eLearn_courcebb.classbo.className}" ></h:inputText>

                 <h:outputText value="负责人"></h:outputText>
               	<h:inputText readonly="true" value="#{eLearn_courcebb.classbo.classMajor}" ></h:inputText>

               	<h:outputText value="培训目的"></h:outputText>
               	<h:inputText readonly="true" value="#{eLearn_courcebb.classbo.classAid}" ></h:inputText>

               	<h:outputText value="描述"></h:outputText>
               	<h:inputTextarea readonly="true" value="#{eLearn_courcebb.classbo.classDesc}" rows="5" cols="30"></h:inputTextarea>

               	<h:outputText value="培训对象"></h:outputText>
               	<h:inputText readonly="true" value="#{eLearn_courcebb.classbo.classScope}" ></h:inputText>

               	<h:outputText value="预算"></h:outputText>
               	<h:inputText readonly="true" value="#{eLearn_courcebb.classbo.classBudget}" ></h:inputText>

               	<h:outputText value="应用范围"></h:outputText>
               	<h:selectOneMenu disabled="true" value="#{eLearn_courcebb.classbo.org_scope}">
                      <c:selectItems value="#{eLearn_courcebb.orgList}"></c:selectItems>
               	</h:selectOneMenu>

               	<h:outputText value="课时"></h:outputText>
               	<h:inputText readonly="true" value="#{eLearn_courcebb.classbo.classHour}" ></h:inputText>

               	<h:outputText value="课程说明"></h:outputText>
				<h:inputTextarea readonly="true" value="#{eLearn_courcebb.classbo.classCourse}" rows="5" cols="30"></h:inputTextarea>

                <h:outputText value="关联在线学习课程"></h:outputText>
				<h:inputTextarea readonly="true" value="#{eLearn_courcebb.classbo.courseDes}" rows="3" cols="30"></h:inputTextarea>
               <h:outputText value="操作"></h:outputText>
               <h:panelGroup>
                    <h:commandButton value="报名" id="save"    	rendered="#{!eLearn_courcebb.signed}" action="#{eLearn_courcebb.sign}" styleClass="button01"/>
                    <h:outputText value="已报名" rendered="#{eLearn_courcebb.signed}"></h:outputText>
               </h:panelGroup>
            </h:panelGrid>
                                                                                
    </h:panelGrid>
  </h:form>
  <script type="text/javascript">
    interpret(document.forms(0));
</script>
