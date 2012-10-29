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
          if(document.all('form1:paperName').value==null || document.all('form1:paperName').value==""){
        	  alert("该岗位没有设置试卷，请在面试设置中设置试卷");
              return false;
          }
          if(document.all('form1:beginTime').value==null || document.all('form1:beginTime').value==""){
        	  alert("考试开始时间不能为空");
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
            <h:commandButton styleClass="button01" value="保存" action="#{recruitBeginTestBB.SaveTest}"
                            onclick="return doCheck();">
            </h:commandButton>
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="名称"/>
            <h:inputText id="name" value="#{recruitBeginTestBB.testbo.testName}" readonly="true"/>

            <h:outputText  value="使用试卷"/>
            <h:panelGroup>
                <h:inputText id="paperName" readonly="true" value="#{recruitBeginTestBB.testbo.paperName}"></h:inputText>
                <h:inputHidden id="paperID" value="#{recruitBeginTestBB.testbo.paperID}"></h:inputHidden>
            </h:panelGroup>

            <h:outputText  value="开始时间"/>
            <h:panelGroup>
                <h:inputText id="beginTime" readonly="true" value="#{recruitBeginTestBB.testbo.beginTime}" />
                <h:commandButton styleClass="button_select" type="button" onclick="PopUpCalendarDialog('form1:beginTime');"> </h:commandButton>
            	 <h:selectOneMenu value="#{recruitBeginTestBB.hour}">
                      <c:selectItems value="#{recruitBeginTestBB.hourList}"></c:selectItems>
               	</h:selectOneMenu>
                <h:outputText value="时"></h:outputText>
                <h:selectOneMenu value="#{recruitBeginTestBB.minute}">
                      <c:selectItems value="#{recruitBeginTestBB.minuteList}"></c:selectItems>
               	</h:selectOneMenu>
                 <h:outputText value="分"></h:outputText>
            
            </h:panelGroup>
			<h:outputText  value="考试时间（分钟）"/>
            <h:inputText  value="#{recruitBeginTestBB.testbo.testminute}" />
             <h:outputText  value="结束时间"/>
            <h:panelGroup>
                <h:inputText id="endTime" readonly="true" value="#{recruitBeginTestBB.testbo.endTime}" />
               
            </h:panelGroup>
            </h:panelGrid>
           

            
    </h:panelGrid>
</h:form>

