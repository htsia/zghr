<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>

<f:verbatim>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
</f:verbatim>

<x:saveState value="#{eva_planBB}"/>
        <h:inputHidden value = "#{eva_planBB.initPlanRelease}"></h:inputHidden>
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
            <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value=" 绩效管理 ->  发布考核计划"/>
            </h:panelGroup>
       </h:panelGrid>
		<f:verbatim>
			<br>
		</f:verbatim>
		<h:form>
		<h:panelGrid width="778" align="center" >
				<h:panelGroup>
					<x:dataTable value="#{eva_planBB.evaPlantoReleaseList}" var="reslist" rowIndexVar="index" width="95%" border="1" columnClasses="center">

						<h:column>
							<f:facet name="header">
								<h:outputText value="序号" />
							</f:facet>
							<h:outputText value="#{index+1}" />
						</h:column>

						<h:column>
							<f:facet name="header">
								<h:outputText value="考核计划名称" />
							</f:facet>
							<h:outputText value="#{reslist.planName}" />
						</h:column>

						<h:column>
							<f:facet name="header">
								<h:outputText value="建立时间" />
							</f:facet>
							<h:outputText value="#{reslist.setDate}" />
						</h:column>

						<h:column>
							<f:facet name="header">
								<h:outputText value="建立人" />
							</f:facet>
							<h:outputText value="#{reslist.personName}" />
						</h:column>

						<h:column>
							<f:facet name="header">
								<h:outputText value="操作" />
							</f:facet>
						    <x:commandLink onclick="{if(!confirm('确认要发布吗?'))return false;}"  action="#{eva_planBB.releasePlans}" value="发布"  style="width:100%;text-align:center">
					           <x:updateActionListener property="#{eva_planBB.toReleasePlanId}" value="#{reslist.planId}" />
			                </x:commandLink>
						</h:column>
					</x:dataTable>
				</h:panelGroup>
		</h:panelGrid>
	</h:form>
