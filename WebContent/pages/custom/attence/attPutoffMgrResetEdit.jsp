<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
         
      </script>
<x:saveState value="#{attPutoffMgrBB}" />
<h:inputHidden value="#{attPutoffMgrBB.resetInit}"/>
<h:form id="form1">
<h:panelGrid columns="2" align="center">
	<h:outputText value="关联查询方案"/>
			<h:selectOneMenu id="qry" style="width:150px" value="#{attPutoffMgrBB.qryID}">
                <c:selectItems value="#{attPutoffMgrBB.qryList}"/>
            </h:selectOneMenu>
            </h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="确定"  action="#{attPutoffMgrBB.resetData}" styleClass="button01" />
		</h:panelGrid>
</h:form>