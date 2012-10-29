<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery.js" type="text/javascript"></script>
<script type="text/javascript">
	function forsave(){
		var xishu = $("input[code=1]");
		if(xishu.lenght==0){
			alert("���޼�Ч����ȼ�");
			return false;
		}
		var xishuIDs="";
		var xishus="";
		var err=0;
		xishu.each(function(e){
			var xs = $(this).val();
			if(xs ==null || xs =='' || isNaN(xs)){
				alert("��Ч����ȼ�"+$(this).attr("alt")+"��ϵ��ӦΪ����");
				err++;
				return false;
			}
			xishuIDs+=$(this).attr("dict")+",";
			xishus+=$(this).val()+",";
		});
		if(err>0){
			return false;
		}
		xishuIDs=xishuIDs.substr(0, xishuIDs.length - 1);
		xishus=xishus.substr(0, xishus.length - 1);
		document.all("form1:xishuIDs").value=xishuIDs;
		document.all("form1:xishus").value=xishus;
		return true;
	}
</script>
<x:saveState value="#{evaWageBB}" />
<h:inputHidden value="#{evaWageBB.xishuInit}"/>
<h:form id="form1" enctype="multipart/form-data">
	<h:inputHidden id="xishuIDs" value="#{evaWageBB.xishuIDs}"/>
	<h:inputHidden id="xishus" value="#{evaWageBB.xishus}"/>
	<c:verbatim>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	        <tr>
	            <td height=20 class="td_title"><img src="/images/tips.gif">��Чϵ��</td>
	        </tr>
	    </table>
	</c:verbatim>
	<h:panelGrid columns="1" width="100%" align="left">
		 <h:panelGrid columns="1" align="left">
			<h:panelGroup>
				<h:commandButton styleClass="button01" value="���¼��صȼ�" onclick="return confirm('ȷ�����¼�����');" action="#{evaWageBB.reloadXishu}"/>
				<h:outputText value="  "/>
				<h:commandButton styleClass="button01" value="����" onclick="return forsave();" action="#{evaWageBB.saveXishu}"/>
			</h:panelGroup>
		 </h:panelGrid>
		 <h:panelGrid columns="1" width="98%" align="center">
		 <x:dataTable value="#{evaWageBB.xishuList}"
			headerClass="td_top" rowIndexVar="index" var="list" id="dateList"
			styleClass="table03" border="1" width="98%"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
			<h:column>
				<f:facet name="header">
					<h:outputText value="���" />
				</f:facet>
				<h:outputText value="#{index+1}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��Ч����ȼ�" />
				</f:facet>
				<h:outputText value="#{list.resultlevel}"></h:outputText>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="ϵ��" />
				</f:facet>
				<h:inputText alt="#{list.resultlevel}" code="1" dict="#{list.id}" value="#{list.xishu}" styleClass="input" size="10"/>
			</h:column>
		</x:dataTable>
		</h:panelGrid>
	</h:panelGrid>
</h:form>


