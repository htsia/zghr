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
<h:panelGrid columns="3"  align="center">
	<h:outputText value="关联查询方案"/>
			<h:selectOneMenu id="qry" style="width:150px" value="#{attPutoffMgrBB.qryID}">
                <c:selectItems value="#{attPutoffMgrBB.qryList}"/>
            </h:selectOneMenu>
            </h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="确定"  action="#{attPutoffMgrBB.resetData}" styleClass="button01" />
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:outputText value="提示信息:每学期开始，操作一次，将相关人员的带薪病假，婚假，丧假，产假，难产产假，带薪事假置为5天,3天,3天,98天,15天,3天
			(其中产假和难产产假女员工才有) "/>
		</h:panelGrid>
</h:form>