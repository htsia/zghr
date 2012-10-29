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
		<h:commandButton id="btn" value="��Ϣά��" onclick="javascript:windowOpen('/self/PersonInfoDetailList.jsf?setId=A848&flag=2&fk=#{self_bakinfobb.perId}&type=0','','','700','500','','20','20');return false;"  styleClass="button"/>
		</h:panelGroup>
		<h:panelGrid width="100%" columns="2" border="1" align="center"
			styleClass="table03" columnClasses="td_form01,td_form02"
			cellpadding="4">
			<h:outputText  value="���˷�չĿ��" />
			<h:outputText value="#{self_bakinfobb.trainDirection}" />

			<h:outputText value="���ݷ�չĿ�꣬Ŀǰ����չ������" />
			<h:outputText value="#{self_bakinfobb.making}" />

			<h:outputText value="���ݷ�չĿ�꣬��Ҫ�õ���Щ��ѵ" />
			<h:outputText value="#{self_bakinfobb.neededTrain}" />

			<h:outputText value="��ǰ���μӹ�����ѵ����" />
			<h:outputText value="#{self_bakinfobb.attendedTrain}" />

			<h:outputText value="���ݷ�չĿ�꣬Ŀǰ���߱����������ʼ������" />
			<h:outputText value="#{self_bakinfobb.advantage}" />

			<h:outputText value="��Ҫ�����Լ����Ը��ص�" />
			<h:outputText value="#{self_bakinfobb.characterSpecialty}" />
			
			<h:outputText value="��������������Լ���Ϊ�ʺϺͲ��ʺϴ��µĹ������λ " />
			<h:outputText escape="false" value="#{self_bakinfobb.unsuitability}" />
			
			<h:outputText value="�������ϻ��к�������������" />
			<h:outputText escape="false" value="#{self_bakinfobb.advice}" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>
