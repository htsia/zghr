<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<x:saveState value="#{uploadReportBB}" />
<h:form id="form1">
<h:inputHidden value="#{uploadReportBB.pageInit}"></h:inputHidden>
 
  <h:panelGrid columns="1"  width="98%" align="center">
    <h:panelGrid columns="1"  styleClass="td_title" width="100%" cellpadding="4" align="center" border="0" >
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="����鿴"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="4" border="0" cellspacing="5" align="right">
    <h:panelGroup>
    	<h:outputText value="��¼��:#{uploadReportBB.mypage.totalRecord}"></h:outputText>
		<h:outputText value="  "></h:outputText>
		<h:outputText value="ҳ��:#{uploadReportBB.mypage.totalPage}"></h:outputText>
		<h:outputText value="  "></h:outputText>
		<h:outputText value="ÿҳ��#{uploadReportBB.mypage.pageSize}"></h:outputText>
		<h:outputText value="  "></h:outputText>
		<h:outputText
			value="��ǰΪ��#{uploadReportBB.mypage.currentPage}ҳ"></h:outputText>

		<h:commandButton value="��ҳ" action="#{uploadReportBB.first}"
			styleClass="button01"/>
		<h:commandButton value="��ҳ" action="#{uploadReportBB.pre}"
			styleClass="button01"/>
		<h:commandButton value="��ҳ" action="#{uploadReportBB.next}"
			styleClass="button01"/>
		<h:commandButton value="βҳ" action="#{uploadReportBB.last}"
			styleClass="button01"/>
	</h:panelGroup>
    </h:panelGrid>

    <h:dataTable value="#{uploadReportBB.list}" var="item"  id="dateList"
                 headerClass="td_top" width="100%" columnClasses="td_middle_center" align="center" border="1" styleClass="table03" >
		<h:column>
			<f:facet name="header">
			<h:outputText value="��������"/>
			</f:facet>
		<f:verbatim>
        	<a target="_blank" href="\</f:verbatim><h:outputText value="#{item.path}"/><f:verbatim>">
        	</f:verbatim>
        	<h:outputText value="#{item.name}"/>
        	<f:verbatim>
        	</a>
        </f:verbatim>
		</h:column>
		<h:column>
			<f:facet name="header">
			<h:outputText value="����(����)"/>
			</f:facet>
		<h:outputText value="#{item.sort}" escape="false"/>
		</h:column>
    </h:dataTable>
    </h:panelGrid>
</h:form>