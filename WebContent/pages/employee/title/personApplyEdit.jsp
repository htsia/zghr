<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   <script type="text/javascript">
    	function chkData(){
        	 if(document.all("form1:applyLevel").value==null&&document.all("form1:applyLevel").value==""){
            	 alert("拟报等级不能为空！");
            	 return false;
        	 }else{
             	return forsubmit(document.forms(0));
        	 }
         }
    	</script>   
  <x:saveState value="#{persontitleapplyBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{persontitleapplyBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 职称管理 -> 个人申报"/>
          </h:panelGroup>
      </h:panelGrid>
      <c:verbatim>
		   	<br><br>
		   </c:verbatim>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="姓名"></h:outputText>
               <h:outputText value="#{persontitleapplyBB.titleItembo.personName}"></h:outputText>
               <h:outputText value="性别"></h:outputText>
               <h:outputText value="#{persontitleapplyBB.titleItembo.sex}"></h:outputText>
               <h:outputText value="部门"></h:outputText>
               <h:outputText value="#{persontitleapplyBB.titleItembo.orgName}"></h:outputText>
               <h:outputText value="现等级"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="preLevel" code="" dict="yes" dict_num="0170"
                     readonly="true" value="#{persontitleapplyBB.titleItembo.preLevel}"
                     alt="职称级别|1|s|50||"/>
         			<h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:preLevel')" />
               </h:panelGroup>
               <h:outputText value="现专业"></h:outputText>
               <h:panelGroup>
               		 <h:inputText styleClass="input" id="preMajor" code="" dict="yes" dict_num="0370"
                     readonly="true" value="#{persontitleapplyBB.titleItembo.preMajor}"
                     alt="专业|1|s|50||"/>
        			<h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:preMajor')" />
               </h:panelGroup>
               <h:outputText value="现资格"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="preTitle" code="" dict="yes" dict_num="0330"
                     readonly="true" value="#{persontitleapplyBB.titleItembo.preTitle}"
                     alt="性别|1|s|50||"/>
                     <h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:preTitle')" />
               </h:panelGroup>
               <h:outputText value="取得现资格时间"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="priTime" 
                     readonly="true" value="#{persontitleapplyBB.titleItembo.priTime}"
                     alt="日期|1|s|50||"/>
                     <h:commandButton type="button" styleClass="button_select"  onclick="PopUpCalendarDialog('form1:priTime')" />
               </h:panelGroup>
               <h:outputText value="拟申报等级"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="applyLevel" code="" dict="yes" dict_num="0170"
                     readonly="true" value="#{persontitleapplyBB.titleItembo.applyLevel}"
                     alt="职称级别|1|s|50||"/>
         			<h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:applyLevel')" />
               </h:panelGroup>
               <h:outputText value="申报专业"></h:outputText>
               <h:panelGroup>
               		 <h:inputText styleClass="input" id="applyMajor" code="" dict="yes" dict_num="0370"
                     readonly="true" value="#{persontitleapplyBB.titleItembo.applyMajor}"
                     alt="专业|1|s|50||"/>
        			<h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:applyMajor')" />
               </h:panelGroup>
               <h:outputText value="申报资格"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="applyTitle" code="" dict="yes" dict_num="0330"
                     readonly="true" value="#{persontitleapplyBB.titleItembo.applyTitle}"
                     alt="性别|1|s|50||"/>
                     <h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:applyTitle')" />
               </h:panelGroup>
           </h:panelGrid>
		   <c:verbatim>
		   	<br><br>
		   </c:verbatim>
           <h:panelGrid align="right">
              <h:commandButton value="保存" id="save" styleClass="button01"  action="#{persontitleapplyBB.saveItem}"
               onclick="chkData();" rendered="#{persontitleapplyBB.status=='0'||persontitleapplyBB.status=='9'}"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>