<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO"%>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
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
function queryPerson(){
    if(doAdvanceQuery('A','ORG','110','Y','cont_selPerObjs','1=1','Y','<%=Constants.DEFAULT_QUERY_CONTRACT%>','N','','2')){
         pageCodeExchange(document.forms(0));
         return true;
    }else{
         return false;
    }
}
function delPerson()
{
  var field = form1.all('chk');
  if (checkMutilSelect(field)) {
      pageCodeExchange(document.forms(0));
  } else{
      alert("��ѡ����Ա��");
      return false;
  }
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
        if (confirm('ȷ��Ҫ��������')) {
            pageCodeExchange(form1);
            return true;
        } else {
            return false;
        }
}
function forView(form, id, type) {
    window.open("/cont/ContQueryHistory.jsf?displayFlag=false&personId=" + id ,"","left=50,top=50,height=400,width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=yes")
}
function doQueryManyPerson(){
    var reval = window.showModalDialog("/common/ManyPersonCon.jsf", null, "dialogWidth:550px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
    if (reval != null && reval !="") {
        document.all('form1:ManyPerson').value = reval;
        pageCodeExchange(document.forms(0));
        return true;
    } else {
        return false;
    }
}
    
</script>
<body>
<h:form id="form1" enctype="multipart/form-data" >
<h:panelGrid width="100%" border="0" styleClass="td_title" cellspacing="0" cellpadding="0" >
    <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value="Э��ǩ��ά��" ></h:outputText>
    </h:panelGroup>
</h:panelGrid>

<h:panelGrid  border="0"  align="center" columns="2" width="800">
    <%
        int  rowCount = 0;
        if(request.getSession().getAttribute("cont_selPerObjs")!=null){
           RecordVO[] recordVOs = ((TableVO)request.getSession().getAttribute("cont_selPerObjs")).getRowData();
           rowCount = recordVOs.length;
        }
    %>
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <c:verbatim escape="false"><a href="javascript:showHide(ryTable);"><b>  ��Ա��Ϣ(��<%=rowCount%>����¼)</b></a></c:verbatim>
    </h:panelGrid>
    <h:panelGrid  border="0"  cellspacing="0" align="right" columns="3" >
        <h:panelGroup>
            <h:inputHidden id="ManyPerson" value="#{cont_protSignBB.nameStrs}"></h:inputHidden>
            <h:commandButton value="���˲�ѯ" id="queryPerson2" onclick="return doQueryManyPerson()" styleClass="button01"
                             action="#{cont_protSignBB.queryMultPerson}"/>
        </h:panelGroup>

         <h:commandButton id="advance1" styleClass="button01"  value="�Զ����ѯ" action="#{cont_protSignBB.selPerson}" onclick="return queryPerson();"/>
         <h:commandButton styleClass="button01" value="ȥ����Ա" action="#{cont_protSignBB.delPerson}" onclick="javascript:return delPerson();"/>
    </h:panelGrid>
</h:panelGrid>

<c:verbatim>
<table id="ryTable" width="850" border="0" align="center">
  <tr><td>
      <jsp:include page="../cont/ActiveList.jsp"></jsp:include>
  </td></tr>
</table>
</c:verbatim>

<h:panelGrid  border="0"  cellpadding="0"  cellspacing="0"  align="center" columns="1" width="800">
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <h:outputText value="¼����Ϣ" styleClass="td05"/>
    </h:panelGrid>
</h:panelGrid>

<h:inputHidden id="contId" value="#{cont_protSignBB.bo.contId}"/>
<h:inputHidden id="contCode" value="#{cont_protSignBB.bo.contCode}"/>
<h:inputHidden id="personId" value="#{cont_protSignBB.bo.personId}"/>
<h:inputHidden id="personName" value="#{cont_protSignBB.bo.personName}"/>
<h:inputHidden id="attachmentId" value="#{cont_protSignBB.bo.attachmentId}"/>
<h:inputHidden id="createOrgId" value="#{cont_protSignBB.bo.createOrgId}"/>
<h:inputHidden id="isValid" value="#{cont_protSignBB.bo.isValid}"/>
<h:inputHidden id="contCreateDate" value="#{cont_protSignBB.bo.contCreateDate}"/>
<h:panelGrid width="800" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02">
         <h:outputText  styleClass="td_form_required" value="Э����" />
         <h:outputText value=""/>
         <h:outputText value="ģ�����" />
         <h:selectOneMenu value="#{cont_protSignBB.bo.templateClassId}" id="templateClassId" onchange="javascript:pageCodeExchange(document.forms(0));submit(); "  valueChangeListener="#{cont_protSignBB.templateClassChanged}">
                    <c:selectItems value="#{cont_protSignBB.item_templateClass}"/>
         </h:selectOneMenu>

        <h:outputText styleClass="td_form_required"  value="Э�����" />
         <h:selectOneMenu value="#{cont_protSignBB.bo.protClass}" id="protClass">
                    <c:selectItem itemValue="022211" itemLabel="��ҵ����Э��" />
                    <c:selectItem itemValue="022212" itemLabel="��ѵЭ��" />
                    <c:selectItem itemValue="022213" itemLabel="����Э��" />
                    <c:selectItem itemValue="022214" itemLabel="����Э��" />
                    <c:selectItem itemValue="022219" itemLabel="����Э��" />
         </h:selectOneMenu>

         <h:outputText value="Э��ģ��" />
         <h:panelGroup>
         <h:selectOneMenu value="#{cont_protSignBB.bo.templateId}" id="templateId" >
                    <c:selectItems value="#{cont_protSignBB.item_template}"/>
         </h:selectOneMenu>
         </h:panelGroup>

         <h:outputText value="Э��Լ���Ͷ���ϵ��ֹʱ��" />
         <h:panelGroup>
            <h:inputText id="contEndDate" styleClass="input" size="10" value="#{cont_protSignBB.bo.contEndDate}" readonly="true"/>
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:contEndDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText value="�ϴ�����ģ���ļ�"></h:outputText>
         <x:inputFileUpload id="myFileId"
			        value="#{cont_protSignBB.myFile}"
			        storage="file"/>

         <h:outputText value="��������ʼʱ��" />
         <h:panelGroup>
             <h:inputText id="serviceStartDate" styleClass="input" size="10" value="#{cont_protSignBB.bo.serviceStartDate}" readonly="true"/>
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:serviceStartDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText  value="��������ֹʱ��" />
         <h:panelGroup>
            <h:inputText id="serviceEndDate" styleClass="input" size="10" value="#{cont_protSignBB.bo.serviceEndDate}" readonly="true" />
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:serviceEndDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText value="��ͬԼ�����ʹ���" />
         <h:panelGroup>
            <h:inputTextarea id="salaryInclude" rows="2" cols="28"   value="#{cont_protSignBB.bo.salaryInclude}"/>
         </h:panelGroup>

         <h:outputText value="��ͬԼ����н��" />
         <h:inputText styleClass="input" id="paySalaryDate"  size = "30" maxlength="30" value="#{cont_protSignBB.bo.paySalaryDate}" alt="��ͬԼ����н��|1|s" />


         <h:outputText value="���ʱ�׼" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="standardSalaryMoney" value="#{cont_protSignBB.bo.standardSalaryMoney}" maxlength="10" alt="���ʱ�׼|1|f" />
            <h:outputText value=" Ԫ/��" />
         </h:panelGroup>
         <h:outputText value="�������ʱ�׼" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="basicSalaryMoney" value="#{cont_protSignBB.bo.basicSalaryMoney}" maxlength="10" alt="�������ʱ�׼|1|f" />
            <h:outputText value=" Ԫ/��" />
         </h:panelGroup>

         <h:outputText value="��Ч���ʱ�׼" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="performanceSalaryMoney" value="#{cont_protSignBB.bo.performanceSalaryMoney}" maxlength="10" alt="��Ч���ʱ�׼|1|f" />
            <h:outputText value=" Ԫ/��" />
         </h:panelGroup>
         <h:outputText value="" />
         <h:outputText value="" />


         <h:outputText value="��ҵ��������" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="jobLimitTerm" value="#{cont_protSignBB.bo.jobLimitTerm}" maxlength="10" alt="��ҵ��������|1|i" />
            <h:outputText value=" ��" />
         </h:panelGroup>
         <h:outputText value="��ͬΥԼ���" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="fellbackMoney" value="#{cont_protSignBB.bo.fellbackMoney}" maxlength="10" alt="��ͬΥԼ���|1|f" />
            <h:outputText value=" Ԫ" />
         </h:panelGroup>

         <h:outputText value="Э��ժҪ" />
         <h:panelGroup>
             <h:inputTextarea id="contRemark" rows="4" cols="28"  value="#{cont_protSignBB.bo.contRemark}"/>
         </h:panelGroup>

          <h:outputText value="�Ƿ�ͬ���֤" />
         <h:panelGroup>
             <h:inputText value="#{cont_protSignBB.bo.agreeTestify}" id="agreeTestify" styleClass="input"  code="" dict="yes" dict_num="2023" readonly="true" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:agreeTestify')" class="button_select"></c:verbatim>
         </h:panelGroup>
</h:panelGrid>
     <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="2">
                <h:commandButton styleClass="button01" value="����" action="#{cont_protSignBB.save_add}" onclick="if( checkSubmit(document.forms(0))&&checkAll(document.forms(0)) ){ return confirmSave(document.forms(0));}else{return false;}"/>
                <h:commandButton styleClass="button01" value="ȡ������" action="#{cont_protSignBB.forwardList}"/>
     </h:panelGrid>

</h:form>
<c:verbatim>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
</c:verbatim>