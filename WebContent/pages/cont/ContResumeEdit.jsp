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
function checkSubmit(form1) {
        flag = true;

        var myFileId = form1.all("form1:myFileId").value;
        var templateClassId = form1.all("form1:templateClassId").value;
        var templateId = form1.all("form1:templateId").value;

        if ( (myFileId == "" || myFileId == null) && (templateId == "" || templateId == null) ) {
             alert("��ѡ��һ��Э��ģ����ϴ�һ������ģ���ļ���");
             flag = false;
             return flag;

        }
        if ( (myFileId != "" && myFileId != null) && (templateId != "" && templateId != null) ) {
             alert("��ȷ���㽫ʹ��Э��ģ�廹���ϴ��ı���ģ���ļ�������ֻ��ѡ��һ��");
             flag = false;
             return flag;

        }
        if (templateId != "" && templateId != null) {
            if (templateClassId == "" || templateClassId == null) {
               alert("ģ�������Ϊ�գ�");
               flag = false;
               return flag;
            }
        }
        if (myFileId != "" && myFileId != null) {
             if( myFileId.lastIndexOf(".rtf")==-1 ){
                alert("�ϴ�ģ���ļ�������*.rtf��ʽ�ļ���");
                flag = false;
                return flag;
             }
        }

        var contRemark = form1.all("form1:contRemark").value;
        if (contRemark != "" && contRemark != null) {
            if (name.length>50) {
                alert("Э��ժҪ���������ֻ������50�����֣�");
                flag = false;
                return flag;
            }
        }
         return flag;
}
var flag=0 ;
function showHide(obj){
	if(flag==0){
		obj.style.display="none";
		flag=1;
	}else{
		obj.style.display="";
		flag = 0;
	}
}
function confirmSave(form1){
        if (confirm('Э������ı���ʹ�õ�ǰЭ��ģ�塢��Ա��Э����Ϣ�������ɣ�ȷ��Ҫ��������')) {
            pageCodeExchange(form1);
            return true;
        } else {
            return false;
        }
}
function forView(form, id, type) {
    window.open("/cont/ContQueryHistory.jsf?displayFlag=false&personId=" + id ,"","left=50,top=50,height=400,width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=yes")
   }
</script>
<body>
<h:panelGrid width="100%" border="0" cellspacing="6" cellpadding="0" >
   <h:outputText value="�ָ�����Э��ά�� " styleClass="td_title" style="width:100%"></h:outputText>
</h:panelGrid>
<h:form id="form1" enctype="multipart/form-data" >
<h:inputHidden id="str" value="#{cont_contResumeBB.selectPauseContIds}"/>
<h:inputHidden id="init_b" value="#{cont_contResumeBB.init_b}"/>
<h:inputHidden id="str_2" value="#{cont_contResumeBB.selectContIds}"/>
<h:panelGrid  border="0"  align="center" columns="1" width="800">
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <c:verbatim escape="false"><a href="javascript:showHide(ryTable);"><b>  ��Ա��Ϣ</b></a></c:verbatim>
    </h:panelGrid>
</h:panelGrid>
<center>
<table id="ryTable" width="800" border="0" align="center">
  <tr><td>
<x:dataTable value="#{cont_contResumeBB.bos_contPause}" var="list"  rowIndexVar="index"
                     headerClass="td_top"
                     rowClasses="td_middle" styleClass="table03" width="800" border="1">

            <h:column>
                <c:facet name="header"><h:outputText value="���"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <c:verbatim escape="false"><A  href="javascript:forView('','</c:verbatim><h:outputText value="#{list.personId}"/><c:verbatim escape="false">','')" ></c:verbatim>
                <h:outputText value="#{list.personName}" />
                <c:verbatim escape="false"></A></c:verbatim>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�Ա�"/></c:facet>
                <h:outputText value="#{list.contPersonBO.personSex}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="���֤����"/></c:facet>
                <h:outputText value="#{list.contPersonBO.idCard}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value=" ��ֹ��ͬ���"/></c:facet>
                <h:outputText value="#{list.contCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��ֹ��ͬ��ʼʱ��"/></c:facet>
                <h:outputText value="#{list.contStartDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="��ֹ��ͬ����ʱ��"/></c:facet>
                <h:outputText value="#{list.contEndDate}"/>
            </h:column>
       <%--
            <h:column>
                <c:facet name="header"><h:outputText value="��ͬʵ�ʽ���ʱ��"/></c:facet>
                <h:outputText value="#{list.contFactEndDate}"/>
            </h:column>
            --%>

</x:dataTable>
    </td></tr>
</table>
</center>
<br/>
<h:panelGrid  border="0"  cellpadding="0"  cellspacing="0"  align="center" columns="1" width="800">
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <h:outputText value="¼����Ϣ" styleClass="td05"/>
    </h:panelGrid>
</h:panelGrid>

<h:inputHidden id="contId" value="#{cont_contResumeBB.bo.contId}"/>
<h:inputHidden id="contCode" value="#{cont_contResumeBB.bo.contCode}"/>
<h:inputHidden id="personId" value="#{cont_contResumeBB.bo.personId}"/>
<h:inputHidden id="personName" value="#{cont_contResumeBB.bo.personName}"/>
<h:inputHidden id="attachmentId" value="#{cont_contResumeBB.bo.attachmentId}"/>
<h:inputHidden id="createOrgId" value="#{cont_contResumeBB.bo.createOrgId}"/>
<h:inputHidden id="isValid" value="#{cont_contResumeBB.bo.isValid}"/>
<h:inputHidden id="pauseContIdForResume" value="#{cont_contResumeBB.bo.pauseContIdForResume}"/>
<h:inputHidden id="contCreateDate" value="#{cont_contResumeBB.bo.contCreateDate}"/>
<h:panelGrid width="800" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02">
         <h:outputText  styleClass="td_form_required" value="Э����" />
         <h:outputText value="#{cont_contResumeBB.bo.contCode}"/>

         <h:outputText  value="ģ�����" />
         <h:selectOneMenu value="#{cont_contResumeBB.bo.templateClassId}" id="templateClassId" onchange="javascript:pageCodeExchange(document.forms(0));submit(); "  valueChangeListener="#{cont_contResumeBB.templateClassChanged}">
                    <c:selectItems value="#{cont_contResumeBB.item_templateClass}"/>
         </h:selectOneMenu>

         <h:outputText  styleClass="td_form_required" value="Э�鴦�����" />
         <h:inputText styleClass="input" value="#{cont_contResumeBB.bo.protClass}" id="protClass"  code="" dict="yes" dict_num="0222" readonly="true" alt="Э�鴦�����|0"/>


         <h:outputText  value="Э��ģ��" />
         <h:panelGroup>
         <h:selectOneMenu value="#{cont_contResumeBB.bo.templateId}" id="templateId" >
                    <c:selectItems value="#{cont_contResumeBB.item_template}"/>
         </h:selectOneMenu>
         </h:panelGroup>

         <h:outputText  styleClass="td_form_required" value="�ָ�����ʱ��" />
         <h:panelGroup>
            <h:inputText id="resumeExecuteContDate" styleClass="input" size="10" value="#{cont_contResumeBB.bo.resumeExecuteContDate}" readonly="true" alt="�ָ�����ʱ��|0"/>
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:resumeExecuteContDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText value="�ϴ�����ģ���ļ�"></h:outputText>
         <x:inputFileUpload id="myFileId"
			        value="#{cont_contResumeBB.myFile}"
			        storage="file"/>

         <h:outputText value="��ͬʵ�ʽ���ʱ��" />
         <h:panelGroup>
            <h:inputText id="contFactEndDate" styleClass="input" size="10" value="#{cont_contResumeBB.bo.contFactEndDate}" readonly="true"/>
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:contFactEndDate')"> </c:verbatim>
         </h:panelGroup>
         <h:outputText value="" />
         <h:outputText value="" />


         <h:outputText value="��������ʼʱ��" />
         <h:panelGroup>
             <h:inputText id="serviceStartDate" styleClass="input" size="10" value="#{cont_contResumeBB.bo.serviceStartDate}" readonly="true"/>
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:serviceStartDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText  value="��������ֹʱ��" />
         <h:panelGroup>
            <h:inputText id="serviceEndDate" styleClass="input" size="10" value="#{cont_contResumeBB.bo.serviceEndDate}" readonly="true" />
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:serviceEndDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText value="��ҵ��������" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="jobLimitTerm" value="#{cont_contResumeBB.bo.jobLimitTerm}" maxlength="10" alt="��ҵ��������|1|i" />
            <h:outputText value=" ��" />
         </h:panelGroup>
         <h:outputText value="��ͬΥԼ���" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="fellbackMoney" value="#{cont_contResumeBB.bo.fellbackMoney}" maxlength="10" alt="��ͬΥԼ���|1|f" />
            <h:outputText value=" Ԫ" />
         </h:panelGroup>

         <h:outputText value="Э��ժҪ" />
         <h:panelGroup>
             <h:inputTextarea id="contRemark" rows="4" cols="28"  value="#{cont_contResumeBB.bo.contRemark}"/>
         </h:panelGroup>

         <h:outputText value="�Ƿ�ͬ���֤" />
         <h:panelGroup>
             <h:inputText value="#{cont_contResumeBB.bo.agreeTestify}" id="agreeTestify" styleClass="input"  code="" dict="yes" dict_num="2023" readonly="true" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:agreeTestify')" class="button_select"></c:verbatim>
         </h:panelGroup>
</h:panelGrid>
     <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="2">
                <h:commandButton styleClass="button01" value="����" action="#{cont_contResumeBB.save_edit}"  onclick="if( checkSubmit(document.forms(0))&&checkAll(document.forms(0)) ){ return confirmSave(document.forms(0));}else{return false;}"/>
                <h:commandButton styleClass="button01" value="ȡ������" action="#{cont_contResumeBB.forwardList}"/>
     </h:panelGrid>

</h:form>
<c:verbatim>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
</c:verbatim>
</body>
</html>