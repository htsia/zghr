<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
function test(){
	 var text5=document.all("form1:text5").value;
	 var btimes=document.all("form1:beginTimes").value;
	 var btime=document.all("form1:beginTime").value;
	 var etime=document.all("form1:endTime").value;
	    if(text5==null||text5==""){
	        alert("��ѡ��Ӧ�÷�Χ");
	        return false;
	    }
	    if(btimes==null||btimes==""){
	        alert("��ѡ������");
	        return false;
	    }
	    if(btime==null||btime==""){
	        alert("������Ԥ����ˮ");
	        return false;
	    }
	    if(etime==null||etime==""){
	        alert("������ʵ����ˮ");
	        return false;
	    }
		if (btime <= 0) {
			alert("Ԥ����ˮ��������㡣");
			return false;
		}
		if (etime <= 0) {
			alert("ʵ����ˮ��������㡣");
			return false;
		}
	    return true;
	 }
  </script>
<x:saveState value="#{setsumBB}" />
<h:form id="form1">
	<h:inputHidden id="attname" value="#{setsumBB.initEdit}"></h:inputHidden>
	<h:panelGrid columns="1" width="98%" styleClass="td_title"
		align="center">

		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="���ڹ���->������ˮ" />
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="Ӧ�÷�Χ" rendered="#{setsumBB.isExist==false}"></h:outputText>
             <h:inputText  styleClass="input"  value="#{setsumBB.bo.orguidName}" readonly="true" rendered="#{setsumBB.isExist==false}"/>
			<h:outputText value="Ӧ�÷�Χ" rendered="#{setsumBB.isExist==true}"></h:outputText>
			<h:panelGroup>
                    <h:inputText id="text5" styleClass="input"  value="#{setsumBB.bo.orguidName}" size="30" readonly="true" rendered="#{setsumBB.isExist==true}"/>
                    <h:inputHidden id="text5code" value="#{setsumBB.orgId}" />
                    <h:commandButton type="button" styleClass="button_select" onclick="PopUpMutilOnlyOrgTwoControl('form1:text5code','form1:text5','1','')" rendered="#{setsumBB.isExist==true}"/>
</h:panelGroup>
<h:outputText value="" rendered="#{setsumBB.isExist==false}"></h:outputText>
						<h:outputText value="����" />
						<h:panelGroup>
						<h:inputText styleClass="input" id="beginTimes" size="12"
							alt="ʱ��|0|d" value="#{setsumBB.attenceDate}"
							readonly="true" />
						<f:verbatim>
							<input type="button" class="button_select"
								onclick="PopUpCalendarDlg_OnlyMonth('form1:beginTimes')">
						</f:verbatim>
					</h:panelGroup>
			<h:outputText value="Ԥ����ˮ"></h:outputText>
			<h:panelGroup>
				<h:inputText id="beginTime" value="#{setsumBB.bo.forecastWater}">
				</h:inputText>
			</h:panelGroup>
			
			<h:outputText value="ʵ����ˮ"></h:outputText>
			<h:panelGroup>
				<h:inputText id="endTime" value="#{setsumBB.bo.realityWater}">
				</h:inputText>
			</h:panelGroup>
			
		</h:panelGrid>


		<h:panelGrid align="right">
			<h:commandButton value="����" onclick="return test()"
				action="#{setsumBB.save}" styleClass="button01" rendered="#{setsumBB.isExist==true}"/>
		<h:commandButton value="����"   rendered="#{setsumBB.isExist==false}"
				action="#{setsumBB.save1}" styleClass="button01" />
		</h:panelGrid>


	</h:panelGrid>
</h:form>


