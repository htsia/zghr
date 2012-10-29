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
        	  alert("请选择考试开始时间");
        	  return false;
          }
          if(document.all('form1:testminute').value==null ||document.all('form1:testminute').value==""){
        	  alert("请输入考试时间");
        	  return false;
          }else{
              var test=document.all('form1:testminute').value;
              var testtime=parseInt(test); 
              if(testtime>1440){
            	  alert("考试时间不能超过一天");
            	  return false;
              }
          }
         if (document.all('form1:name').value==null || document.all('form1:name').value==""){
              alert("请输入名称");
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
            <h:commandButton styleClass="button01" value="保存" action="#{eLearn_testBB.SaveTest}"
                            onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="名称"/>
            <h:inputText id="name" value="#{eLearn_testBB.testbo.testName}"/>

            <h:outputText  value="使用试卷"/>
            <h:panelGroup>
                <h:inputText id="paperName" readonly="true" value="#{eLearn_testBB.testbo.paperName}"></h:inputText>
                <h:inputHidden id="paperID" value="#{eLearn_testBB.testbo.paperID}"></h:inputHidden>
                <h:commandButton styleClass="button_select" onclick="PopUpPaperTwoControl(document.all('form1:paperID'),document.all('form1:paperName'))" type="button" ></h:commandButton>
            </h:panelGroup>

            <h:outputText  value="开始时间"/>
            <h:panelGroup>
                <h:inputText id="beginTime" readonly="true" value="#{eLearn_testBB.testbo.beginTime}" />
                <h:commandButton styleClass="button_select" type="button" onclick="PopUpCalendarDialog('form1:beginTime');"> </h:commandButton>
                <h:selectOneMenu value="#{eLearn_testBB.hour}">
                      <c:selectItems value="#{eLearn_testBB.hourList}"></c:selectItems>
               </h:selectOneMenu>
                <h:outputText value="时"></h:outputText>
                <h:selectOneMenu value="#{eLearn_testBB.minute}">
                      <c:selectItems value="#{eLearn_testBB.minuteList}"></c:selectItems>
               </h:selectOneMenu>
                 <h:outputText value="分"></h:outputText>
            </h:panelGroup>
			<h:outputText  value="考试时间（分钟）"/>
            <h:inputText  id="testminute" value="#{eLearn_testBB.testbo.testminute}" />
			
            <h:outputText  value="结束时间"/>
            <h:panelGroup>
                <h:inputText id="endTime" readonly="true" value="#{eLearn_testBB.testbo.endTime}" />
            </h:panelGroup>
			<h:outputText  value="是否启用"/>
            <h:selectOneRadio value="#{eLearn_testBB.testbo.isUse}">
                <c:selectItem itemValue="0" itemLabel="否"></c:selectItem>
                <c:selectItem itemValue="1" itemLabel="是"></c:selectItem>
            </h:selectOneRadio>

            <h:outputText  value="人员范围"/>
            <h:selectOneRadio value="#{eLearn_testBB.testbo.scopeType}">
                <c:selectItem itemValue="0" itemLabel="全集团所有"></c:selectItem>
                <c:selectItem itemValue="1" itemLabel="本单位所有"></c:selectItem>
                <c:selectItem itemValue="2" itemLabel="自行指定"></c:selectItem>
            </h:selectOneRadio>

        </h:panelGrid>
    </h:panelGrid>
</h:form>

