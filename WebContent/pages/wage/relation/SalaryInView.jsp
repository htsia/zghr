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
    <h:outputText  value="����"/>
    <h:outputText  value="#{wage_salaryRelationBB.salaryrelation.persName}"/>
     
    <h:outputText  value="������λ"/>
    <h:outputText id="fromUnit"  value="#{wage_salaryRelationBB.salaryrelation.fromUnitName}"/>

    <h:outputText  value="���뵥λ"/>
    <h:outputText id="toUnit" value="#{wage_salaryRelationBB.salaryrelation.toUnitName}"/>
 
    <h:outputText  value="�����ѷ���"/>
    <h:outputText id="endDate" value="#{wage_salaryRelationBB.salaryrelation.payEndDate}"/>

    <h:outputText  value="���µ�λ��"/>
    <h:outputText id="startDate" value="#{wage_salaryRelationBB.salaryrelation.payStartDate}"/>

    <h:outputText value="��ע"/>
    <h:outputText value="#{wage_salaryRelationBB.salaryrelation.remark}"/>
</h:panelGrid>

 <br />
<center>
  <h:dataTable styleClass="table03" columnClasses="td_form02" width="80%" value="#{wage_salaryRelationBB.salaryrelationinvos}" var="list" border="1">
      <h:column>
          <f:facet name="header"><h:outputText value="ת����Ŀ" styleClass="td03"/></f:facet>
          <f:verbatim escape="false"><div align="center"></f:verbatim><h:outputText value="#{list.transferItem}"/><f:verbatim></div></f:verbatim>
      </h:column>
      <h:column>
          <f:facet name="header"><h:outputText value="����" styleClass="td03"/></f:facet>
          <f:verbatim escape="false"><div align="center"></f:verbatim><h:outputText value="#{list.basicNum}"/><f:verbatim></div></f:verbatim>
      </h:column>
      <h:column>
          <f:facet name="header"><h:outputText value="�ɷѽ���ʱ��" styleClass="td03"/></f:facet>
          <f:verbatim escape="false"><div align="center">
              <h:outputText  id="endDate" value="#{list.costEndDate}"/>
          </div></f:verbatim>
      </h:column>
  </h:dataTable>
   </center>
<br>
<h:panelGrid align="center" cellpadding="2" cellspacing="2" columns="4">
    <h:commandButton styleClass="button01" value="ȷ��ת��" onclick="return confirm('�Ƿ�ȷ��ת��?');"  action="#{wage_salaryRelationBB.transferPerson}"/>
     <h:commandButton styleClass="button01" value="ȡ��ת��" onclick="return confirm('�Ƿ�ȡ��ת��?');" action="#{wage_salaryRelationBB.cancelPerson}"/>
     <h:commandButton styleClass="button01" value="�鿴������" onclick="forView(#{wage_salaryRelationBB.salaryrelation.persId},#{wage_salaryRelationBB.salaryrelation.fromUnit},#{wage_salaryRelationBB.salaryrelation.toUnit});return false;" />
    <h:commandButton styleClass="button01" value="����" onclick="location='SalaryInList.jsf?act=In';return false;"/>
</h:panelGrid>
</h:form>
</body>
</html>
