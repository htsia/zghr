<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script language="javascript">
function selectAdjustPerson(ctrlobj){
	showx = event.screenX - event.offsetX - 4 - 210 ;
	showy = event.screenY - event.offsetY + 18;
	retval = window.showModalDialog("/cont/SelectAdjustPerson.jsf", "", "dialogWidth:750px; dialogHeight:400px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:yes; directories:yes;scrollbars:yes;Resizable=yes; "  );
    if (retval != null) {
           form1.all("form1:str").value = retval;
           pageCodeExchange(document.forms(0));

    } else {
           return false;
    }
}
function selectNewPerson(ctrlobj){
	showx = event.screenX - event.offsetX - 4 - 210 ;
	showy = event.screenY - event.offsetY + 18;
	retval = window.showModalDialog("/cont/SelectNewPerson.jsf", "", "dialogWidth:750px; dialogHeight:400px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:yes; directories:yes;scrollbars:yes;Resizable=yes; "  );
    if (retval != null) {
           form1.all("form1:str").value = retval;
           pageCodeExchange(document.forms(0));

    } else {
           return false;
    }
}
function deleteNewPerson(){
  var field = form1.all('selected_ids');
  if (checkMutilSelect(field)) {
      pageCodeExchange(document.forms(0));
  } else{
      alert("��ѡ����Ա��");
      return false;
  }
}
function checkSubmit(form1) {
        flag = true;
        var name = form1.all("form1:templateClassId").value;
        if (document.all('form1:generateDoc').checked){
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
        name = form1.all("form1:salaryInclude").value;
        if (name != "" && name != null) {
            if (name.length>300) {
                alert("���ʹ����������ֻ������300�����֣�");
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
        //��ͬ�����ڽ���ʱ��
        var probationEndDate = form1.all("form1:probationEndDate").value;
        //��ͬԼ����ϰ����ֹʱ��
        var praxisEndDate = form1.all("form1:praxisEndDate").value;

        if (probationEndDate.trim() != "" && praxisEndDate.trim() != "") {
            var sT = probationEndDate.split("-");
            var stemp = new Date(sT[0], sT[1], sT[2],"01");
            var wT = praxisEndDate.split("-");
            var wtemp = new Date(wT[0], wT[1], wT[2], "01");
            if ((stemp.getTime() - wtemp.getTime()) > 0) {
                alert("��ͬԼ����������ֹʱ�����С�ڵ��ں�ͬԼ����ϰ����ֹʱ��!");
                flag = false;
                return flag;
            }
        }
        if (praxisEndDate.trim() != "" && contStartDate.trim() != "") {
            var sT = praxisEndDate.split("-");
            var stemp = new Date(sT[0], sT[1], sT[2],"01");
            var wT = contStartDate.split("-");
            var wtemp = new Date(wT[0], wT[1], wT[2], "01");
            if ((stemp.getTime() - wtemp.getTime()) <= 0) {
                alert("��ͬԼ����ϰ����ֹʱ�������ں�ͬԼ����ʼʱ��!");
                flag = false;
                return flag;
            }
        }
        if (probationEndDate.trim() != "" && contStartDate.trim() != "") {
            var sT = probationEndDate.split("-");
            var stemp = new Date(sT[0], sT[1], sT[2],"01");
            var wT = contStartDate.split("-");
            var wtemp = new Date(wT[0], wT[1], wT[2], "01");
            if ((stemp.getTime() - wtemp.getTime()) <= 0) {
                alert("��ͬԼ����������ֹʱ�������ں�ͬԼ����ʼʱ��!");
                flag = false;
                return flag;
            }
        }
        if (contEndDate.trim() != "" && contStartDate.trim() != "") {
            var sT = contEndDate.split("-");
            var stemp = new Date(sT[0], sT[1],  sT[2],"01");
            var wT = contStartDate.split("-");
            var wtemp = new Date(wT[0], wT[1], wT[2],"01");
            if ((stemp.getTime() - wtemp.getTime()) <= 0) {
                alert("��ͬԼ����ֹʱ�������ں�ͬԼ����ʼʱ��!");
                flag = false;
                return flag;
            }
        }
        if (contEndDate.trim() != "" && probationEndDate.trim() != "") {
            var sT = contEndDate.split("-");
            var stemp = new Date(sT[0], sT[1],  sT[2],"01");
            var wT = probationEndDate.split("-");
            var wtemp = new Date(wT[0], wT[1], wT[2],"01");
            if ((stemp.getTime() - wtemp.getTime()) <= 0) {
                alert("��ͬԼ����ֹʱ�������ں�ͬԼ����������ֹʱ��!");
                flag = false;
                return flag;
            }
        }
         if (contEndDate.trim() != "" && praxisEndDate.trim() != "") {
            var sT = contEndDate.split("-");
            var stemp = new Date(sT[0], sT[1],  sT[2],"01");
            var wT = praxisEndDate.split("-");
            var wtemp = new Date(wT[0], wT[1], wT[2],"01");
            if ((stemp.getTime() - wtemp.getTime()) <= 0) {
                alert("��ͬԼ����ֹʱ�������ں�ͬԼ����ϰ����ֹʱ��!");
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
        if (confirm('ȷ��Ҫ��������')) {
            pageCodeExchange(form1);
            return true;
        } else {
            return false;
        }
}
</script>

<h:form id="form1">
    <h:inputHidden id="str" value="#{cont_contNewSignBB.selectNewPersonIds}"/>
    <h:inputHidden id="init_b" value="#{cont_contNewSignBB.init_b}"/>
	<f:verbatim>
    <table height=100% width=100% align="center">
        <tr><td><div style='width:100%;height:98%;overflow:auto' id=datatable>
    </f:verbatim>
    <h:panelGrid width="100%" border="0" styleClass="td_title" cellpadding="0" >
       <h:panelGroup>
           <h:graphicImage value="/images/tips.gif" />
           <h:outputText value="��ͬ��ǩ" ></h:outputText>
       </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="1" width="98%" align="center">
    <h:panelGroup>
        <h:outputText escape="false" value="<strong>�׷���</strong>#{cont_contNewSignBB.partAName}"></h:outputText>
        <h:outputText escape="false" value="    "></h:outputText>

        <h:outputText escape="false" value="<strong>���˴���</strong>#{cont_contNewSignBB.partALeader}"></h:outputText>
        <h:outputText escape="false" value="    "></h:outputText>

        <h:outputText escape="false" value="<strong>ע�᣺</strong>#{cont_contNewSignBB.partARegAdd}"></h:outputText>
        <h:outputText escape="false" value="    "></h:outputText>

        <h:outputText escape="false" value="<strong>ͨ�ŵ�ַ��</strong>#{cont_contNewSignBB.partAAddress}"></h:outputText>
    </h:panelGroup>
    </h:panelGrid>
    
<h:panelGrid  border="0"  align="center" columns="2" width="800">
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <c:verbatim escape="false"><a href="javascript:showHide(ryTable);"><b>  ��Ա��Ϣ</b></a></c:verbatim>
    </h:panelGrid>
    <h:panelGrid  border="0"  cellspacing="0" align="right" columns="3" >
         <h:commandButton styleClass="button01" value="ѡ�������Ա" rendered="#{cont_contNewSignBB.empChangeMode=='1'}" action="#{cont_contNewSignBB.selectNewPerson}" onclick="javascript:return selectAdjustPerson();"/>
         <h:commandButton styleClass="button01" value="ѡ����Ա��" action="#{cont_contNewSignBB.selectNewPerson}" onclick="javascript:return selectNewPerson();"/>
         <h:commandButton styleClass="button01" value="ȥ��" action="#{cont_contNewSignBB.deleteNewPerson}" onclick="javascript:return deleteNewPerson();"/>
    </h:panelGrid>
</h:panelGrid>

<c:verbatim>
<br/>
<table id="ryTable" width="800" border="0" align="center">
  <tr><td>
</c:verbatim>
      <x:dataTable value="#{cont_contNewSignBB.bos_contPerson}" var="list"  rowIndexVar="index"
                     headerClass="td_top"
                     rowClasses="td_middle" styleClass="table03" width="800" border="1">
            <h:column>
                   <c:facet name="header">
                   <c:verbatim escape="false">
                   <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)"/>
                   </c:verbatim>
                   </c:facet>
                   <c:verbatim escape="false"><input type="checkbox" name="selected_ids" value="</c:verbatim>
                   <h:outputText value="#{list.personId}"/>
                   <c:verbatim>"></c:verbatim>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="���"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��Ա���"/></c:facet>
                <h:outputText value="#{list.personCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�Ա�"/></c:facet>
                <h:outputText value="#{list.personSex}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="���ڻ���"/></c:facet>
                <h:outputText value="#{list.enterOrgId}"/>
            </h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="���ڲ���" />
						</c:facet>
						<h:outputText value="#{list.deptName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��λ����" />
						</c:facet>
						<h:outputText value="#{list.cname}" />
					</h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����˾ʱ��"/></c:facet>
                <h:outputText value="#{list.createDate}"/>
            </h:column>

       </x:dataTable>
<c:verbatim>
    </td></tr>
</table>
<br/>
</c:verbatim>

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
<h:inputHidden id="contCreateDate" value="#{cont_contNewSignBB.bo.contCreateDate}"/>
<h:inputHidden id="validOverdue" value="#{cont_contNewSignBB.bo.validOverdue}"/>
<h:panelGrid width="800" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02">
         <h:outputText  styleClass="td_form_required" value="��ͬ���" />
         <h:inputText value="#{cont_contNewSignBB.bo.contCode}"/>
         <h:outputText   styleClass="td_form_required" value="ģ�����" />
         <h:selectOneMenu value="#{cont_contNewSignBB.bo.templateClassId}" id="templateClassId" onchange="javascript:pageCodeExchange(document.forms(0));submit(); "  valueChangeListener="#{cont_contNewSignBB.templateClassChanged}">
                    <c:selectItems value="#{cont_contNewSignBB.item_templateClass}"/>
         </h:selectOneMenu>

         <h:outputText  styleClass="td_form_required" value="��ͬ�������" />
         <h:inputText styleClass="input" value="#{cont_contNewSignBB.bo.contClass}" id="contClass"  code="" dict="yes" dict_num="0220" readonly="true" alt="��ͬ�������|0"/>

         <h:outputText  styleClass="td_form_required" value="��ͬģ��" />
         <h:panelGroup>
             <h:selectOneMenu value="#{cont_contNewSignBB.bo.templateId}" id="templateId" >
                   <c:selectItems value="#{cont_contNewSignBB.item_template}"/>
             </h:selectOneMenu>
             <h:selectBooleanCheckbox id="generateDoc" value="#{cont_contNewSignBB.generateDoc}"></h:selectBooleanCheckbox>
             <h:outputText value="���ɺ�ͬ�ļ�"></h:outputText>
         </h:panelGroup>

         <h:outputText  styleClass="td_form_required" value="��ͬ��������" />
         <h:panelGroup>
             <h:inputText styleClass="input" value="#{cont_contNewSignBB.bo.contTermClass}" id="contTermClass"  code="" dict="yes" dict_num="0215" readonly="true" alt="��ͬ��������|0" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:contTermClass')" class="button_select"></c:verbatim>
         </h:panelGroup>
         <h:outputText value="" />
         <h:outputText value="" />

         <h:outputText  styleClass="td_form_required" value="��ͬԼ����ʼʱ��" />
         <h:panelGroup>
             <h:inputText id="contStartDate" styleClass="input" size="10" value="#{cont_contNewSignBB.bo.contStartDate}" readonly="true" alt="��ͬԼ����ʼʱ��|0"/>
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:contStartDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText  value="��ͬԼ����ֹʱ��" />
         <h:panelGroup>
            <h:inputText id="contEndDate" styleClass="input" size="10" value="#{cont_contNewSignBB.bo.contEndDate}" readonly="true" />
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:contEndDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText value="��ͬ��ϰ����ֹʱ��" />
         <h:panelGroup>
            <h:inputText id="praxisEndDate" styleClass="input" size="10" value="#{cont_contNewSignBB.bo.praxisEndDate}" readonly="true"/>
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:praxisEndDate')"></c:verbatim>
         </h:panelGroup>

         <h:outputText value="��ͬ��������ֹʱ��" />
         <h:panelGroup>
             <h:inputText id="probationEndDate" styleClass="input" size="10" value="#{cont_contNewSignBB.bo.probationEndDate}" readonly="true" />
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:probationEndDate')"></c:verbatim>
         </h:panelGroup>

         <h:outputText  value="��ͬԼ�������ص�" />
         <h:inputTextarea id="workPlace" rows="2" cols="28" value="#{cont_contNewSignBB.bo.workPlace}"/>

         <h:outputText   value="��ͬԼ����������" />
         <h:inputTextarea id="workContent" rows="2" cols="28"   value="#{cont_contNewSignBB.bo.workContent}"/>

         <h:outputText   value="��ͬԼ��������λ" />
         <h:inputText styleClass="input" id="postName"  size = "30" maxlength="15" value="#{cont_contNewSignBB.postNames}" alt="��ͬԼ��������λ|1|s" />

         <h:outputText   value="��ͬ��λ����" />
         <h:inputText styleClass="input" id="cpostname"  size = "30" maxlength="15" value="#{cont_contNewSignBB.contPostNames}" alt="��ͬ��λ����|1|s" />

         <h:outputText  value="��ͬԼ����ʱ�ƶ�" />
         <h:panelGroup>
             <h:inputText styleClass="input" value="#{cont_contNewSignBB.bo.workTimeSet}" id="workTimeSet"  code="" dict="yes" dict_num="2024" readonly="true" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:workTimeSet')" class="button_select"></c:verbatim>
         </h:panelGroup>

         <h:outputText value="��������ʼʱ��" />
         <h:panelGroup>
             <h:inputText id="serviceStartDate" styleClass="input" size="10" value="#{cont_contNewSignBB.bo.serviceStartDate}" readonly="true"/>
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:serviceStartDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText  value="��������ֹʱ��" />
         <h:panelGroup>
            <h:inputText id="serviceEndDate" styleClass="input" size="10" value="#{cont_contNewSignBB.bo.serviceEndDate}" readonly="true" />
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:serviceEndDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText value="��ͬԼ���Ͷ�������ʽ" />
         <h:panelGroup>
            <h:inputTextarea id="salaryClass" rows="2" cols="28"   value="#{cont_contNewSignBB.bo.salaryClass}"/>
         </h:panelGroup>
         <h:outputText value="��ͬԼ�����ʹ���" />
         <h:panelGroup>
            <h:inputTextarea id="salaryInclude" rows="2" cols="28"   value="#{cont_contNewSignBB.bo.salaryInclude}"/>
         </h:panelGroup>

         <h:outputText value="��ͬԼ����н��" />
         <h:inputText styleClass="input" id="paySalaryDate"  size = "30" maxlength="30" value="#{cont_contNewSignBB.bo.paySalaryDate}" alt="��ͬԼ����н��|1|s" />
         <h:outputText value="�����ڹ��ʱ�׼" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="probationSalaryMoney" value="#{cont_contNewSignBB.bo.probationSalaryMoney}" maxlength="10" alt="�����ڹ��ʱ�׼|1|f" />
            <h:outputText value=" Ԫ/��" />
         </h:panelGroup>

         <h:outputText value="��ͬ�ڹ��ʱ�׼" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="standardSalaryMoney" value="#{cont_contNewSignBB.bo.standardSalaryMoney}" maxlength="10" alt="���ʱ�׼|1|f" />
            <h:outputText value=" Ԫ/��" />
         </h:panelGroup>
         <h:outputText value="��ϰ�ڹ��ʱ�׼" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="basicSalaryMoney" value="#{cont_contNewSignBB.bo.basicSalaryMoney}" maxlength="10" alt="�������ʱ�׼|1|f" />
            <h:outputText value=" Ԫ/��" />
         </h:panelGroup>

         <h:outputText value="�������ʱ�׼" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="performanceSalaryMoney" value="#{cont_contNewSignBB.bo.performanceSalaryMoney}" maxlength="10" alt="��Ч���ʱ�׼|1|f" />
            <h:outputText value=" Ԫ/��" />
         </h:panelGroup>
         <h:outputText value="" />
         <h:outputText value="" />

         <h:outputText value="��ҵ��������" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="jobLimitTerm" value="#{cont_contNewSignBB.bo.jobLimitTerm}" maxlength="10" alt="��ҵ��������|1|i" />
            <h:outputText value=" ��" />
         </h:panelGroup>
         <h:outputText value="��ͬΥԼ���" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="fellbackMoney" value="#{cont_contNewSignBB.bo.fellbackMoney}" maxlength="10" alt="��ͬΥԼ���|1|f" />
            <h:outputText value=" Ԫ" />
         </h:panelGroup>

         <h:outputText value="�Ͷ���ͬժҪ" />
         <h:panelGroup>
             <h:inputTextarea id="contRemark" rows="3" cols="28"  value="#{cont_contNewSignBB.bo.contRemark}"/>
         </h:panelGroup>
         <h:outputText value="�Ƿ�ͬ���֤" />
         <h:panelGroup>
             <h:inputText value="#{cont_contNewSignBB.bo.agreeTestify}" id="agreeTestify" styleClass="input"  code="" dict="yes" dict_num="2023" readonly="true" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:agreeTestify')" class="button_select"></c:verbatim>
         </h:panelGroup>
     </h:panelGrid>

    <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="right" columns="2">
                <h:commandButton styleClass="button01" value="����" action="#{cont_contNewSignBB.save_add}"  onclick="if( checkSubmit(document.forms(0))&&checkAll(document.forms(0)) ){ return confirmSave(document.forms(0));}else{return false;}"/>
                <h:commandButton styleClass="button01" value="ȡ������" action="#{cont_contNewSignBB.forwardList}"/>
     </h:panelGrid>
     <f:verbatim>
		</div></td></tr></table>
	</f:verbatim>
</h:form>

<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
