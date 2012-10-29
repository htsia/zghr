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
              <h:outputText value="��ѵ�����-> ������ѵ��"/>
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
             	<h:outputText value="��ѵ������"></h:outputText>
               	<h:inputText readonly="true" value="#{eLearn_courcebb.classbo.className}" ></h:inputText>

                 <h:outputText value="������"></h:outputText>
               	<h:inputText readonly="true" value="#{eLearn_courcebb.classbo.classMajor}" ></h:inputText>

               	<h:outputText value="��ѵĿ��"></h:outputText>
               	<h:inputText readonly="true" value="#{eLearn_courcebb.classbo.classAid}" ></h:inputText>

               	<h:outputText value="����"></h:outputText>
               	<h:inputTextarea readonly="true" value="#{eLearn_courcebb.classbo.classDesc}" rows="5" cols="30"></h:inputTextarea>

               	<h:outputText value="��ѵ����"></h:outputText>
               	<h:inputText readonly="true" value="#{eLearn_courcebb.classbo.classScope}" ></h:inputText>

               	<h:outputText value="Ԥ��"></h:outputText>
               	<h:inputText readonly="true" value="#{eLearn_courcebb.classbo.classBudget}" ></h:inputText>

               	<h:outputText value="Ӧ�÷�Χ"></h:outputText>
               	<h:selectOneMenu disabled="true" value="#{eLearn_courcebb.classbo.org_scope}">
                      <c:selectItems value="#{eLearn_courcebb.orgList}"></c:selectItems>
               	</h:selectOneMenu>

               	<h:outputText value="��ʱ"></h:outputText>
               	<h:inputText readonly="true" value="#{eLearn_courcebb.classbo.classHour}" ></h:inputText>

               	<h:outputText value="�γ�˵��"></h:outputText>
				<h:inputTextarea readonly="true" value="#{eLearn_courcebb.classbo.classCourse}" rows="5" cols="30"></h:inputTextarea>

                <h:outputText value="��������ѧϰ�γ�"></h:outputText>
				<h:inputTextarea readonly="true" value="#{eLearn_courcebb.classbo.courseDes}" rows="3" cols="30"></h:inputTextarea>
               <h:outputText value="����"></h:outputText>
               <h:panelGroup>
                    <h:commandButton value="����" id="save"    	rendered="#{!eLearn_courcebb.signed}" action="#{eLearn_courcebb.sign}" styleClass="button01"/>
                    <h:outputText value="�ѱ���" rendered="#{eLearn_courcebb.signed}"></h:outputText>
               </h:panelGroup>
            </h:panelGrid>
                                                                                
    </h:panelGrid>
  </h:form>
  <script type="text/javascript">
    interpret(document.forms(0));
</script>
