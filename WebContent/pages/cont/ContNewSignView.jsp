<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
<title></title>
</head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
<script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
<script language="javascript">

</script>
<body>
<h:panelGrid width="100%" border="0" cellspacing="6" cellpadding="0" >
   <h:outputText value="合同新签查看 " styleClass="td_title" style="width:100%"></h:outputText>
</h:panelGrid>
<h:form id="form1">
<h:inputHidden id="str" value="#{cont_contNewSignBB.selectNewPersonIds}"/>
<h:inputHidden id="str_2" value="#{cont_contNewSignBB.selectContIds}"/>
<h:inputHidden id="init_b" value="#{cont_contNewSignBB.init_b}"/>
<h:panelGrid  border="0"  align="center" columns="1" width="800">
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <c:verbatim escape="false"><a href="javascript:showHide(ryTable);"><b>  人员信息</b></a></c:verbatim>
    </h:panelGrid>
</h:panelGrid>
<center>
<table id="ryTable" width="800" border="0" align="center">
  <tr><td>
<x:dataTable value="#{cont_contNewSignBB.bos_contPerson}" var="list"  rowIndexVar="index"
                     headerClass="td_top"
                     rowClasses="td_middle" styleClass="table03" width="800" border="1">

            <h:column>
                <c:facet name="header"><h:outputText value="序号"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="人员编号"/></c:facet>
                <h:outputText value="#{list.personCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="性别"/></c:facet>
                <h:outputText value="#{list.personSex}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="身份证号码"/></c:facet>
                <h:outputText value="#{list.idCard}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="所在机构"/></c:facet>
                <h:outputText value="#{list.enterOrgId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="入系统时间"/></c:facet>
                <h:outputText value="#{list.createDate}"/>
            </h:column>
             <h:column>
                <c:facet name="header"><h:outputText value="用工类别"/></c:facet>
                <h:outputText value="#{list.jobType}"/>
            </h:column>

</x:dataTable>
    </td></tr>
</table>
</center>
<br/>
<h:panelGrid  border="0"  cellpadding="0"  cellspacing="0"  align="center" columns="1" width="800">
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <h:outputText value="录入信息" styleClass="td05"/>
    </h:panelGrid>
</h:panelGrid>

<h:inputHidden id="contId" value="#{cont_contNewSignBB.bo.contId}"/>
<h:inputHidden id="contCode" value="#{cont_contNewSignBB.bo.contCode}"/>
<h:inputHidden id="personId" value="#{cont_contNewSignBB.bo.contPersonBO.personId}"/>
<h:inputHidden id="attachmentId" value="#{cont_contNewSignBB.bo.attachmentId}"/>
<h:inputHidden id="approveStatus" value="#{cont_contNewSignBB.bo.approveStatus}"/>
<h:inputHidden id="uptoValidDate" value="#{cont_contNewSignBB.bo.uptoValidDate}"/>
<h:inputHidden id="approveRemark" value="#{cont_contNewSignBB.bo.approveRemark}"/>
<h:inputHidden id="approveDate" value="#{cont_contNewSignBB.bo.approveDate}"/>
<h:inputHidden id="approveOrgId" value="#{cont_contNewSignBB.bo.approveOrgId}"/>
<h:inputHidden id="approvePersonId" value="#{cont_contNewSignBB.bo.approvePersonId}"/>
<h:inputHidden id="createOrgId" value="#{cont_contNewSignBB.bo.createOrgId}"/>
<h:inputHidden id="isValid" value="#{cont_contNewSignBB.bo.isValid}"/>

<h:panelGrid width="800" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02">
         <h:outputText value="合同编号" />
         <h:outputText value="#{cont_contNewSignBB.bo.contCode}"/>
         <h:outputText  value="模板类别" />
         <h:selectOneMenu value="#{cont_contNewSignBB.bo.templateClassId}" id="templateClassId" onchange="javascript:pageCodeExchange(document.forms(0));submit(); "  valueChangeListener="#{cont_contNewSignBB.templateClassChanged}">
                    <c:selectItems value="#{cont_contNewSignBB.item_templateClass}"/>
         </h:selectOneMenu>

         <h:outputText value="合同处理类别" />
         <h:inputText styleClass="input" value="#{cont_contNewSignBB.bo.contClass}" id="contClass"  code="" dict="yes" dict_num="0220" readonly="true" alt="合同处理类别|0"/>

         <h:outputText value="合同模板" />
         <h:panelGroup>
         <h:selectOneMenu value="#{cont_contNewSignBB.bo.templateId}" id="templateId" >
                    <c:selectItems value="#{cont_contNewSignBB.item_template}"/>
         </h:selectOneMenu>
         </h:panelGroup>

         <h:outputText value="合同期限类型" />
         <h:panelGroup>
             <h:inputText styleClass="input" value="#{cont_contNewSignBB.bo.contTermClass}" id="contTermClass"  code="" dict="yes" dict_num="0215" readonly="true" />
            
         </h:panelGroup>
         <h:outputText value="" />
         <h:outputText value="" />

         <h:outputText value="合同约定起始时间" />
         <h:panelGroup>
             <h:inputText id="contStartDate" styleClass="input" size="10" value="#{cont_contNewSignBB.bo.contStartDate}" readonly="true"/>

         </h:panelGroup>

         <h:outputText value="合同约定终止时间" />
         <h:panelGroup>
            <h:inputText id="contEndDate" styleClass="input" size="10" value="#{cont_contNewSignBB.bo.contEndDate}" readonly="true" />

         </h:panelGroup>

         <h:outputText value="合同约定见习期终止时间" />
         <h:panelGroup>
            <h:inputText id="praxisEndDate" styleClass="input" size="10" value="#{cont_contNewSignBB.bo.praxisEndDate}" readonly="true"/>
        </h:panelGroup>

         <h:outputText value="合同约定试用期终止时间" />
         <h:panelGroup>
             <h:inputText id="probationEndDate" styleClass="input" size="10" value="#{cont_contNewSignBB.bo.probationEndDate}" readonly="true" />

         </h:panelGroup>

         <h:outputText value="合同约定工作地点" />
         <h:inputTextarea id="workPlace" rows="2" cols="28"   value="#{cont_contNewSignBB.bo.workPlace}"/>

         <h:outputText value="合同约定工作内容" />
         <h:inputTextarea id="workContent" rows="2" cols="28"   value="#{cont_contNewSignBB.bo.workContent}"/>

         <h:outputText value="合同约定岗位名称" />
         <h:inputText styleClass="input" id="postName" size = "30" maxlength="15" value="#{cont_contNewSignBB.bo.postName}" />

         <h:outputText  value="合同约定工时制度" />
         <h:panelGroup>
             <h:inputText styleClass="input" value="#{cont_contNewSignBB.bo.workTimeSet}" id="workTimeSet"  size="28"  code="" dict="yes" dict_num="2024" readonly="true" />
         </h:panelGroup>

         <h:outputText  value="服务期起始时间" />
         <h:panelGroup>
             <h:inputText id="serviceStartDate" styleClass="input" size="10" value="#{cont_contNewSignBB.bo.serviceStartDate}" readonly="true"/>
        </h:panelGroup>

         <h:outputText  value="服务期终止时间" />
         <h:panelGroup>
            <h:inputText id="serviceEndDate" styleClass="input" size="10" value="#{cont_contNewSignBB.bo.serviceEndDate}" readonly="true" />
         </h:panelGroup>

         <h:outputText value="合同约定劳动报酬形式" />
         <h:panelGroup>
            <h:inputTextarea id="salaryClass" rows="2" cols="28"   value="#{cont_contNewSignBB.bo.salaryClass}"/>
         </h:panelGroup>
         <h:outputText value="合同约定工资构成" />
         <h:panelGroup>
            <h:inputTextarea id="salaryInclude" rows="2" cols="28"   value="#{cont_contNewSignBB.bo.salaryInclude}"/>
         </h:panelGroup>

         <h:outputText value="合同约定发薪日" />
         <h:inputText styleClass="input" id="paySalaryDate"  size = "30" maxlength="30" value="#{cont_contNewSignBB.bo.paySalaryDate}" alt="合同约定发薪日|1|s" />
         <h:outputText value="试用期工资标准" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="probationSalaryMoney" value="#{cont_contNewSignBB.bo.probationSalaryMoney}" maxlength="10" alt="试用期工资标准|1|f" />
            <h:outputText value=" 元/月" />
         </h:panelGroup>

         <h:outputText value="工资标准" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="standardSalaryMoney" value="#{cont_contNewSignBB.bo.standardSalaryMoney}" maxlength="10" alt="工资标准|1|f" />
            <h:outputText value=" 元/月" />
         </h:panelGroup>
         <h:outputText value="基本工资标准" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="basicSalaryMoney" value="#{cont_contNewSignBB.bo.basicSalaryMoney}" maxlength="10" alt="基本工资标准|1|f" />
            <h:outputText value=" 元/月" />
         </h:panelGroup>

         <h:outputText value="绩效工资标准" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="performanceSalaryMoney" value="#{cont_contNewSignBB.bo.performanceSalaryMoney}" maxlength="10" alt="绩效工资标准|1|f" />
            <h:outputText value=" 元/月" />
         </h:panelGroup>
         <h:outputText value="" />
         <h:outputText value="" />

         <h:outputText value="竞业限制期限" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="jobLimitTerm" value="#{cont_contNewSignBB.bo.jobLimitTerm}" maxlength="10" alt="竞业限制期限|1|i" />
            <h:outputText value=" 月" />
         </h:panelGroup>
         <h:outputText value="合同违约金额" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="fellbackMoney" value="#{cont_contNewSignBB.bo.fellbackMoney}" maxlength="10" alt="合同违约金额|1|f" />
            <h:outputText value=" 元" />
         </h:panelGroup>


         <h:outputText value="劳动合同摘要" />
         <h:panelGroup>
             <h:inputTextarea id="contRemark" rows="3" cols="28"  value="#{cont_contNewSignBB.bo.contRemark}"/>
         </h:panelGroup>
         <h:outputText value="是否同意鉴证" />
         <h:panelGroup>
             <h:inputText value="#{cont_contNewSignBB.bo.agreeTestify}" id="agreeTestify" styleClass="input"  code="" dict="yes" dict_num="2023" readonly="true" />
             
         </h:panelGroup>

</h:panelGrid>
     <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="2">
                <h:commandButton styleClass="button01" value="返回" action="#{cont_contNewSignBB.forwardList}"/>
     </h:panelGrid>

</h:form>
<c:verbatim>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
</c:verbatim>
</body>
</html>