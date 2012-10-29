<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO"%>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script language="javascript">
function checkSubmit(form1) {
        flag = true;
        var name = form1.all("form1:templateClassId").value;
        if (name == "" || name == null) {
            alert("ģ�������Ϊ�գ�");
             flag = false;
             return flag;
        }
        name = form1.all("form1:templateId").value;
        if (name == "" || name == null) {
            alert("��ͬģ�岻��Ϊ�գ�");
             flag = false;
             return flag;
        }
                name = form1.all("form1:workPlace").value;
        if (name == "" || name == null) {
            alert("��ͬԼ�������ص㲻��Ϊ�գ�");
             flag = false;
             return flag;
        }
        if (name.length>30) {
            alert("��ͬԼ�������ص��������ֻ������30�����֣�");
             flag = false;
             return flag;
        }
        name = form1.all("form1:workContent").value;
        if (name == "" || name == null) {
            alert("��ͬԼ���������ݲ���Ϊ�գ�");
             flag = false;
             return flag;
        }
        if (name.length>60) {
            alert("��ͬԼ�����������������ֻ������60�����֣�");
             flag = false;
             return flag;
        }
        name = form1.all("form1:salaryClass").value;
        if (name != "" && name != null) {
            if (name.length>50) {
                alert("��ͬԼ���Ͷ�������ʽ�������ֻ������50�����֣�");
                flag = false;
                return flag;
            }
        }
        name = form1.all("form1:contRemark").value;
        if (name != "" && name != null) {
            if (name.length>50) {
                alert("�Ͷ���ͬժҪ�������ֻ������50�����֣�");
                flag = false;
                return flag;
            }
        }
        name = form1.all("form1:contTermClass").code;
        //��ͬ����ʱ��
        var contEndDate = form1.all("form1:contEndDate").value;
        if (name == "02152") {
            if (contEndDate == "" || contEndDate == null) {
                alert("����ͬ��������Ϊ�̶�����ʱ����ͬԼ����ֹʱ�䲻��Ϊ�գ�");
                flag = false;
                return flag;
             }
        }else if(name == "02151"){
            if (contEndDate != "" && contEndDate != null) {
                alert("����ͬ��������Ϊ�޹̶�����ʱ����ͬԼ����ֹʱ�䲻����д��");
                flag = false;
                return flag;
            }
        }
        
        //��ͬ��ʼʱ��
        var contStartDate = form1.all("form1:contStartDate").value;

        if (contEndDate.trim() != "" && contStartDate.trim() != "") {
            var sT = contEndDate.split("-");
            var stemp = new Date(sT[0], sT[1],  sT[2],"01");
            var wT = contStartDate.split("-");
            var wtemp = new Date(wT[0], wT[1], wT[2],"01");
            if ((stemp.getTime() - wtemp.getTime()) <= 0) {
                alert("��ͬԼ����ֹʱ�������ں�ͬԼ����ʼʼʱ��!");
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

<h:form id="form1">
<h:panelGrid width="100%" border="0" cellspacing="0" styleClass="td_title" cellpadding="0" >
    <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value="��ͬ��ǩά��" ></h:outputText>
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
            <h:inputHidden id="ManyPerson" value="#{cont_contSignBB.nameStrs}"></h:inputHidden>
            <h:commandButton value="���˲�ѯ" id="queryPerson2" onclick="return doQueryManyPerson()" styleClass="button01"
                             action="#{cont_contSignBB.queryMultPerson}"/>
        </h:panelGroup>

         <h:commandButton id="advance1" styleClass="button01"  value="�Զ����ѯ" action="#{cont_contSignBB.selPerson}" onclick="return queryPerson();"/>
         <h:commandButton styleClass="button01" value="ȥ����Ա" action="#{cont_contSignBB.delPerson}" onclick="javascript:return delPerson();"/>
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

<h:inputHidden id="contId" value="#{cont_contSignBB.bo.contId}"/>
<h:inputHidden id="contCode" value="#{cont_contSignBB.bo.contCode}"/>
<h:inputHidden id="personId" value="#{cont_contSignBB.bo.personId}"/>
<h:inputHidden id="personName" value="#{cont_contSignBB.bo.personName}"/>
<h:inputHidden id="attachmentId" value="#{cont_contSignBB.bo.attachmentId}"/>
<h:inputHidden id="createOrgId" value="#{cont_contSignBB.bo.createOrgId}"/>
<h:inputHidden id="isValid" value="#{cont_contSignBB.bo.isValid}"/>
<h:inputHidden id="contCreateDate" value="#{cont_contSignBB.bo.contCreateDate}"/>
<h:panelGrid width="800" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02">
         <h:outputText  styleClass="td_form_required" value="��ͬ���" />
         <h:outputText value=""/>
         <h:outputText   styleClass="td_form_required" value="ģ�����" />
         <h:selectOneMenu value="#{cont_contSignBB.bo.templateClassId}" id="templateClassId" onchange="javascript:pageCodeExchange(document.forms(0));submit(); "  valueChangeListener="#{cont_contSignBB.templateClassChanged}">
                    <c:selectItems value="#{cont_contSignBB.item_templateClass}"/>
         </h:selectOneMenu>

         <h:outputText styleClass="td_form_required" value="��ͬ�������" />
         <h:inputText styleClass="input" value="#{cont_contSignBB.bo.contClass}" id="contClass"  code="" dict="yes" dict_num="0220" readonly="true" alt="��ͬ�������|0"/>

         <h:outputText  styleClass="td_form_required" value="��ͬģ��" />
         <h:panelGroup>
             <h:selectOneMenu value="#{cont_contSignBB.bo.templateId}" id="templateId" >
                     <c:selectItems value="#{cont_contSignBB.item_template}"/>
             </h:selectOneMenu>
         </h:panelGroup>

         <h:outputText  styleClass="td_form_required" value="��ͬ��������" />
         <h:panelGroup>
             <h:inputText styleClass="input" value="#{cont_contSignBB.bo.contTermClass}" id="contTermClass"  code="" dict="yes" dict_num="0215" readonly="true" alt="��ͬ��������|0" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:contTermClass')" class="button_select"></c:verbatim>
         </h:panelGroup>
         <h:outputText value="" />
         <h:outputText value="" />

         <h:outputText  styleClass="td_form_required" value="��ͬԼ����ʼʱ��" />
         <h:panelGroup>
             <h:inputText id="contStartDate" styleClass="input" size="10" value="#{cont_contSignBB.bo.contStartDate}" readonly="true" alt="��ͬԼ����ʼʱ��|0"/>
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:contStartDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText value="��ͬԼ����ֹʱ��" />
         <h:panelGroup>
            <h:inputText id="contEndDate" styleClass="input" size="10" value="#{cont_contSignBB.bo.contEndDate}" readonly="true" />
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:contEndDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText  styleClass="td_form_required" value="��ͬԼ�������ص�" />
         <h:inputTextarea id="workPlace" rows="2" cols="28"   value="#{cont_contSignBB.bo.workPlace}"/>

         <h:outputText  styleClass="td_form_required" value="��ͬԼ����������" />
         <h:inputTextarea id="workContent" rows="2" cols="28"   value="#{cont_contSignBB.bo.workContent}"/>

         <h:outputText  styleClass="td_form_required" value="��ͬԼ��������λ" />
         <h:inputText styleClass="input" id="postName"  size="30" maxlength="15" value="#{cont_contSignBB.bo.postName}" alt="��ͬԼ��������λ|0|s" />

         <h:outputText  value="��ͬԼ����ʱ�ƶ�" />
         <h:panelGroup>
             <h:inputText styleClass="input" value="#{cont_contSignBB.bo.workTimeSet}" id="workTimeSet" size="28"  code="" dict="yes" dict_num="2024" readonly="true" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:workTimeSet')" class="button_select"></c:verbatim>
         </h:panelGroup>

         <h:outputText value="��������ʼʱ��" />
         <h:panelGroup>
             <h:inputText id="serviceStartDate" styleClass="input" size="10" value="#{cont_contSignBB.bo.serviceStartDate}" readonly="true"/>
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:serviceStartDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText  value="��������ֹʱ��" />
         <h:panelGroup>
            <h:inputText id="serviceEndDate" styleClass="input" size="10" value="#{cont_contSignBB.bo.serviceEndDate}" readonly="true" />
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:serviceEndDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText value="��ͬԼ���Ͷ�������ʽ" />
         <h:panelGroup>
            <h:inputTextarea id="salaryClass" rows="2" cols="28"   value="#{cont_contSignBB.bo.salaryClass}"/>
         </h:panelGroup>
         <h:outputText value="��ͬԼ�����ʹ���" />
         <h:panelGroup>
            <h:inputTextarea id="salaryInclude" rows="2" cols="28"   value="#{cont_contSignBB.bo.salaryInclude}"/>
         </h:panelGroup>

         <h:outputText value="��ͬԼ����н��" />
         <h:inputText styleClass="input" id="paySalaryDate"  size = "30" maxlength="30" value="#{cont_contSignBB.bo.paySalaryDate}" alt="��ͬԼ����н��|1|s" />
         <h:outputText value="" />
         <h:outputText value="" />

         <h:outputText value="���ʱ�׼" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="standardSalaryMoney" value="#{cont_contSignBB.bo.standardSalaryMoney}" maxlength="10" alt="���ʱ�׼|1|f" />
            <h:outputText value=" Ԫ/��" />
         </h:panelGroup>
         <h:outputText value="�������ʱ�׼" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="basicSalaryMoney" value="#{cont_contSignBB.bo.basicSalaryMoney}" maxlength="10" alt="�������ʱ�׼|1|f" />
            <h:outputText value=" Ԫ/��" />
         </h:panelGroup>

         <h:outputText value="��Ч���ʱ�׼" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="performanceSalaryMoney" value="#{cont_contSignBB.bo.performanceSalaryMoney}" maxlength="10" alt="��Ч���ʱ�׼|1|f" />
            <h:outputText value=" Ԫ/��" />
         </h:panelGroup>
         <h:outputText value="" />
         <h:outputText value="" />

         <h:outputText value="��ҵ��������" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="jobLimitTerm" value="#{cont_contSignBB.bo.jobLimitTerm}" maxlength="10" alt="��ҵ��������|1|i" />
            <h:outputText value=" ��" />
         </h:panelGroup>
         <h:outputText value="��ͬΥԼ���" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="fellbackMoney" value="#{cont_contSignBB.bo.fellbackMoney}" maxlength="10" alt="��ͬΥԼ���|1|f" />
            <h:outputText value=" Ԫ" />
         </h:panelGroup>


         <h:outputText value="�Ͷ���ͬժҪ" />
         <h:panelGroup>
             <h:inputTextarea id="contRemark" rows="4" cols="28"  value="#{cont_contSignBB.bo.contRemark}"/>
         </h:panelGroup>
         <h:outputText value="�Ƿ�ͬ���֤" />
         <h:panelGroup>
             <h:inputText value="#{cont_contSignBB.bo.agreeTestify}" id="agreeTestify" styleClass="input"  code="" dict="yes" dict_num="2023" readonly="true" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:agreeTestify')" class="button_select"></c:verbatim>
         </h:panelGroup>
</h:panelGrid>

     <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="2">
                <h:commandButton styleClass="button01" value="����" action="#{cont_contSignBB.save_add}"  onclick="if( checkSubmit(document.forms(0))&&checkAll(document.forms(0)) ){ return confirmSave(document.forms(0));}else{return false;}"/>
                <h:commandButton styleClass="button01" value="ȡ������" action="#{cont_contSignBB.forwardList}"/>
     </h:panelGrid>

</h:form>

<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>

