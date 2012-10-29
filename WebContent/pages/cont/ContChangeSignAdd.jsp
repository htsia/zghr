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
             alert("请选择一个合同模板或上传一个本地模板文件！");
             flag = false;
             return flag;

        }
        if ( (myFileId != "" && myFileId != null) && (templateId != "" && templateId != null) ) {
             alert("请确定你将使用合同模板还是上传的本地模板文件？二者只能选其一！");
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
        var name = form1.all("form1:workPlace").value;
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
        name = form1.all("form1:contTermClass").code;
        //合同变更约定劳动关系终止时间
        var contEndDate = form1.all("form1:contEndDate").value;
        if (name == "02152") {
            if (contEndDate == "" || contEndDate == null) {
                alert("当合同期限类型为固定期限时，变更合同约定劳动关系终止时间不能为空！");
                flag = false;
                return flag;
             }
        }else if(name == "02151"){
            if (contEndDate != "" && contEndDate != null) {
                alert("当合同期限类型为无固定期限时，变更合同约定劳动关系终止时间不能填写！");
                flag = false;
                return flag;
            }
        }

        //合同变更开始时间
        var contStartDate = form1.all("form1:contStartDate").value;

        if (contEndDate.trim() != "" && contStartDate.trim() != "") {
            var sT = contEndDate.split("-");
            var stemp = new Date(sT[0], sT[1],  sT[2],"01");
            var wT = contStartDate.split("-");
            var wtemp = new Date(wT[0], wT[1], wT[2],"01");
            if ((stemp.getTime() - wtemp.getTime()) <= 0) {
                alert("变更合同约定劳动关系终止时间必须大于合同变更时间!");
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
        disPlayProcessBar();
        return true;
    } else {
        return false;
    }
}
</script>

<h:form id="form1" enctype="multipart/form-data" >
<h:panelGrid width="100%" border="0" cellspacing="6" styleClass="td_title" cellpadding="0" >
   <h:panelGroup>
       <h:graphicImage value="/images/tips.gif" />
       <h:outputText value="合同变更维护" ></h:outputText>
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
            <h:inputHidden id="ManyPerson" value="#{cont_contChangeSignBB.nameStrs}"></h:inputHidden>
            <h:commandButton value="多人查询" id="queryPerson2" onclick="return doQueryManyPerson()" styleClass="button01"
                             action="#{cont_contChangeSignBB.queryMultPerson}"/>
        </h:panelGroup>

         <h:commandButton id="advance1" styleClass="button01"  value="自定义查询查询" action="#{cont_contChangeSignBB.selPerson}" onclick="return queryPerson();"/>
         <h:commandButton styleClass="button01" value="去除人员" action="#{cont_contChangeSignBB.delPerson}" onclick="javascript:return delPerson();"/>
    </h:panelGrid>
</h:panelGrid>

<c:verbatim>
<table id="ryTable" width="850" border="0" align="center" height=180>
  <tr><td>
          <jsp:include page="/pages/common/activepage/ActiveList.jsp">
              <jsp:param name="target" value="cont_selPerObjs"/>
              <jsp:param name="hasOperSign" value="true"/>
              <jsp:param name="operSignType" value="checkbox"/>
              <jsp:param name="isPage" value="false"/>
          </jsp:include>
  </td></tr>
</table>
</c:verbatim>

<h:panelGrid  border="0"  cellpadding="0"  cellspacing="0"  align="center" columns="1" width="800">
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <h:outputText value="录入信息" styleClass="td05"/>
    </h:panelGrid>
</h:panelGrid>
<h:inputHidden id="contId" value="#{cont_contChangeSignBB.bo.contId}"/>
<h:inputHidden id="contCode" value="#{cont_contChangeSignBB.bo.contCode}"/>
<h:inputHidden id="personId" value="#{cont_contChangeSignBB.bo.personId}"/>
<h:inputHidden id="personName" value="#{cont_contChangeSignBB.bo.personName}"/>
<h:inputHidden id="attachmentId" value="#{cont_contChangeSignBB.bo.attachmentId}"/>
<h:inputHidden id="createOrgId" value="#{cont_contChangeSignBB.bo.createOrgId}"/>
<h:inputHidden id="isValid" value="#{cont_contChangeSignBB.bo.isValid}"/>
<h:inputHidden id="contCreateDate" value="#{cont_contChangeSignBB.bo.contCreateDate}"/>

<h:panelGrid width="800" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02">
         <h:outputText styleClass="td_form_required" value="合同编号" />
         <h:outputText value=""/>
         <h:outputText  value="模板类别" />
         <h:selectOneMenu value="#{cont_contChangeSignBB.bo.templateClassId}" id="templateClassId" onchange="javascript:pageCodeExchange(document.forms(0));submit(); "  valueChangeListener="#{cont_contChangeSignBB.templateClassChanged}">
                    <c:selectItems value="#{cont_contChangeSignBB.item_templateClass}"/>
         </h:selectOneMenu>

         <h:outputText styleClass="td_form_required" value="合同处理类别" />
         <h:inputText styleClass="input" value="#{cont_contChangeSignBB.bo.contClass}" id="contClass"  code="" dict="yes" dict_num="0220" readonly="true" alt="合同处理类别|0"/>

         <h:outputText  value="合同模板" />
         <h:panelGroup>
         <h:selectOneMenu value="#{cont_contChangeSignBB.bo.templateId}" id="templateId" >
                    <c:selectItems value="#{cont_contChangeSignBB.item_template}"/>
         </h:selectOneMenu>
         </h:panelGroup>

         <h:outputText styleClass="td_form_required" value="合同期限类型" />
         <h:panelGroup>
             <h:inputText styleClass="input" value="#{cont_contChangeSignBB.bo.contTermClass}" id="contTermClass"  code="" dict="yes" dict_num="0215" readonly="true" alt="合同期限类型|0" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:contTermClass')" class="button_select"></c:verbatim>
         </h:panelGroup>
         <h:outputText value="上传本地模板文件"></h:outputText>
         <x:inputFileUpload id="myFileId"
			        value="#{cont_contChangeSignBB.myFile}"
                    styleClass="input"
                    storage="file"/>

         <h:outputText  styleClass="td_form_required" value="合同变更时间" />
         <h:panelGroup>
             <h:inputText id="contStartDate" styleClass="input" size="10" value="#{cont_contChangeSignBB.bo.contStartDate}" readonly="true" alt="合同变更时间|0"/>
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:contStartDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText value="变更合同约定劳动关系终止时间" />
         <h:panelGroup>
            <h:inputText id="contEndDate" styleClass="input" size="10" value="#{cont_contChangeSignBB.bo.contEndDate}" readonly="true"/>
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:contEndDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText  styleClass="td_form_required" value="合同约定工作地点" />
         <h:inputTextarea id="workPlace" rows="2" cols="28"   value="#{cont_contChangeSignBB.bo.workPlace}"/>

         <h:outputText  styleClass="td_form_required" value="合同约定工作内容" />
         <h:inputTextarea id="workContent" rows="2" cols="28"   value="#{cont_contChangeSignBB.bo.workContent}"/>

         <h:outputText  styleClass="td_form_required" value="合同约定工作岗位" />
         <h:inputText styleClass="input" id="postName"  size = "30" maxlength="15" value="#{cont_contChangeSignBB.bo.postName}" alt="合同约定工作岗位|0|s" />

          <h:outputText  value="合同约定工时制度" />
         <h:panelGroup>
             <h:inputText styleClass="input" value="#{cont_contChangeSignBB.bo.workTimeSet}" size="28" id="workTimeSet"  code="" dict="yes" dict_num="2024" readonly="true" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:workTimeSet')" class="button_select"></c:verbatim>
         </h:panelGroup>

         <h:outputText value="服务期起始时间" />
         <h:panelGroup>
             <h:inputText id="serviceStartDate" styleClass="input" size="10" value="#{cont_contChangeSignBB.bo.serviceStartDate}" readonly="true"/>
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:serviceStartDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText  value="服务期终止时间" />
         <h:panelGroup>
            <h:inputText id="serviceEndDate" styleClass="input" size="10" value="#{cont_contChangeSignBB.bo.serviceEndDate}" readonly="true" />
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:serviceEndDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText value="合同约定劳动报酬形式" />
         <h:panelGroup>
            <h:inputTextarea id="salaryClass" rows="2" cols="28"   value="#{cont_contChangeSignBB.bo.salaryClass}"/>
         </h:panelGroup>
         <h:outputText value="合同约定工资构成" />
         <h:panelGroup>
            <h:inputTextarea id="salaryInclude" rows="2" cols="28"   value="#{cont_contChangeSignBB.bo.salaryInclude}"/>
         </h:panelGroup>

         <h:outputText value="合同约定发薪日" />
         <h:inputText styleClass="input" id="paySalaryDate"  size = "30" maxlength="30" value="#{cont_contChangeSignBB.bo.paySalaryDate}" alt="合同约定发薪日|1|s" />
         <h:outputText value="" />
         <h:outputText value="" />

         <h:outputText value="工资标准" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="standardSalaryMoney" value="#{cont_contChangeSignBB.bo.standardSalaryMoney}" maxlength="10" alt="工资标准|1|f" />
            <h:outputText value=" 元/月" />
         </h:panelGroup>
         <h:outputText value="基本工资标准" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="basicSalaryMoney" value="#{cont_contChangeSignBB.bo.basicSalaryMoney}" maxlength="10" alt="基本工资标准|1|f" />
            <h:outputText value=" 元/月" />
         </h:panelGroup>

         <h:outputText value="绩效工资标准" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="performanceSalaryMoney" value="#{cont_contChangeSignBB.bo.performanceSalaryMoney}" maxlength="10" alt="绩效工资标准|1|f" />
            <h:outputText value=" 元/月" />
         </h:panelGroup>
         <h:outputText value="" />
         <h:outputText value="" />

         <h:outputText value="竞业限制期限" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="jobLimitTerm" value="#{cont_contChangeSignBB.bo.jobLimitTerm}" maxlength="10" alt="竞业限制期限|1|i" />
            <h:outputText value=" 月" />
         </h:panelGroup>
         <h:outputText value="合同违约金额" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="fellbackMoney" value="#{cont_contChangeSignBB.bo.fellbackMoney}" maxlength="10" alt="合同违约金额|1|f" />
            <h:outputText value=" 元" />
         </h:panelGroup>

         <h:outputText value="劳动合同摘要" />
         <h:panelGroup>
             <h:inputTextarea id="contRemark" rows="4" cols="28"  value="#{cont_contChangeSignBB.bo.contRemark}"/>
         </h:panelGroup>

         <h:outputText value="是否同意鉴证" />
         <h:panelGroup>
             <h:inputText value="#{cont_contChangeSignBB.bo.agreeTestify}" id="agreeTestify" styleClass="input"  code="" dict="yes" dict_num="2023" readonly="true" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:agreeTestify')" class="button_select"></c:verbatim>
         </h:panelGroup>
</h:panelGrid>

     <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="right" columns="2">
                <h:commandButton styleClass="button01" value="保存" action="#{cont_contChangeSignBB.save_add}"  onclick="if( checkSubmit(document.forms(0))&&checkAll(document.forms(0)) ){ return confirmSave(document.forms(0));}else{return false;}"/>
                <h:commandButton styleClass="button01" value="取消返回" action="#{cont_contChangeSignBB.forwardList}"/>
     </h:panelGrid>
</h:form>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>
