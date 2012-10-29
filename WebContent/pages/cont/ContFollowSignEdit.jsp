<%@ page contentType="text/html;charset=GBK" language="java" %>
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
        var name = form1.all("form1:templateClassId").value;
        if (form1.all("form1:generateDoc").checked){
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
       name = form1.all("form1:workPlace").value;
        if (name == "" || name == null) {
            alert("合同约定工作地点不能为空！");
             flag = false;
             return flag;
        }
        if (name.length>30) {
            alert("合同约定工作地点限制最多只能输入30个汉字！");
             flag = false;
             return flag;
        }
        name = form1.all("form1:workContent").value;
        if (name == "" || name == null) {
            alert("合同约定工作内容不能为空！");
             flag = false;
             return flag;
        }
        if (name.length>60) {
            alert("合同约定工作内容限制最多只能输入60个汉字！");
             flag = false;
             return flag;
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
        if (confirm('合同电子文本会使用当前合同模板、人员及合同信息重新生成，确定要做保存吗？')) {
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

<h:form id="form1">
<h:inputHidden id="str_2" value="#{cont_contFollowSignBB.selectContIds}"/>
<h:panelGrid width="100%" border="0" cellspacing="6" cellpadding="0" >
   <h:outputText value="合同续签维护" styleClass="td_title" style="width:100%"></h:outputText>
</h:panelGrid>

<h:panelGrid  border="0"  align="center" columns="1" width="800">
    <%
        int  rowCount = 0;
        if(request.getSession().getAttribute("cont_selPerObjs")!=null){
           RecordVO[] recordVOs = ((TableVO)request.getSession().getAttribute("cont_selPerObjs")).getRowData();
           rowCount = recordVOs.length;
        }
    %>
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <c:verbatim escape="false"><a href="javascript:showHide(ryTable);"><b>  人员信息(共<%=rowCount%>条记录)</b></a></c:verbatim>
    </h:panelGrid>
</h:panelGrid>

<c:verbatim>
<center>
<table id="ryTable" width="850" border="0" align="center">
  <tr><td>
    <jsp:include page="../cont/ActiveList.jsp"></jsp:include>
  </td></tr>
</table>
</center>
<br/>
</c:verbatim>

<h:panelGrid  border="0"  cellpadding="0"  cellspacing="0"  align="center" columns="1" width="800">
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <h:outputText value="录入信息" styleClass="td05"/>
    </h:panelGrid>
</h:panelGrid>
<h:inputHidden id="contId" value="#{cont_contFollowSignBB.bo.contId}"/>
<h:inputHidden id="contCode" value="#{cont_contFollowSignBB.bo.contCode}"/>
<h:inputHidden id="personId" value="#{cont_contFollowSignBB.bo.personId}"/>
<h:inputHidden id="personName" value="#{cont_contFollowSignBB.bo.personName}"/>
<h:inputHidden id="attachmentId" value="#{cont_contFollowSignBB.bo.attachmentId}"/>
<h:inputHidden id="createOrgId" value="#{cont_contFollowSignBB.bo.createOrgId}"/>
<h:inputHidden id="isValid" value="#{cont_contFollowSignBB.bo.isValid}"/>
<h:inputHidden id="contCreateDate" value="#{cont_contFollowSignBB.bo.contCreateDate}"/>

<h:panelGrid width="800" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02">
         <h:outputText  styleClass="td_form_required" value="合同编号" />
         <h:outputText value="#{cont_contFollowSignBB.bo.contCode}"/>
         <h:outputText   styleClass="td_form_required" value="模板类别" />
         <h:selectOneMenu value="#{cont_contFollowSignBB.bo.templateClassId}" id="templateClassId" onchange="javascript:pageCodeExchange(document.forms(0));submit(); "  valueChangeListener="#{cont_contFollowSignBB.templateClassChanged}">
                    <c:selectItems value="#{cont_contFollowSignBB.item_templateClass}"/>
         </h:selectOneMenu>

         <h:outputText styleClass="td_form_required"  value="合同处理类别" />
         <h:inputText styleClass="input" value="#{cont_contFollowSignBB.bo.contClass}" id="contClass"  code="" dict="yes" dict_num="0220" readonly="true" alt="合同处理类别|0"/>

         <h:outputText  styleClass="td_form_required" value="合同模板" />
         <h:panelGroup>
             <h:selectOneMenu value="#{cont_contFollowSignBB.bo.templateId}" id="templateId" >
                        <c:selectItems value="#{cont_contFollowSignBB.item_template}"/>
             </h:selectOneMenu>
             <h:selectBooleanCheckbox id="generateDoc" value="#{cont_contFollowSignBB.generateDoc}"></h:selectBooleanCheckbox>
             <h:outputText value="生成合同文件"></h:outputText>
         </h:panelGroup>

         <h:outputText  styleClass="td_form_required" value="合同期限类型" />
         <h:panelGroup>
             <h:inputText styleClass="input" value="#{cont_contFollowSignBB.bo.contTermClass}" id="contTermClass"  code="" dict="yes" dict_num="0215" readonly="true" alt="合同期限类型|0" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:contTermClass')" class="button_select"></c:verbatim>
         </h:panelGroup>
         <h:outputText value="" />
         <h:outputText value="" />

         <h:outputText  styleClass="td_form_required" value="合同约定起始时间" />
         <h:panelGroup>
             <h:inputText id="contStartDate" styleClass="input" size="10" value="#{cont_contFollowSignBB.bo.contStartDate}" readonly="true" alt="合同约定起始时间|0"/>
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:contStartDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText value="合同约定终止时间" />
         <h:panelGroup>
            <h:inputText id="contEndDate" styleClass="input" size="10" value="#{cont_contFollowSignBB.bo.contEndDate}" readonly="true" />
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:contEndDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText  styleClass="td_form_required" value="合同约定工作地点" />
         <h:inputTextarea id="workPlace" rows="2" cols="28"   value="#{cont_contFollowSignBB.bo.workPlace}"/>

         <h:outputText  styleClass="td_form_required" value="合同约定工作内容" />
         <h:inputTextarea id="workContent" rows="2" cols="28"   value="#{cont_contFollowSignBB.bo.workContent}"/>

         <h:outputText  styleClass="td_form_required" value="合同约定工作岗位" />
         <h:inputText styleClass="input" id="postName" size = "30" maxlength="15" value="#{cont_contFollowSignBB.bo.postName}" alt="合同约定工作岗位|0|s" />

        <h:outputText  value="合同约定工时制度" />
         <h:panelGroup>
             <h:inputText styleClass="input" value="#{cont_contFollowSignBB.bo.workTimeSet}" id="workTimeSet"  size="28" code="" dict="yes" dict_num="2024" readonly="true" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:workTimeSet')" class="button_select"></c:verbatim>
         </h:panelGroup>

         <h:outputText value="服务期起始时间" />
         <h:panelGroup>
             <h:inputText id="serviceStartDate" styleClass="input" size="10" value="#{cont_contFollowSignBB.bo.serviceStartDate}" readonly="true"/>
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:serviceStartDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText  value="服务期终止时间" />
         <h:panelGroup>
            <h:inputText id="serviceEndDate" styleClass="input" size="10" value="#{cont_contFollowSignBB.bo.serviceEndDate}" readonly="true" />
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:serviceEndDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText value="合同约定劳动报酬形式" />
         <h:panelGroup>
            <h:inputTextarea id="salaryClass" rows="2" cols="28"   value="#{cont_contFollowSignBB.bo.salaryClass}"/>
         </h:panelGroup>
         <h:outputText value="合同约定工资构成" />
         <h:panelGroup>
            <h:inputTextarea id="salaryInclude" rows="2" cols="28"   value="#{cont_contFollowSignBB.bo.salaryInclude}"/>
         </h:panelGroup>

         <h:outputText value="合同约定发薪日" />
         <h:inputText styleClass="input" id="paySalaryDate"  size = "30" maxlength="30" value="#{cont_contFollowSignBB.bo.paySalaryDate}" alt="合同约定发薪日|1|s" />
         <h:outputText value="" />
         <h:outputText value="" />

         <h:outputText value="工资标准" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="standardSalaryMoney" value="#{cont_contFollowSignBB.bo.standardSalaryMoney}" maxlength="10" alt="工资标准|1|f" />
            <h:outputText value=" 元/月" />
         </h:panelGroup>
         <h:outputText value="基本工资标准" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="basicSalaryMoney" value="#{cont_contFollowSignBB.bo.basicSalaryMoney}" maxlength="10" alt="基本工资标准|1|f" />
            <h:outputText value=" 元/月" />
         </h:panelGroup>

         <h:outputText value="绩效工资标准" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="performanceSalaryMoney" value="#{cont_contFollowSignBB.bo.performanceSalaryMoney}" maxlength="10" alt="绩效工资标准|1|f" />
            <h:outputText value=" 元/月" />
         </h:panelGroup>
         <h:outputText value="" />
         <h:outputText value="" />

         <h:outputText value="竞业限制期限" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="jobLimitTerm" value="#{cont_contFollowSignBB.bo.jobLimitTerm}" maxlength="10" alt="竞业限制期限|1|i" />
            <h:outputText value=" 月" />
         </h:panelGroup>
         <h:outputText value="合同违约金额" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="fellbackMoney" value="#{cont_contFollowSignBB.bo.fellbackMoney}" maxlength="10" alt="合同违约金额|1|f" />
            <h:outputText value=" 元" />
         </h:panelGroup>

         <h:outputText value="劳动合同摘要" />
         <h:panelGroup>
             <h:inputTextarea id="contRemark" rows="4" cols="28"  value="#{cont_contFollowSignBB.bo.contRemark}"/>
         </h:panelGroup>

         <h:outputText value="是否同意鉴证" />
         <h:panelGroup>
             <h:inputText value="#{cont_contFollowSignBB.bo.agreeTestify}" id="agreeTestify" styleClass="input"  code="" dict="yes" dict_num="2023" readonly="true" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:agreeTestify')" class="button_select"></c:verbatim>
         </h:panelGroup>
     </h:panelGrid>

     <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="2">
                <h:commandButton styleClass="button01" value="保存" action="#{cont_contFollowSignBB.save_edit}"  onclick="if( checkSubmit(document.forms(0))&&checkAll(document.forms(0)) ){ return confirmSave(document.forms(0));}else{return false;}"/>
                <h:commandButton styleClass="button01" value="取消返回" action="#{cont_contFollowSignBB.forwardList}"/>
     </h:panelGrid>

</h:form>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
