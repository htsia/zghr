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
             alert("请选择一个协议模板或上传一个本地模板文件！");
             flag = false;
             return flag;

        }
        if ( (myFileId != "" && myFileId != null) && (templateId != "" && templateId != null) ) {
             alert("请确定你将使用协议模板还是上传的本地模板文件？二者只能选其一！");
             flag = false;
             return flag;

        }
        if (templateId != "" && templateId != null) {
            if (templateClassId == "" || templateClassId == null) {
               alert("模板类别不能为空！");
               flag = false;
               return flag;
            }
        }
        if (myFileId != "" && myFileId != null) {
             if( myFileId.lastIndexOf(".rtf")==-1 ){
                alert("上传模板文件必须是*.rtf格式文件！");
                flag = false;
                return flag;
             }
        }

        var contRemark = form1.all("form1:contRemark").value;
        if (contRemark != "" && contRemark != null) {
            if (name.length>50) {
                alert("协议摘要容限制最多只能输入50个汉字！");
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
      alert("请选择人员！");
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
        if (confirm('确定要做保存吗？')) {
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
        <h:outputText value="协议签订维护" ></h:outputText>
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
        <c:verbatim escape="false"><a href="javascript:showHide(ryTable);"><b>  人员信息(共<%=rowCount%>条记录)</b></a></c:verbatim>
    </h:panelGrid>
    <h:panelGrid  border="0"  cellspacing="0" align="right" columns="3" >
        <h:panelGroup>
            <h:inputHidden id="ManyPerson" value="#{cont_protSignBB.nameStrs}"></h:inputHidden>
            <h:commandButton value="多人查询" id="queryPerson2" onclick="return doQueryManyPerson()" styleClass="button01"
                             action="#{cont_protSignBB.queryMultPerson}"/>
        </h:panelGroup>

         <h:commandButton id="advance1" styleClass="button01"  value="自定义查询" action="#{cont_protSignBB.selPerson}" onclick="return queryPerson();"/>
         <h:commandButton styleClass="button01" value="去除人员" action="#{cont_protSignBB.delPerson}" onclick="javascript:return delPerson();"/>
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
        <h:outputText value="录入信息" styleClass="td05"/>
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
         <h:outputText  styleClass="td_form_required" value="协议编号" />
         <h:outputText value=""/>
         <h:outputText value="模板类别" />
         <h:selectOneMenu value="#{cont_protSignBB.bo.templateClassId}" id="templateClassId" onchange="javascript:pageCodeExchange(document.forms(0));submit(); "  valueChangeListener="#{cont_protSignBB.templateClassChanged}">
                    <c:selectItems value="#{cont_protSignBB.item_templateClass}"/>
         </h:selectOneMenu>

        <h:outputText styleClass="td_form_required"  value="协议类别" />
         <h:selectOneMenu value="#{cont_protSignBB.bo.protClass}" id="protClass">
                    <c:selectItem itemValue="022211" itemLabel="竞业限制协议" />
                    <c:selectItem itemValue="022212" itemLabel="培训协议" />
                    <c:selectItem itemValue="022213" itemLabel="内退协议" />
                    <c:selectItem itemValue="022214" itemLabel="待岗协议" />
                    <c:selectItem itemValue="022219" itemLabel="其他协议" />
         </h:selectOneMenu>

         <h:outputText value="协议模板" />
         <h:panelGroup>
         <h:selectOneMenu value="#{cont_protSignBB.bo.templateId}" id="templateId" >
                    <c:selectItems value="#{cont_protSignBB.item_template}"/>
         </h:selectOneMenu>
         </h:panelGroup>

         <h:outputText value="协议约定劳动关系终止时间" />
         <h:panelGroup>
            <h:inputText id="contEndDate" styleClass="input" size="10" value="#{cont_protSignBB.bo.contEndDate}" readonly="true"/>
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:contEndDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText value="上传本地模板文件"></h:outputText>
         <x:inputFileUpload id="myFileId"
			        value="#{cont_protSignBB.myFile}"
			        storage="file"/>

         <h:outputText value="服务期起始时间" />
         <h:panelGroup>
             <h:inputText id="serviceStartDate" styleClass="input" size="10" value="#{cont_protSignBB.bo.serviceStartDate}" readonly="true"/>
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:serviceStartDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText  value="服务期终止时间" />
         <h:panelGroup>
            <h:inputText id="serviceEndDate" styleClass="input" size="10" value="#{cont_protSignBB.bo.serviceEndDate}" readonly="true" />
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:serviceEndDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText value="合同约定工资构成" />
         <h:panelGroup>
            <h:inputTextarea id="salaryInclude" rows="2" cols="28"   value="#{cont_protSignBB.bo.salaryInclude}"/>
         </h:panelGroup>

         <h:outputText value="合同约定发薪日" />
         <h:inputText styleClass="input" id="paySalaryDate"  size = "30" maxlength="30" value="#{cont_protSignBB.bo.paySalaryDate}" alt="合同约定发薪日|1|s" />


         <h:outputText value="工资标准" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="standardSalaryMoney" value="#{cont_protSignBB.bo.standardSalaryMoney}" maxlength="10" alt="工资标准|1|f" />
            <h:outputText value=" 元/月" />
         </h:panelGroup>
         <h:outputText value="基本工资标准" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="basicSalaryMoney" value="#{cont_protSignBB.bo.basicSalaryMoney}" maxlength="10" alt="基本工资标准|1|f" />
            <h:outputText value=" 元/月" />
         </h:panelGroup>

         <h:outputText value="绩效工资标准" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="performanceSalaryMoney" value="#{cont_protSignBB.bo.performanceSalaryMoney}" maxlength="10" alt="绩效工资标准|1|f" />
            <h:outputText value=" 元/月" />
         </h:panelGroup>
         <h:outputText value="" />
         <h:outputText value="" />


         <h:outputText value="竞业限制期限" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="jobLimitTerm" value="#{cont_protSignBB.bo.jobLimitTerm}" maxlength="10" alt="竞业限制期限|1|i" />
            <h:outputText value=" 月" />
         </h:panelGroup>
         <h:outputText value="合同违约金额" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="fellbackMoney" value="#{cont_protSignBB.bo.fellbackMoney}" maxlength="10" alt="合同违约金额|1|f" />
            <h:outputText value=" 元" />
         </h:panelGroup>

         <h:outputText value="协议摘要" />
         <h:panelGroup>
             <h:inputTextarea id="contRemark" rows="4" cols="28"  value="#{cont_protSignBB.bo.contRemark}"/>
         </h:panelGroup>

          <h:outputText value="是否同意鉴证" />
         <h:panelGroup>
             <h:inputText value="#{cont_protSignBB.bo.agreeTestify}" id="agreeTestify" styleClass="input"  code="" dict="yes" dict_num="2023" readonly="true" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:agreeTestify')" class="button_select"></c:verbatim>
         </h:panelGroup>
</h:panelGrid>
     <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="2">
                <h:commandButton styleClass="button01" value="保存" action="#{cont_protSignBB.save_add}" onclick="if( checkSubmit(document.forms(0))&&checkAll(document.forms(0)) ){ return confirmSave(document.forms(0));}else{return false;}"/>
                <h:commandButton styleClass="button01" value="取消返回" action="#{cont_protSignBB.forwardList}"/>
     </h:panelGrid>

</h:form>
<c:verbatim>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
</c:verbatim>