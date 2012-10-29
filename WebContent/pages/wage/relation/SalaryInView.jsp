<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
<html>
<head>
<title></title>
<script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
<script language=javascript src="<%=request.getContextPath()%>/js/check.js"></script>
<script language=javascript src="<%=request.getContextPath()%>/js/checkAll.js"></script>
<script type="text/javascript">
    function forView(id,unitId,toUnit){
        windowOpen("/pages/wage/relation/IntroLetterIn.jsp?Id="+id+"&UnitId="+unitId+"&toUnit="+toUnit, '', '','500', '200', 'yes', '250', '250', 'yes') ;
    }

</script>
</head>
<body>
<h:form id="form1">
<x:saveState value="#{wage_salaryRelationBB}"/>
<h:inputHidden id="personId" value="#{wage_salaryRelationBB.personId}"/>
<br />
<h:panelGrid width="50%" align="center"  cellpadding="0" border="1" cellspacing="0" styleClass="table03" columns="2" columnClasses="td_form01,td_form02">
    <h:outputText  value="姓名"/>
    <h:outputText  value="#{wage_salaryRelationBB.salaryrelation.persName}"/>
     
    <h:outputText  value="调出单位"/>
    <h:outputText id="fromUnit"  value="#{wage_salaryRelationBB.salaryrelation.fromUnitName}"/>

    <h:outputText  value="调入单位"/>
    <h:outputText id="toUnit" value="#{wage_salaryRelationBB.salaryrelation.toUnitName}"/>
 
    <h:outputText  value="工资已发至"/>
    <h:outputText id="endDate" value="#{wage_salaryRelationBB.salaryrelation.payEndDate}"/>

    <h:outputText  value="请新单位自"/>
    <h:outputText id="startDate" value="#{wage_salaryRelationBB.salaryrelation.payStartDate}"/>

    <h:outputText value="备注"/>
    <h:outputText value="#{wage_salaryRelationBB.salaryrelation.remark}"/>
</h:panelGrid>

 <br />
<center>
  <h:dataTable styleClass="table03" columnClasses="td_form02" width="80%" value="#{wage_salaryRelationBB.salaryrelationinvos}" var="list" border="1">
      <h:column>
          <f:facet name="header"><h:outputText value="转移项目" styleClass="td03"/></f:facet>
          <f:verbatim escape="false"><div align="center"></f:verbatim><h:outputText value="#{list.transferItem}"/><f:verbatim></div></f:verbatim>
      </h:column>
      <h:column>
          <f:facet name="header"><h:outputText value="基数" styleClass="td03"/></f:facet>
          <f:verbatim escape="false"><div align="center"></f:verbatim><h:outputText value="#{list.basicNum}"/><f:verbatim></div></f:verbatim>
      </h:column>
      <h:column>
          <f:facet name="header"><h:outputText value="缴费截至时间" styleClass="td03"/></f:facet>
          <f:verbatim escape="false"><div align="center">
              <h:outputText  id="endDate" value="#{list.costEndDate}"/>
          </div></f:verbatim>
      </h:column>
  </h:dataTable>
   </center>
<br>
<h:panelGrid align="center" cellpadding="2" cellspacing="2" columns="4">
    <h:commandButton styleClass="button01" value="确认转入" onclick="return confirm('是否确认转入?');"  action="#{wage_salaryRelationBB.transferPerson}"/>
     <h:commandButton styleClass="button01" value="取消转入" onclick="return confirm('是否取消转入?');" action="#{wage_salaryRelationBB.cancelPerson}"/>
     <h:commandButton styleClass="button01" value="查看介绍信" onclick="forView(#{wage_salaryRelationBB.salaryrelation.persId},#{wage_salaryRelationBB.salaryrelation.fromUnit},#{wage_salaryRelationBB.salaryrelation.toUnit});return false;" />
    <h:commandButton styleClass="button01" value="返回" onclick="location='SalaryInList.jsf?act=In';return false;"/>
</h:panelGrid>
</h:form>
</body>
</html>
