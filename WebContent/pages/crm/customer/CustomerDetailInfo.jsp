<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>

<x:saveState value="#{customerBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{customerBB.cusdetailInit}" />
	
	
	<h:panelGrid columns="1" align="center" width="95%" id="dateList"
		styleClass="table02">
		<h:panelGroup>
			<h:panelGrid columns="4" align="center" width="100%"
				columnClasses="td_form01,td_middle_left,td_form01,td_middle_left">

				<h:outputText value="客户名称 "></h:outputText>
				<h:outputText value="#{customerBB.customerBO.cu_name}"></h:outputText>
				<h:outputText value="国 籍  "></h:outputText>
				<h:outputText value="#{customerBB.customerBO.cu_nation}"></h:outputText>

				<h:outputText value="城市 "></h:outputText>
				<h:outputText value="#{customerBB.customerBO.cu_nation}"></h:outputText>
				<h:outputText value="邮编 "></h:outputText>
				<h:outputText value="#{customerBB.customerBO.zip}"></h:outputText>

				<h:outputText value="创建人 "></h:outputText>
				<h:outputText value="#{customerBB.customerBO.createor}"></h:outputText>
				<h:outputText value="创建时间"></h:outputText>
				<h:outputText value="#{customerBB.customerBO.create_date}"></h:outputText>

				<h:outputText value="客户类型 "></h:outputText>
				<h:outputText value="#{customerBB.customerBO.cu_type}"></h:outputText>
				<h:outputText value="网站 "></h:outputText>
				<h:outputText value="#{customerBB.customerBO.web_url}"></h:outputText>
			</h:panelGrid>

			<h:panelGroup> 
				<h:panelGrid columns="2" align="center" width="100%" columnClasses="td_form01,td_middle_left,td_form01,td_middle_left">
					<h:outputText value="地址 "></h:outputText>
					<h:outputText value="#{customerBB.customerBO.cu_addr}"></h:outputText>

					<h:outputText value="客户描述 "></h:outputText>
					<h:outputText styleClass="f08"
						value="#{customerBB.customerBO.description}"></h:outputText>
				</h:panelGrid>
			</h:panelGroup>

		</h:panelGroup>
	</h:panelGrid>
</h:form>


