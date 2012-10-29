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
        var name = form1.all("form1:contRemark").value;
        if (name != "" && name != null) {
            if (name.length>50) {
                alert("中止合同摘要容限制最多只能输入50个汉字！");
                flag = false;
                return flag;
            }
        }
      //合同中止开始时间
      var contStartDate = form1.all("form1:contStartDate").value;
      //合同中止结束时间
      var contEndDate = document.all("form1:contEndDate").value;
      //合同实际结束时间
      var contFactEndDate = document.all("form1:contFactEndDate").value;

      if (contStartDate.trim() != "" && contEndDate.trim() != "") {
         var sT = contEndDate.split("-");
         var stemp = new Date(sT[0], sT[1],  sT[2],"01");
         var wT = contStartDate.split("-");
         var wtemp = new Date(wT[0], wT[1], wT[2],"01");
         if ((stemp.getTime() - wtemp.getTime()) <= 0) {
            alert("中止合同约定结束时间必须大于中止合同约定开始时间!");
            flag = false;
            return flag;
        }
         if ((contEndDate.substr(0, 4) - contStartDate.substr(0, 4)) > 5) {
            alert("中止时长不能超过5年!");
            flag = false;
            return flag;
        }
      }
      if (contFactEndDate.trim() != "" && contEndDate.trim() != "") {
             var sT = contFactEndDate.split("-");
             var stemp = new Date(sT[0], sT[1],  sT[2],"01");
             var wT = contEndDate.split("-");
             var wtemp = new Date(wT[0], wT[1], wT[2],"01");
             if ((stemp.getTime() - wtemp.getTime()) < 0) {
                alert("合同实际结束时间必须大于等于中止合同约定结束时间!");
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
<body>
<h:panelGrid width="100%" border="0" cellspacing="6" cellpadding="0" >
   <h:outputText value="合同中止维护" styleClass="td_title" style="width:100%"></h:outputText>
</h:panelGrid>
<h:form id="form1" enctype="multipart/form-data" >
<h:inputHidden id="str_2" value="#{cont_contPauseSignBB.selectContIds}"/>
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
<center>
<table id="ryTable" width="850" border="0" align="center">
  <tr><td>
<jsp:include page="../cont/ActiveList.jsp"></jsp:include>
  </td></tr>
</table>
</center>
<br/>
<h:panelGrid  border="0"  cellpadding="0"  cellspacing="0"  align="center" columns="1" width="800">
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <h:outputText value="录入信息" styleClass="td05"/>
    </h:panelGrid>
</h:panelGrid>
<h:inputHidden id="contId" value="#{cont_contPauseSignBB.bo.contId}"/>
<h:inputHidden id="contCode" value="#{cont_contPauseSignBB.bo.contCode}"/>
<h:inputHidden id="personId" value="#{cont_contPauseSignBB.bo.personId}"/>
<h:inputHidden id="personName" value="#{cont_contPauseSignBB.bo.personName}"/>
<h:inputHidden id="attachmentId" value="#{cont_contPauseSignBB.bo.attachmentId}"/>
<h:inputHidden id="createOrgId" value="#{cont_contPauseSignBB.bo.createOrgId}"/>
<h:inputHidden id="isValid" value="#{cont_contPauseSignBB.bo.isValid}"/>
<h:inputHidden id="contCreateDate" value="#{cont_contPauseSignBB.bo.contCreateDate}"/>
<h:panelGrid width="800" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02">
         <h:outputText  styleClass="td_form_required" value="合同编号" />
         <h:outputText value="#{cont_contPauseSignBB.bo.contCode}"/>
         <h:outputText value="模板类别" />
         <h:selectOneMenu value="#{cont_contPauseSignBB.bo.templateClassId}" id="templateClassId" onchange="javascript:pageCodeExchange(document.forms(0));submit(); "  valueChangeListener="#{cont_contPauseSignBB.templateClassChanged}">
                    <c:selectItems value="#{cont_contPauseSignBB.item_templateClass}"/>
         </h:selectOneMenu>

         <h:outputText  styleClass="td_form_required" value="合同处理类别" />
         <h:inputText styleClass="input" value="#{cont_contPauseSignBB.bo.contClass}" id="contClass"  code="" dict="yes" dict_num="0220" readonly="true" alt="合同处理类别|0"/>

         <h:outputText value="合同模板" />
         <h:panelGroup>
         <h:selectOneMenu value="#{cont_contPauseSignBB.bo.templateId}" id="templateId" >
                    <c:selectItems value="#{cont_contPauseSignBB.item_template}"/>
         </h:selectOneMenu>
         </h:panelGroup>

         <h:outputText  styleClass="td_form_required" value="中止合同约定开始时间" />
         <h:panelGroup>
             <h:inputText id="contStartDate" styleClass="input" size="10" value="#{cont_contPauseSignBB.bo.contStartDate}" readonly="true" alt="中止合同约定开始时间|0"/>
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:contStartDate')"> </c:verbatim>
         </h:panelGroup>

         <h:outputText  styleClass="td_form_required" value="中止合同约定结束时间" />
         <h:panelGroup>
            <h:inputText id="contEndDate" styleClass="input" size="10" value="#{cont_contPauseSignBB.bo.contEndDate}" readonly="true" alt="中止合同约定结束时间|0"/>
            <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:contEndDate')"> </c:verbatim>
         </h:panelGroup>

    <h:outputText value="合同实际结束时间" />
    <h:panelGroup>
       <h:inputText id="contFactEndDate" styleClass="input" size="10" value="#{cont_contPauseSignBB.bo.contFactEndDate}" readonly="true"/>
       <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:contFactEndDate')"> </c:verbatim>
    </h:panelGroup>

    <h:outputText value="上传本地模板文件"></h:outputText>
         <x:inputFileUpload id="myFileId"
			        value="#{cont_contPauseSignBB.myFile}"
			        storage="file"/>

    <h:outputText value="竞业限制期限" />
    <h:panelGroup>
       <h:inputText styleClass="input" id="jobLimitTerm" value="#{cont_contPauseSignBB.bo.jobLimitTerm}" maxlength="10" alt="竞业限制期限|1|i" />
       <h:outputText value=" 月" />
    </h:panelGroup>
     <h:outputText value="合同违约金额" />
    <h:panelGroup>
       <h:inputText styleClass="input" id="fellbackMoney" value="#{cont_contPauseSignBB.bo.fellbackMoney}" maxlength="10" alt="合同违约金额|1|f" />
       <h:outputText value=" 元" />
    </h:panelGroup>

    <h:outputText value="中止合同摘要" />
    <h:panelGroup>
        <h:inputTextarea id="contRemark" rows="4" cols="28"  value="#{cont_contPauseSignBB.bo.contRemark}"/>
    </h:panelGroup>

    <h:outputText value="是否同意鉴证" />
    <h:panelGroup>
        <h:inputText value="#{cont_contPauseSignBB.bo.agreeTestify}" id="agreeTestify" styleClass="input"  code="" dict="yes" dict_num="2023" readonly="true" />
        <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:agreeTestify')" class="button_select"></c:verbatim>
    </h:panelGroup>

</h:panelGrid>
     <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="2">
                <h:commandButton styleClass="button01" value="保存" action="#{cont_contPauseSignBB.save_edit}"  onclick="if( checkSubmit(document.forms(0))&&checkAll(document.forms(0)) ){ return confirmSave(document.forms(0));}else{return false;}"/>
                <h:commandButton styleClass="button01" value="取消返回" action="#{cont_contPauseSignBB.forwardList}"/>
     </h:panelGrid>

</h:form>
<c:verbatim>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
</c:verbatim>
</body>
</html>