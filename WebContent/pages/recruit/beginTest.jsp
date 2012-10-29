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
              alert("����������");
              return false;
          }
          if(document.all('form1:paperName').value==null || document.all('form1:paperName').value==""){
        	  alert("�ø�λû�������Ծ��������������������Ծ�");
              return false;
          }
          if(document.all('form1:beginTime').value==null || document.all('form1:beginTime').value==""){
        	  alert("���Կ�ʼʱ�䲻��Ϊ��");
              return false;
          }
         
          return true;
      }
    </script>

<x:saveState value="#{recruitBeginTestBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{recruitBeginTestBB.pageInit}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{recruitBeginTestBB.SaveTest}"
                            onclick="return doCheck();">
            </h:commandButton>
            <h:commandButton styleClass="button01" type="button" value="ȡ������" onclick="window.close();"/>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="����"/>
            <h:inputText id="name" value="#{recruitBeginTestBB.testbo.testName}" readonly="true"/>

            <h:outputText  value="ʹ���Ծ�"/>
            <h:panelGroup>
                <h:inputText id="paperName" readonly="true" value="#{recruitBeginTestBB.testbo.paperName}"></h:inputText>
                <h:inputHidden id="paperID" value="#{recruitBeginTestBB.testbo.paperID}"></h:inputHidden>
            </h:panelGroup>

            <h:outputText  value="��ʼʱ��"/>
            <h:panelGroup>
                <h:inputText id="beginTime" readonly="true" value="#{recruitBeginTestBB.testbo.beginTime}" />
                <h:commandButton styleClass="button_select" type="button" onclick="PopUpCalendarDialog('form1:beginTime');"> </h:commandButton>
            	 <h:selectOneMenu value="#{recruitBeginTestBB.hour}">
                      <c:selectItems value="#{recruitBeginTestBB.hourList}"></c:selectItems>
               	</h:selectOneMenu>
                <h:outputText value="ʱ"></h:outputText>
                <h:selectOneMenu value="#{recruitBeginTestBB.minute}">
                      <c:selectItems value="#{recruitBeginTestBB.minuteList}"></c:selectItems>
               	</h:selectOneMenu>
                 <h:outputText value="��"></h:outputText>
            
            </h:panelGroup>
			<h:outputText  value="����ʱ�䣨���ӣ�"/>
            <h:inputText  value="#{recruitBeginTestBB.testbo.testminute}" />
             <h:outputText  value="����ʱ��"/>
            <h:panelGroup>
                <h:inputText id="endTime" readonly="true" value="#{recruitBeginTestBB.testbo.endTime}" />
               
            </h:panelGroup>
            </h:panelGrid>
           

            
    </h:panelGrid>
</h:form>

