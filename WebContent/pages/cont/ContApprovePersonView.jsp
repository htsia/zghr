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
   <h:outputText value="��Ա��Ϣ�鿴 " styleClass="td_title" style="width:100%"></h:outputText>
</h:panelGrid>
<h:form id="form1">

    <h:panelGrid width="600" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02">
         <h:outputText value="Ա�����" />
         <h:outputText value="#{cont_contApproveBB.bo_contPerson.personCode}" />
         <h:outputText value="" />
         <h:outputText value="" />

         <h:outputText value="����" />
         <h:inputText styleClass="input" id="personName" value="#{cont_contApproveBB.bo_contPerson.personName}" maxlength="15" />

         <h:outputText value="�ù����" />
         <h:inputText styleClass="input" value="#{cont_contApproveBB.bo_contPerson.jobType}" id="jobType"  code="" dict="yes" dict_num="0135" readonly="true" />


        <h:outputText value="��Ա���" />
        <h:panelGroup>
                <h:inputText styleClass="input" value="#{cont_contApproveBB.bo_contPerson.addPersonClass}" id="addPersonClass"  code="" dict="yes" dict_num="0200" readonly="true" alt="��Ա���|0" />

        </h:panelGroup>

        <h:outputText value="������λ" />
        <h:inputText styleClass="input" size="30" id="exchangeOrgName" value="#{cont_contApproveBB.bo_contPerson.exchangeOrgName}" maxlength="25" />

        <h:outputText value="�Ա�" />
        <h:panelGroup>
                <h:inputText styleClass="input" value="#{cont_contApproveBB.bo_contPerson.personSex}" id="personSex"  code="" dict="yes" dict_num="0100" readonly="true" alt="�Ա�|0" />

        </h:panelGroup>
        <h:outputText value="��������" />
        <h:panelGroup>
               <h:inputText styleClass="input" id="personBirthday" size="10" value="#{cont_contApproveBB.bo_contPerson.personBirthday}" readonly="true" alt="��������|0"/>

        </h:panelGroup>

        <h:outputText value="����" />
        <h:panelGroup>
                <h:inputText styleClass="input" value="#{cont_contApproveBB.bo_contPerson.personFolk}" id="personFolk"  code="" dict="yes" dict_num="0115" readonly="true" alt="����|0" />

        </h:panelGroup>

        <h:outputText value="������ò" />
        <h:panelGroup>
                <h:inputText styleClass="input" value="#{cont_contApproveBB.bo_contPerson.personPolity}" id="personPolity"  code="" dict="yes" dict_num="0120" readonly="true" alt="������ò|0" />

        </h:panelGroup>

        <h:outputText value="���֤����" />
        <h:inputText styleClass="input" size="23" id="IdCard" value="#{cont_contApproveBB.bo_contPerson.idCard}" alt="���֤����|0|s" maxlength="18"/>


        <h:outputText value="��ͥ��ס��ַ" />
        <h:inputText styleClass="input" size="30" id="personHometown" value="#{cont_contApproveBB.bo_contPerson.personHometown}" maxlength="60" />

         <h:outputText value="��������" />
         <h:inputText styleClass="input" id="personPostalcode" value="#{cont_contApproveBB.bo_contPerson.personPostalcode}" maxlength="6" alt="��������|1|i" />
         <h:outputText value="" />
         <h:outputText value="" />

        <h:outputText value="��ҵԺУ" />
        <h:inputText styleClass="input" id="graduateSchool" value="#{cont_contApproveBB.bo_contPerson.graduateSchool}" maxlength="20" alt="��ҵԺУ|0" />

        <h:outputText value="��ҵʱ��" />
        <h:panelGroup>
                 <h:inputText styleClass="input" id="graduateDate" size="10" value="#{cont_contApproveBB.bo_contPerson.graduateDate}" readonly="true" alt="��ҵʱ��|0"/>

        </h:panelGroup>

        <h:outputText value="ѧ��" />
        <h:panelGroup>
                 <h:inputText styleClass="input" value="#{cont_contApproveBB.bo_contPerson.personEducation}" id="personEducation"  code="" dict="yes" dict_num="0365" readonly="true" alt="ѧ��|0" />

        </h:panelGroup>

        <h:outputText value="ѧλ" />
        <h:panelGroup>
                <h:inputText styleClass="input" value="#{cont_contApproveBB.bo_contPerson.personDegree}" id="personDegree"  code="" dict="yes" dict_num="0380" readonly="true" alt="ѧλ|1" />

        </h:panelGroup>

        <h:outputText value="רҵ����" />
        <h:inputText styleClass="input" id="personSpeciality" value="#{cont_contApproveBB.bo_contPerson.personSpeciality}" maxlength="20"/>

        <h:outputText value="�μӹ���ʱ��" />
        <h:panelGroup>
                <h:inputText styleClass="input" id="attendWorkTime" size="10" value="#{cont_contApproveBB.bo_contPerson.attendWorkTime}" readonly="true"/>

        </h:panelGroup>

        <h:outputText value="���ڲ���" />
        <h:panelGroup>
               <h:inputText styleClass="input" id="enterDepartmentId" value="#{cont_contApproveBB.bo_contPerson.enterDepartmentId}" code="" dict="yes" dict_num="OU" readonly="true" alt="���ڲ���|0"/>

        </h:panelGroup>

        <h:outputText value="���ڻ���" />
        <h:panelGroup>
                 <h:inputText styleClass="input" id="enterOrgId" value="#{cont_contApproveBB.bo_contPerson.enterOrgId}" code="" dict="yes" dict_num="OU" readonly="true"/>

        </h:panelGroup>

        <h:outputText value="����˾ʱ��" />
        <h:panelGroup>
               <h:inputText styleClass="input" id="createDate" size="10" value="#{cont_contApproveBB.bo_contPerson.createDate}" readonly="true" alt="����˾ʱ��|0"/>

        </h:panelGroup>

        <h:outputText value="��������" />
        <h:inputText styleClass="input" value="#{cont_contApproveBB.bo_contPerson.createOrgId}" id="createOrgId"  code="" dict="yes" dict_num="OU" readonly="true" alt="��������|0"/>

    </h:panelGrid>

    <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="2">

        <h:commandButton styleClass="button01" value="����" action="#{cont_contApproveBB.forwardList}"/>
    </h:panelGrid>

</h:form>
<c:verbatim>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
</c:verbatim>
</body>
</html>