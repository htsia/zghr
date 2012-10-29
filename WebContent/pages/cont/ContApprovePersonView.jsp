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
<script type="text/javascript" language="javascript">

</script>
<body>
<h:panelGrid width="100%" border="0" cellspacing="6" cellpadding="0" >
   <h:outputText value="人员信息查看 " styleClass="td_title" style="width:100%"></h:outputText>
</h:panelGrid>
<h:form id="form1">

    <h:panelGrid width="600" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02">
         <h:outputText value="员工编号" />
         <h:outputText value="#{cont_contApproveBB.bo_contPerson.personCode}" />
         <h:outputText value="" />
         <h:outputText value="" />

         <h:outputText value="姓名" />
         <h:inputText styleClass="input" id="personName" value="#{cont_contApproveBB.bo_contPerson.personName}" maxlength="15" />

         <h:outputText value="用工类别" />
         <h:inputText styleClass="input" value="#{cont_contApproveBB.bo_contPerson.jobType}" id="jobType"  code="" dict="yes" dict_num="0135" readonly="true" />


        <h:outputText value="增员类别" />
        <h:panelGroup>
                <h:inputText styleClass="input" value="#{cont_contApproveBB.bo_contPerson.addPersonClass}" id="addPersonClass"  code="" dict="yes" dict_num="0200" readonly="true" alt="增员类别|0" />

        </h:panelGroup>

        <h:outputText value="来往单位" />
        <h:inputText styleClass="input" size="30" id="exchangeOrgName" value="#{cont_contApproveBB.bo_contPerson.exchangeOrgName}" maxlength="25" />

        <h:outputText value="性别" />
        <h:panelGroup>
                <h:inputText styleClass="input" value="#{cont_contApproveBB.bo_contPerson.personSex}" id="personSex"  code="" dict="yes" dict_num="0100" readonly="true" alt="性别|0" />

        </h:panelGroup>
        <h:outputText value="出生日期" />
        <h:panelGroup>
               <h:inputText styleClass="input" id="personBirthday" size="10" value="#{cont_contApproveBB.bo_contPerson.personBirthday}" readonly="true" alt="出生日期|0"/>

        </h:panelGroup>

        <h:outputText value="民族" />
        <h:panelGroup>
                <h:inputText styleClass="input" value="#{cont_contApproveBB.bo_contPerson.personFolk}" id="personFolk"  code="" dict="yes" dict_num="0115" readonly="true" alt="民族|0" />

        </h:panelGroup>

        <h:outputText value="政治面貌" />
        <h:panelGroup>
                <h:inputText styleClass="input" value="#{cont_contApproveBB.bo_contPerson.personPolity}" id="personPolity"  code="" dict="yes" dict_num="0120" readonly="true" alt="政治面貌|0" />

        </h:panelGroup>

        <h:outputText value="身份证号码" />
        <h:inputText styleClass="input" size="23" id="IdCard" value="#{cont_contApproveBB.bo_contPerson.idCard}" alt="身份证号码|0|s" maxlength="18"/>


        <h:outputText value="家庭居住地址" />
        <h:inputText styleClass="input" size="30" id="personHometown" value="#{cont_contApproveBB.bo_contPerson.personHometown}" maxlength="60" />

         <h:outputText value="邮政编码" />
         <h:inputText styleClass="input" id="personPostalcode" value="#{cont_contApproveBB.bo_contPerson.personPostalcode}" maxlength="6" alt="邮政编码|1|i" />
         <h:outputText value="" />
         <h:outputText value="" />

        <h:outputText value="毕业院校" />
        <h:inputText styleClass="input" id="graduateSchool" value="#{cont_contApproveBB.bo_contPerson.graduateSchool}" maxlength="20" alt="毕业院校|0" />

        <h:outputText value="毕业时间" />
        <h:panelGroup>
                 <h:inputText styleClass="input" id="graduateDate" size="10" value="#{cont_contApproveBB.bo_contPerson.graduateDate}" readonly="true" alt="毕业时间|0"/>

        </h:panelGroup>

        <h:outputText value="学历" />
        <h:panelGroup>
                 <h:inputText styleClass="input" value="#{cont_contApproveBB.bo_contPerson.personEducation}" id="personEducation"  code="" dict="yes" dict_num="0365" readonly="true" alt="学历|0" />

        </h:panelGroup>

        <h:outputText value="学位" />
        <h:panelGroup>
                <h:inputText styleClass="input" value="#{cont_contApproveBB.bo_contPerson.personDegree}" id="personDegree"  code="" dict="yes" dict_num="0380" readonly="true" alt="学位|1" />

        </h:panelGroup>

        <h:outputText value="专业名称" />
        <h:inputText styleClass="input" id="personSpeciality" value="#{cont_contApproveBB.bo_contPerson.personSpeciality}" maxlength="20"/>

        <h:outputText value="参加工作时间" />
        <h:panelGroup>
                <h:inputText styleClass="input" id="attendWorkTime" size="10" value="#{cont_contApproveBB.bo_contPerson.attendWorkTime}" readonly="true"/>

        </h:panelGroup>

        <h:outputText value="所在部门" />
        <h:panelGroup>
               <h:inputText styleClass="input" id="enterDepartmentId" value="#{cont_contApproveBB.bo_contPerson.enterDepartmentId}" code="" dict="yes" dict_num="OU" readonly="true" alt="所在部门|0"/>

        </h:panelGroup>

        <h:outputText value="所在机构" />
        <h:panelGroup>
                 <h:inputText styleClass="input" id="enterOrgId" value="#{cont_contApproveBB.bo_contPerson.enterOrgId}" code="" dict="yes" dict_num="OU" readonly="true"/>

        </h:panelGroup>

        <h:outputText value="来公司时间" />
        <h:panelGroup>
               <h:inputText styleClass="input" id="createDate" size="10" value="#{cont_contApproveBB.bo_contPerson.createDate}" readonly="true" alt="来公司时间|0"/>

        </h:panelGroup>

        <h:outputText value="创建机构" />
        <h:inputText styleClass="input" value="#{cont_contApproveBB.bo_contPerson.createOrgId}" id="createOrgId"  code="" dict="yes" dict_num="OU" readonly="true" alt="创建机构|0"/>

    </h:panelGrid>

    <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="2">

        <h:commandButton styleClass="button01" value="返回" action="#{cont_contApproveBB.forwardList}"/>
    </h:panelGrid>

</h:form>
<c:verbatim>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
</c:verbatim>
</body>
</html>