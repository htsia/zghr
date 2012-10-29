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
	        alert("请选择应用范围");
	        return false;
	    }
	    if(btimes==null||btimes==""){
	        alert("请选择日期");
	        return false;
	    }
	    if(btime==null||btime==""){
	        alert("请输入预测流水");
	        return false;
	    }
	    if(etime==null||etime==""){
	        alert("请输入实际流水");
	        return false;
	    }
		if (btime <= 0) {
			alert("预测流水必须大于零。");
			return false;
		}
		if (etime <= 0) {
			alert("实际流水必须大于零。");
			return false;
		}
	    return true;
	 }
  </script>
<x:saveState value="#{setweeksumBB}" />
<h:form id="form1">
	<h:inputHidden id="attname" value="#{setweeksumBB.initEdit}"></h:inputHidden>
	<h:panelGrid columns="1" width="98%" styleClass="td_title"
		align="center">

		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理->新增流水" />
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="应用范围" rendered="#{setweeksumBB.isExist==false}"></h:outputText>
             <h:inputText  styleClass="input"  value="#{setweeksumBB.bo.orguidName}" readonly="true" rendered="#{setweeksumBB.isExist==false}"/>
			<h:outputText value="应用范围" rendered="#{setweeksumBB.isExist==true}"></h:outputText>
			<h:panelGroup>
                    <h:inputText id="text5" styleClass="input"  value="#{setweeksumBB.bo.orguidName}" size="30" readonly="true" rendered="#{setweeksumBB.isExist==true}"/>
                    <h:inputHidden id="text5code" value="#{setweeksumBB.orgId}" />
                    <h:commandButton type="button" styleClass="button_select" onclick="PopUpMutilOnlyOrgTwoControl('form1:text5code','form1:text5','1','')" rendered="#{setweeksumBB.isExist==true}"/>
</h:panelGroup>
<h:outputText value="" rendered="#{setweeksumBB.isExist==false}"></h:outputText>
						<h:outputText value="年月" />
						<h:panelGroup>
						<h:inputText styleClass="input" id="beginTimes" size="12"
							alt="时间|0|d" value="#{setweeksumBB.attenceDate}"
							readonly="true" />
						<f:verbatim>
							<input type="button" class="button_select"
								onclick="PopUpCalendarDlg_OnlyMonth('form1:beginTimes')">
						</f:verbatim>
					</h:panelGroup>
		
			<h:outputText value="第几周"></h:outputText>
			<h:panelGroup>
			<h:selectOneRadio value="#{setweeksumBB.setStatus}" valueChangeListener="#{setweeksumBB.changeSetStatus}"
				onclick="submit();">
				<f:selectItem itemValue="1" itemLabel="第1周" />
				<f:selectItem itemValue="2" itemLabel="第2周" />
				<f:selectItem itemValue="3" itemLabel="第3周" />
				<f:selectItem itemValue="4" itemLabel="第4周" />
				<f:selectItem itemValue="5" itemLabel="第5周" />
			</h:selectOneRadio>
			</h:panelGroup>			
					
			<h:outputText value="预测流水"></h:outputText>
			<h:panelGroup>
				<h:inputText id="beginTime" value="#{setweeksumBB.bo.forecastWater}">
				</h:inputText>
			</h:panelGroup>
			
			<h:outputText value="实际流水"></h:outputText>
			<h:panelGroup>
				<h:inputText id="endTime" value="#{setweeksumBB.bo.realityWater}">
				</h:inputText>
			</h:panelGroup>
			
		</h:panelGrid>


		<h:panelGrid align="right">
			<h:commandButton value="保存" onclick="return test()"
				action="#{setweeksumBB.save}" styleClass="button01" rendered="#{setweeksumBB.isExist==true}"/>
		<h:commandButton value="保存"   rendered="#{setweeksumBB.isExist==false}"
				action="#{setweeksumBB.save1}" styleClass="button01" />
		</h:panelGrid>


	</h:panelGrid>
</h:form>


