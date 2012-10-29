<%@ page contentType="text/html;charset=GBK" language="java" %>
<%
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0);
%>

<script language="javascript"	src="<%=request.getContextPath()%>/js/check.js"></script>
<script language="javascript"	src="<%=request.getContextPath()%>/js/checkAll.js"></script>
<script language="javascript"	src="<%=request.getContextPath()%>/js/Appclient.js"></script>

<%@ include file="/pages/include/taglib.jsp" %>

<x:saveState value="#{self_bakinfobb}"/>
<h:form>    
<h:inputHidden value="#{self_bakinfobb.initHid}"/>	
	<h:panelGrid width="600" columns="1" border="0" align="center"
		cellpadding="0" >
		<h:panelGroup>
		<h:commandButton id="btn" value="信息维护" onclick="javascript:windowOpen('/self/PersonInfoDetailList.jsf?setId=A848&flag=2&fk=#{self_bakinfobb.perId}&type=0','','','700','500','','20','20');return false;"  styleClass="button"/>
		</h:panelGroup>
		<h:panelGrid width="100%" columns="2" border="1" align="center"
			styleClass="table03" columnClasses="td_form01,td_form02"
			cellpadding="4">
			<h:outputText  value="个人发展目标" />
			<h:outputText value="#{self_bakinfobb.trainDirection}" />

			<h:outputText value="根据发展目标，目前待发展的素质" />
			<h:outputText value="#{self_bakinfobb.making}" />

			<h:outputText value="根据发展目标，需要得到哪些培训" />
			<h:outputText value="#{self_bakinfobb.neededTrain}" />

			<h:outputText value="以前所参加过的培训经历" />
			<h:outputText value="#{self_bakinfobb.attendedTrain}" />

			<h:outputText value="根据发展目标，目前所具备的优势素质及其表现" />
			<h:outputText value="#{self_bakinfobb.advantage}" />

			<h:outputText value="简要描述自己的性格特点" />
			<h:outputText value="#{self_bakinfobb.characterSpecialty}" />
			
			<h:outputText value="根据自身情况，自己认为适合和不适合从事的工作或岗位 " />
			<h:outputText escape="false" value="#{self_bakinfobb.unsuitability}" />
			
			<h:outputText value="在培养上还有何其他建议和意见" />
			<h:outputText escape="false" value="#{self_bakinfobb.advice}" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>
