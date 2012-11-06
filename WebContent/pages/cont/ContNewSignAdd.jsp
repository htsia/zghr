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
      alert("请选择人员！");
      return false;
  }
}
function checkSubmit(form1) {
        flag = true;
        var name = form1.all("form1:templateClassId").value;
        if (document.all('form1:generateDoc').checked){
            if (name == "" || name == null) {
                alert("模板类别不能为空！");
                 flag = false;
                 return flag;
            }
            name = form1.all("form1:templateId").value;
            if (name == "" || name == null) {
                alert("合同模板不能为空！");
                 flag = false;
                 return flag;
            }
        }

        name = form1.all("form1:salaryClass").value;
        if (name != "" && name != null) {
            if (name.length>50) {
                alert("合同约定劳动报酬形式限制最多只能输入50个汉字！");
                flag = false;
                return flag;
            }
        }
        name = form1.all("form1:contRemark").value;
        if (name != "" && name != null) {
            if (name.length>50) {
                alert("劳动合同摘要限制最多只能输入50个汉字！");
                flag = false;
                return flag;
            }
        }
        name = form1.all("form1:salaryInclude").value;
        if (name != "" && name != null) {
            if (name.length>300) {
                alert("工资构成限制最多只能输入300个汉字！");
                flag = false;
                return flag;
            }
        }

        name = form1.all("form1:contTermClass").code;
        //合同结束时间
        var contEndDate = form1.all("form1:contEndDate").value;
        if (name == "02152") {
            if (contEndDate == "" || contEndDate == null) {
                alert("当合同期限类型为固定期限时，合同约定终止时间不能为空！");
                flag = false;
                return flag;
             }
        }else if(name == "02151"){
            if (contEndDate != "" && contEndDate != null) {
                alert("当合同期限类型为无固定期限时，合同约定终止时间不能填写！");
                flag = false;
                return flag;
            }
        }

        //合同开始时间
        var contStartDate = form1.all("form1:contStartDate").value;
        //合同试用期结束时间
        var probationEndDate = form1.all("form1:probationEndDate").value;
        //合同约定见习期终止时间
        var praxisEndDate = form1.all("form1:praxisEndDate").value;

        if (probationEndDate.trim() != "" && praxisEndDate.trim() != "") {
            var sT = probationEndDate.split("-");
            var stemp = new Date(sT[0], sT[1], sT[2],"01");
            var wT = praxisEndDate.split("-");
            var wtemp = new Date(wT[0], wT[1], wT[2], "01");
            if ((stemp.getTime() - wtemp.getTime()) > 0) {
                alert("合同约定试用期终止时间必须小于等于合同约定见习期终止时间!");
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
                alert("合同约定见习期终止时间必须大于合同约定起始时间!");
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
                alert("合同约定试用期终止时间必须大于合同约定起始时间!");
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
                alert("合同约定终止时间必须大于合同约定起始时间!");
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
                alert("合同约定终止时间必须大于合同约定试用期终止时间!");
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
                alert("合同约定终止时间必须大于合同约定见习期终止时间!");
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
        if (confirm('确定要做保存吗？')) {
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
           <h:outputText value="合同新签" ></h:outputText>
       </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="1" width="98%" align="center">
    <h:panelGroup>
        <h:outputText escape="false" value="<strong>甲方：</strong>#{cont_contNewSignBB.partAName}"></h:outputText>
        <h:outputText escape="false" value="    "></h:outputText>

        <h:outputText escape="false" value="<strong>法人代表：</strong>#{cont_contNewSignBB.partALeader}"></h:outputText>
        <h:outputText escape="false" value="    "></h:outputText>

        <h:outputText escape="false" value="<strong>注册：</strong>#{cont_contNewSignBB.partARegAdd}"></h:outputText>
        <h:outputText escape="false" value="    "></h:outputText>

        <h:outputText escape="false" value="<strong>通信地址：</strong>#{cont_contNewSignBB.partAAddress}"></h:outputText>
    </h:panelGroup>
    </h:panelGrid>
    
<h:panelGrid  border="0"  align="center" columns="2" width="800">
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <c:verbatim escape="false"><a href="javascript:showHide(ryTable);"><b>  人员信息</b></a></c:verbatim>
    </h:panelGrid>
    <h:panelGrid  border="0"  cellspacing="0" align="right" columns="3" >
         <h:commandButton styleClass="button01" value="选择调入人员" rendered="#{cont_contNewSignBB.empChangeMode=='1'}" action="#{cont_contNewSignBB.selectNewPerson}" onclick="javascript:return selectAdjustPerson();"/>
         <h:commandButton styleClass="button01" value="选择新员工" action="#{cont_contNewSignBB.selectNewPerson}" onclick="javascript:return selectNewPerson();"/>
         <h:commandButton styleClass="button01" value="去除" action="#{cont_contNewSignBB.deleteNewPerson}" onclick="javascript:return deleteNewPerson();"/>
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
                <c:facet name="header"><h:outputText value="所在机构"/></c:facet>
                <h:outputText value="#{list.enterOrgId}"/>
            </h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="所在部门" />
						</c:facet>
						<h:outputText value="#{list.deptName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="岗位名称" />
						</c:facet>
						<h:outputText value="#{list.cname}" />
					</h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="来公司时间"/></c:facet>
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
         <h:outputText  styleClass="td_form_required" value="合同编号" />
         <h:inputText value="#{cont_contNewSignBB.bo.contCode}"/>
         <h:outputText   styleClass="td_form_required" value="模板类别" />
         <h:selectOneMenu value="#{cont_contNewSignBB.bo.templateClassId}" id="templateClassId" onchange="javascript:pageCodeExchange(document.forms(0));submit(); "  valueChangeListener="#{cont_contNewSignBB.templateClassChanged}">
                    <c:selectItems value="#{cont_contNewSignBB.item_templateClass}"/>
         </h:selectOneMenu>

         <h:outputText  styleClass="td_form_required" value="合同处理类别" />
         <h:inputText styleClass="input" value="#{cont_contNewSignBB.bo.contClass}" id="contClass"  code="" dict="yes" dict_num="0220" readonly="true" alt="合同处理类别|0"/>

         <h:outputText  styleClass="td_form_required" value="合同模板" />
         <h:panelGroup>
             <h:selectOneMenu value="#{cont_contNewSignBB.bo.templateId}" id="templateId" >
                   <c:selectItems value="#{cont_contNewSignBB.item_template}"/>
             </h:selectOneMenu>
             <h:selectBooleanCheckbox id="generateDoc" value="#{cont_contNewSignBB.generateDoc}"></h:selectBooleanCheckbox>
             <h:outputText value="生成合同文件"></h:outputText>
         </h:panelGroup>

         <h:outputText  styleClass="td_form_required" value="合同期限类型" />
         <h:panelGroup>
             <h:inputText styleClass="input" value="#{cont_contNewSignBB.bo.contTermClass}" id="contTermClass"  code="" dict="yes" dict_num="0215" readonly="true" alt="合同期限类型|0" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:contTermClass')" class="button_select"></c:verbatim>
         </h:panelGroup>
         <h:outputText value="" />
         <h:outputText value="" />

         <h:outputText  styleClass="td_form_required" value="合同约定起始时间" />
         <h:panelGroup>
             <h:inputText id="contStartDate" styleClass="input" size="10" value="#{cont_contNewSignBB.bo.contStartDate}" readonly="true" alt="合同约定起始时间|0"/>
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:contStartDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText  value="合同约定终止时间" />
         <h:panelGroup>
            <h:inputText id="contEndDate" styleClass="input" size="10" value="#{cont_contNewSignBB.bo.contEndDate}" readonly="true" />
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:contEndDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText value="合同见习期终止时间" />
         <h:panelGroup>
            <h:inputText id="praxisEndDate" styleClass="input" size="10" value="#{cont_contNewSignBB.bo.praxisEndDate}" readonly="true"/>
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:praxisEndDate')"></c:verbatim>
         </h:panelGroup>

         <h:outputText value="合同试用期终止时间" />
         <h:panelGroup>
             <h:inputText id="probationEndDate" styleClass="input" size="10" value="#{cont_contNewSignBB.bo.probationEndDate}" readonly="true" />
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:probationEndDate')"></c:verbatim>
         </h:panelGroup>

         <h:outputText  value="合同约定工作地点" />
         <h:inputTextarea id="workPlace" rows="2" cols="28" value="#{cont_contNewSignBB.bo.workPlace}"/>

         <h:outputText   value="合同约定工作内容" />
         <h:inputTextarea id="workContent" rows="2" cols="28"   value="#{cont_contNewSignBB.bo.workContent}"/>

         <h:outputText   value="合同约定工作岗位" />
         <h:inputText styleClass="input" id="postName"  size = "30" maxlength="15" value="#{cont_contNewSignBB.postNames}" alt="合同约定工作岗位|1|s" />

         <h:outputText   value="合同岗位禁忌" />
         <h:inputText styleClass="input" id="cpostname"  size = "30" maxlength="15" value="#{cont_contNewSignBB.contPostNames}" alt="合同岗位禁忌|1|s" />

         <h:outputText  value="合同约定工时制度" />
         <h:panelGroup>
             <h:inputText styleClass="input" value="#{cont_contNewSignBB.bo.workTimeSet}" id="workTimeSet"  code="" dict="yes" dict_num="2024" readonly="true" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:workTimeSet')" class="button_select"></c:verbatim>
         </h:panelGroup>

         <h:outputText value="服务期起始时间" />
         <h:panelGroup>
             <h:inputText id="serviceStartDate" styleClass="input" size="10" value="#{cont_contNewSignBB.bo.serviceStartDate}" readonly="true"/>
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:serviceStartDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText  value="服务期终止时间" />
         <h:panelGroup>
            <h:inputText id="serviceEndDate" styleClass="input" size="10" value="#{cont_contNewSignBB.bo.serviceEndDate}" readonly="true" />
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:serviceEndDate')"> </c:verbatim>
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

         <h:outputText value="合同期工资标准" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="standardSalaryMoney" value="#{cont_contNewSignBB.bo.standardSalaryMoney}" maxlength="10" alt="工资标准|1|f" />
            <h:outputText value=" 元/月" />
         </h:panelGroup>
         <h:outputText value="见习期工资标准" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="basicSalaryMoney" value="#{cont_contNewSignBB.bo.basicSalaryMoney}" maxlength="10" alt="基本工资标准|1|f" />
            <h:outputText value=" 元/月" />
         </h:panelGroup>

         <h:outputText value="其他工资标准" />
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
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:agreeTestify')" class="button_select"></c:verbatim>
         </h:panelGroup>
     </h:panelGrid>

    <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="right" columns="2">
                <h:commandButton styleClass="button01" value="保存" action="#{cont_contNewSignBB.save_add}"  onclick="if( checkSubmit(document.forms(0))&&checkAll(document.forms(0)) ){ return confirmSave(document.forms(0));}else{return false;}"/>
                <h:commandButton styleClass="button01" value="取消返回" action="#{cont_contNewSignBB.forwardList}"/>
     </h:panelGrid>
     <f:verbatim>
		</div></td></tr></table>
	</f:verbatim>
</h:form>

<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
