<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0);
%>
<%@ include file="/pages/include/taglib.jsp" %>


<f:verbatim>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
<script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>

		<script>
		    function checkDate(){
		    var endDate = document.forms['content:form1'].elements['content:form1:endTime'].value;
		    var startDate = document.forms['content:form1'].elements['content:form1:beginTime'].value;
		    if(startDate==null||startDate==""||endDate==null||endDate==""){
		      alert("\u8bf7\u8f93\u5165\u521d\u59cb\u65e5\u671f\u548c\u622a\u6b62\u65e5\u671f");
		      return false;
		    }else if(startDate>endDate){
		      alert("\u8bf7\u91cd\u65b0\u8f93\u5165\u521d\u59cb\u65e5\u671f\u548c\u622a\u6b62\u65e5\u671f\uff08\u521d\u59cb\u65e5\u671f<=\u622a\u6b62\u65e5\u671f\uff09");
		      return false;
		    }
		    else
		      return true;
		 }     
		</script>

</f:verbatim>


<h:form id="form1">
<h:inputHidden value="#{self_querypercostbb.initHid_ManpowerCostAllQuery}"/>
	<h:panelGrid width="600" columns="4" border="1" align="center"
	styleClass="h_css_form"
	rowClasses="h_css_td_6,h_css_td_7"
	columnClasses="h_css_td_5,h_css_td_5,h_css_td_5,h_css_td_5"cellpadding="3" >

		<h:outputText value="按月份查询人力成本归结明细" />
		<h:outputText value="按时间段查询人力成本汇总情况" />
		<h:panelGroup>
			<h:selectOneMenu value="#{self_querypercostbb.year}" id="abc">
				<f:selectItems value="#{self_querypercostbb.years}" />
			</h:selectOneMenu>

			<h:outputText value=" " />
			<h:selectOneMenu value="#{self_querypercostbb.month}">
				<f:selectItem itemLabel="一月" itemValue="01" />
				<f:selectItem itemLabel="二月" itemValue="02" />
				<f:selectItem itemLabel="三月" itemValue="03" />
				<f:selectItem itemLabel="四月" itemValue="04" />
				<f:selectItem itemLabel="五月" itemValue="05" />
				<f:selectItem itemLabel="六月" itemValue="06" />
				<f:selectItem itemLabel="七月" itemValue="07" />
				<f:selectItem itemLabel="八月" itemValue="08" />
				<f:selectItem itemLabel="九月" itemValue="09" />
				<f:selectItem itemLabel="十月" itemValue="10" />
				<f:selectItem itemLabel="十一月" itemValue="11" />
				<f:selectItem itemLabel="十二月" itemValue="12" />
			</h:selectOneMenu>
			<h:outputText value=" " />
			<h:commandButton value="查询" styleClass="button"
				action="#{self_querypercostbb.queryPerPayMon}" />
		</h:panelGroup>

		<h:panelGroup>
		<h:outputText value="开始时间" />
		
        <h:panelGroup>
               <h:inputText styleClass="input" id="beginTime" size="12" alt="开始时间|0|s" value="#{self_querypercostbb.beginTime}" readonly="true"/>
               <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('content:form1:beginTime')"></f:verbatim>
        </h:panelGroup>
        
		</h:panelGroup>
		
		<h:panelGroup>
		<h:outputText value="结束时间" />
		
		<h:panelGroup>
               <h:inputText styleClass="input" id="endTime" alt="结束时间|0|s" size="12" value="#{self_querypercostbb.endTime}" readonly="true"/>
               <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('content:form1:endTime')"></f:verbatim>
        </h:panelGroup>
        
		</h:panelGroup>
		
		<h:commandButton value="查询" onclick ="return checkDate();" styleClass="button" action="#{self_querypercostbb.queryPersonCostByTimeArea}" />
	</h:panelGrid>
		
	<f:verbatim>
		<br>
	</f:verbatim>
		<h:panelGrid columns="1" align="center" width="95%"
		 cellpadding="5">
	
	<h:panelGrid columns="2" align="center" width="95%">
		<h:outputText value="人力成本项目查询" style="font-weight:bold;font-size:12pt" />
		<h:outputText value="#{self_querypercostbb.curMon}" style="font-weight:bold" />
		</h:panelGrid>
		
	<x:dataTable rowIndexVar="index" id="userdata" width="100%" align="center" 
			 value="#{self_querypercostbb.perCostList}" var="perCostList" styleClass="h_css_orders"	cellpadding="4"
		 headerClass="h_css_ordersHeader" border="1" columnClasses="h_css_Column1,h_css_Column2,h_css_Column3">			
		    <h:column>
				<f:facet name="header">
					<h:outputText value="序号"></h:outputText>
				</f:facet>
				<h:outputText value="#{index+1}" style="#{perCostList[3]}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="人力成本项目"></h:outputText>
				</f:facet>
				<h:outputText value="#{perCostList[0]}" style="#{perCostList[3]}"/>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="金额"></h:outputText>
				</f:facet>
				<h:outputText value="#{perCostList[1]}" style="#{perCostList[3]}"/>
			</h:column>			
		</x:dataTable>
			</h:panelGrid>


</h:form>

