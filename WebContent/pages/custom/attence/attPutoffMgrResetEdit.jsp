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
	<h:outputText value="������ѯ����"/>
			<h:selectOneMenu id="qry" style="width:150px" value="#{attPutoffMgrBB.qryID}">
                <c:selectItems value="#{attPutoffMgrBB.qryList}"/>
            </h:selectOneMenu>
            </h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="ȷ��"  action="#{attPutoffMgrBB.resetData}" styleClass="button01" />
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:outputText value="��ʾ��Ϣ:ÿѧ�ڿ�ʼ������һ�Σ��������Ա�Ĵ�н���٣���٣�ɥ�٣����٣��Ѳ����٣���н�¼���Ϊ5��,3��,3��,98��,15��,3��
			(���в��ٺ��Ѳ�����ŮԱ������) "/>
		</h:panelGrid>
</h:form>