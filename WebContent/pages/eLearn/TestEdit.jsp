<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    
    <script type="text/javascript">
      function doCheck(){
          if(document.all('form1:beginTime').value==null ||document.all('form1:beginTime').value==""){
        	  alert("��ѡ���Կ�ʼʱ��");
        	  return false;
          }
          if(document.all('form1:testminute').value==null ||document.all('form1:testminute').value==""){
        	  alert("�����뿼��ʱ��");
        	  return false;
          }else{
              var test=document.all('form1:testminute').value;
              var testtime=parseInt(test); 
              if(testtime>1440){
            	  alert("����ʱ�䲻�ܳ���һ��");
            	  return false;
              }
          }
         if (document.all('form1:name').value==null || document.all('form1:name').value==""){
              alert("����������");
              return false;
          }
          return true;
      }
    </script>

<x:saveState value="#{eLearn_testBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eLearn_testBB.pageInit}"/>
    <h:inputHidden value="#{eLearn_testBB.testbo.testID}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{eLearn_testBB.SaveTest}"
                            onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" type="button" value="ȡ������" onclick="window.close();"/>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="����"/>
            <h:inputText id="name" value="#{eLearn_testBB.testbo.testName}"/>

            <h:outputText  value="ʹ���Ծ�"/>
            <h:panelGroup>
                <h:inputText id="paperName" readonly="true" value="#{eLearn_testBB.testbo.paperName}"></h:inputText>
                <h:inputHidden id="paperID" value="#{eLearn_testBB.testbo.paperID}"></h:inputHidden>
                <h:commandButton styleClass="button_select" onclick="PopUpPaperTwoControl(document.all('form1:paperID'),document.all('form1:paperName'))" type="button" ></h:commandButton>
            </h:panelGroup>

            <h:outputText  value="��ʼʱ��"/>
            <h:panelGroup>
                <h:inputText id="beginTime" readonly="true" value="#{eLearn_testBB.testbo.beginTime}" />
                <h:commandButton styleClass="button_select" type="button" onclick="PopUpCalendarDialog('form1:beginTime');"> </h:commandButton>
                <h:selectOneMenu value="#{eLearn_testBB.hour}">
                      <c:selectItems value="#{eLearn_testBB.hourList}"></c:selectItems>
               </h:selectOneMenu>
                <h:outputText value="ʱ"></h:outputText>
                <h:selectOneMenu value="#{eLearn_testBB.minute}">
                      <c:selectItems value="#{eLearn_testBB.minuteList}"></c:selectItems>
               </h:selectOneMenu>
                 <h:outputText value="��"></h:outputText>
            </h:panelGroup>
			<h:outputText  value="����ʱ�䣨���ӣ�"/>
            <h:inputText  id="testminute" value="#{eLearn_testBB.testbo.testminute}" />
			
            <h:outputText  value="����ʱ��"/>
            <h:panelGroup>
                <h:inputText id="endTime" readonly="true" value="#{eLearn_testBB.testbo.endTime}" />
            </h:panelGroup>
			<h:outputText  value="�Ƿ�����"/>
            <h:selectOneRadio value="#{eLearn_testBB.testbo.isUse}">
                <c:selectItem itemValue="0" itemLabel="��"></c:selectItem>
                <c:selectItem itemValue="1" itemLabel="��"></c:selectItem>
            </h:selectOneRadio>

            <h:outputText  value="��Ա��Χ"/>
            <h:selectOneRadio value="#{eLearn_testBB.testbo.scopeType}">
                <c:selectItem itemValue="0" itemLabel="ȫ��������"></c:selectItem>
                <c:selectItem itemValue="1" itemLabel="����λ����"></c:selectItem>
                <c:selectItem itemValue="2" itemLabel="����ָ��"></c:selectItem>
            </h:selectOneRadio>

        </h:panelGrid>
    </h:panelGrid>
</h:form>

