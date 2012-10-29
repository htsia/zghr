<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

<% response.setHeader("Content-type","application/vnd.ms-excel");%>
<% response.setHeader("Content-Disposition","filename=_gzt.xls"); %>

<html>
<f:view>
<head>

 <meta http-equiv="Content-Type" content="text/html" />
 <style type="text/css">
	.listClass {
	font-size: 9pt;
	cursor: default;
	border-collapse: collapse;
	border: .5pt solid #000000;
				}
	.listTop {
	border: .5pt solid #000000;
 	 text-align: center;
	}
	.listTd_1 {
	border: .5pt solid #000000;
 	 text-align: center;
 	 width: 158pt;

	}
	.listTd_2 {
	border: .5pt solid #000000;
	  text-align: left;
	width: 238pt;
	}
	.listTd_3 {
		border: .5pt solid #000000;
 	 text-align: right;
	width: 164pt;
	}
 </style>
</head>

<body leftmargin="20">
<x:saveState id="bb"  value="#{self_querypaybb}"/>
<h:form>
<table width="600"  border="0">
  <tr>
  <td colspan="3" align="center" style="font-weight:bold;font-size:12pt">工资发放情况</td>
 </tr>
</table>
<table width="600"  border="0">
  <tr>
  <td colspan="2" align="left" style="font-size:9pt;"><h:outputText value="姓名:#{self_querypaybb.name}"/> <h:outputText value="部门:#{self_querypaybb.perUnit}"/></td>
  <td colspan="1" align="left" style="font-size:9pt;"><h:outputText value="#{self_querypaybb.curMon}发薪"/></td>

 </tr>
</table>

<x:dataTable rowIndexVar="index" id="userdata" width="100%" align="center"
			 value="#{self_querypaybb.payPrintList}" var="paylist" styleClass="listClass"	cellpadding="4"
		 headerClass="listTop"	 border="1" columnClasses="listTd_1,listTd_2,listTd_3">
		    <h:column>
				<f:facet name="header">
					<h:outputText value="序号"></h:outputText>
				</f:facet>
				<h:outputText value="#{index+1}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="发薪项目"></h:outputText>
				</f:facet>
				<h:outputText value="#{paylist[0]}"  />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="发薪金额总计"></h:outputText>
				</f:facet>
				<h:outputText value="#{paylist[1]}"  />
			</h:column>
		</x:dataTable>
</h:form>
</body>
</f:view>
</html>