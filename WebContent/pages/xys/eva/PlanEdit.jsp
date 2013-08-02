<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   <script type="text/javascript">
       function chkData(){
            forsubmit(document.forms(0));
       }
   </script>
  <x:saveState value="#{xys_evaPlanMgrBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{xys_evaPlanMgrBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 绩效管理 ->考核计划管理"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="计划名称"/>
               <h:inputText id="planName" value="#{xys_evaPlanMgrBB.planBO.planName}" />
               <h:outputText value="年度"/>
               <h:inputText id="year" value="#{xys_evaPlanMgrBB.planBO.year}" />
               <h:outputText value="开始时间"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="beginTime" value="#{xys_evaPlanMgrBB.planBO.beginTime}"
                             readonly="true" alt="开始日期|0|d|50||"/>
                <c:verbatim>
                 <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginTime')">
                </c:verbatim>
            </h:panelGroup>

            <h:outputText value="结束时间"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="endTime" value="#{xys_evaPlanMgrBB.planBO.endTime}"
                             readonly="true" alt="结束日期|0|d|50||"/>
                <c:verbatim>
                  <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:endTime')">
                </c:verbatim>
            </h:panelGroup>
            <h:outputText value="周期类型"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="planType" code="" dict="yes" dict_num="0650"
                             readonly="true" value="#{xys_evaPlanMgrBB.planBO.planType}"
                             alt="周期类型|0|s|50||"/>
                <c:verbatim>
                  <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:planType')">
                </c:verbatim>
             </h:panelGroup>
             <h:outputText value="结果等级"/>
            <h:panelGroup>
            	<h:inputHidden id="codec" value="#{xys_evaPlanMgrBB.planBO.planGrade}"/>

                <h:inputText id="valuec" readonly="true" value="#{xys_evaPlanMgrBB.planBO.planGradeName}"/>
                <h:commandButton type="button" onclick="PopUpGradeTypeTwoControl(document.all('form1:codec'), document.all('form1:valuec'))" styleClass="button_select"></h:commandButton>
             </h:panelGroup>
               
               <h:outputText value="分数保留位数"></h:outputText>
            <h:selectOneMenu value="#{xys_evaPlanMgrBB.planBO.scorePers}">
                <c:selectItem itemLabel="两位小数" itemValue="2"></c:selectItem>
                <c:selectItem itemLabel="一位小数" itemValue="1"></c:selectItem>
                <c:selectItem itemLabel="整数" itemValue="0"></c:selectItem>
            </h:selectOneMenu>
            
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="保存"  styleClass="button01"  action="#{xys_evaPlanMgrBB.savePlan}" onclick="chkData();"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>