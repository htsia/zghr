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
            	 alert("�ⱨ�ȼ�����Ϊ�գ�");
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
              <h:outputText value=" ְ�ƹ��� -> �����걨"/>
          </h:panelGroup>
      </h:panelGrid>
      <c:verbatim>
		   	<br><br>
		   </c:verbatim>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="����"></h:outputText>
               <h:outputText value="#{persontitleapplyBB.titleItembo.personName}"></h:outputText>
               <h:outputText value="�Ա�"></h:outputText>
               <h:outputText value="#{persontitleapplyBB.titleItembo.sex}"></h:outputText>
               <h:outputText value="����"></h:outputText>
               <h:outputText value="#{persontitleapplyBB.titleItembo.orgName}"></h:outputText>
               <h:outputText value="�ֵȼ�"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="preLevel" code="" dict="yes" dict_num="0170"
                     readonly="true" value="#{persontitleapplyBB.titleItembo.preLevel}"
                     alt="ְ�Ƽ���|1|s|50||"/>
         			<h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:preLevel')" />
               </h:panelGroup>
               <h:outputText value="��רҵ"></h:outputText>
               <h:panelGroup>
               		 <h:inputText styleClass="input" id="preMajor" code="" dict="yes" dict_num="0370"
                     readonly="true" value="#{persontitleapplyBB.titleItembo.preMajor}"
                     alt="רҵ|1|s|50||"/>
        			<h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:preMajor')" />
               </h:panelGroup>
               <h:outputText value="���ʸ�"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="preTitle" code="" dict="yes" dict_num="0330"
                     readonly="true" value="#{persontitleapplyBB.titleItembo.preTitle}"
                     alt="�Ա�|1|s|50||"/>
                     <h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:preTitle')" />
               </h:panelGroup>
               <h:outputText value="ȡ�����ʸ�ʱ��"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="priTime" 
                     readonly="true" value="#{persontitleapplyBB.titleItembo.priTime}"
                     alt="����|1|s|50||"/>
                     <h:commandButton type="button" styleClass="button_select"  onclick="PopUpCalendarDialog('form1:priTime')" />
               </h:panelGroup>
               <h:outputText value="���걨�ȼ�"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="applyLevel" code="" dict="yes" dict_num="0170"
                     readonly="true" value="#{persontitleapplyBB.titleItembo.applyLevel}"
                     alt="ְ�Ƽ���|1|s|50||"/>
         			<h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:applyLevel')" />
               </h:panelGroup>
               <h:outputText value="�걨רҵ"></h:outputText>
               <h:panelGroup>
               		 <h:inputText styleClass="input" id="applyMajor" code="" dict="yes" dict_num="0370"
                     readonly="true" value="#{persontitleapplyBB.titleItembo.applyMajor}"
                     alt="רҵ|1|s|50||"/>
        			<h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:applyMajor')" />
               </h:panelGroup>
               <h:outputText value="�걨�ʸ�"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="applyTitle" code="" dict="yes" dict_num="0330"
                     readonly="true" value="#{persontitleapplyBB.titleItembo.applyTitle}"
                     alt="�Ա�|1|s|50||"/>
                     <h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:applyTitle')" />
               </h:panelGroup>
           </h:panelGrid>
		   <c:verbatim>
		   	<br><br>
		   </c:verbatim>
           <h:panelGrid align="right">
              <h:commandButton value="����" id="save" styleClass="button01"  action="#{persontitleapplyBB.saveItem}"
               onclick="chkData();" rendered="#{persontitleapplyBB.status=='0'||persontitleapplyBB.status=='9'}"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>