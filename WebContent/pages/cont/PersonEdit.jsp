<%@ page contentType="text/html;charset=GBK" language="java" %>

<%@ page import="com.hr319wg.cont.web.ContPersonBackingBean"%>
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
function checkSubmit(form1) {
    flag = true;
    var name = form1.all("form1:jobType").value;
        if (name == "" || name == null) {
            alert("用工类别不能为空！");
             flag = false;
             return flag;
        }

    //出生日期
    var birth = form1.all("form1:personBirthday").value;
    //身份证
    var IdCard = form1.all("form1:IdCard").value;

    if (IdCard.trim() != "") {
        if ( IdCard.length != 15 && IdCard.length != 18 ) {
            alert("你输入的身份证号码有误,请输入15或18位身份证号码!");
            flag = false;
            return flag;
        }else if(IdCard.length == 15){
            if(birth.trim() != ""){
               tmpCard = IdCard.substring(6,12);
               var tmpBirth = birth.replace(/\-/g,"");
               if(tmpCard != tmpBirth.substring(2)){
                   alert("提示：你输入的身份证号码和出生日期不匹配！");

               }
            }
        }else if(IdCard.length == 18){
            if(birth.trim() != ""){
               tmpCard = IdCard.substring(6,14);
               var tmpBirth = birth.replace(/\-/g,"");
               if(tmpCard != tmpBirth ){
                   alert("提示：你输入的身份证号码和出生日期不匹配！");

               }
            }
        }
    }
    //学历
    var personEducation = form1.all("form1:personEducation").code;
    var tempcode = personEducation.substr(1);
    //专业名称
    var personSpeciality = form1.all("form1:personSpeciality").value;
    if (personEducation!=null&&personEducation.trim() != "") {
        if ( tempcode< 36540 ) {
            if(personSpeciality==null||personSpeciality == ""){
                alert("当学历为中专以上时，必须输入专业名称!");
                flag = false;
                return flag;
            }
        }
        if ( tempcode>= 36560 ) {
            if(personSpeciality != ""){
                alert("当学历为高中以下时，专业名称不须输入!");
                flag = false;
                return flag;
            }
        }
    }
    //出生日期
    var birth = form1.all("form1:personBirthday").value;
    //参加工作时间
    var workTime = form1.all("form1:attendWorkTime").value;
    //进入公司时间
    var sysTime = document.all("form1:createDate").value;


    if (birth.trim() != "" && workTime.trim() != "") {
        if ((workTime.substr(0, 4) - birth.substr(0, 4)) < 10) {
            alert("参加工作时间必须大于出生日期10年!");
            flag = false;
            return flag;
        }
    }
    
    if (sysTime.trim() != "" && workTime.trim() != "") {
        var sT = sysTime.split("-");
        var stemp = new Date(sT[0], sT[1], "01");
        var wT = workTime.split("-");
        var wtemp = new Date(wT[0], wT[1], "01");
        if ((stemp.getTime() - wtemp.getTime()) < 0) {
            alert("来公司时间必须大于等于参加工作时间!");
            flag = false;
            return flag;
        }
    }


    return flag;
}
function confirmSave(form1){
    var personId = form1.all("form1:personId").value;
    if(personId!=null&&personId.trim()!=""){
        if (confirm('如果此人员已新签合同，其合同电子文本会使用当前人员信息重新生成，确定要做保存吗？')) {
            pageCodeExchange(form1);
            return true;
        } else {
            return false;
        }
    }else{
        pageCodeExchange(form1);
        return true;
    }
}
</script>
<body>
<h:panelGrid width="100%" border="0" cellspacing="6" cellpadding="0" >
   <h:outputText value="新员工信息维护 " styleClass="td_title" style="width:100%"></h:outputText>
</h:panelGrid>
<h:form id="form1">
    <h:inputHidden id="personId" value="#{cont_contPersonBB.bo.personId}"/>
    <h:inputHidden id="personCode" value="#{cont_contPersonBB.bo.personCode}"/>
    <h:inputHidden id="approveStatus" value="#{cont_contPersonBB.bo.approveStatus}"/>
    <h:inputHidden id="isValid" value="#{cont_contPersonBB.bo.isValid}"/>

    <h:panelGrid width="600" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02">
         <h:outputText  styleClass="td_form_required" value="员工编号" />
         <h:outputText value="#{cont_contPersonBB.bo.personCode}" />
         <h:outputText value="" />
         <h:outputText value="" />

         <h:outputText  styleClass="td_form_required" value="姓名" />
         <h:inputText styleClass="input" id="personName" value="#{cont_contPersonBB.bo.personName}" maxlength="15" alt="姓名|0|s" />
<%
    ContPersonBackingBean bb = (ContPersonBackingBean)request.getAttribute("cont_contPersonBB");

%>
         <h:outputText  styleClass="td_form_required" value="用工类别" />
         <h:selectOneMenu value="#{cont_contPersonBB.bo.jobType}" id="jobType">
<%

    if(bb.getRightLongFlag()){
%>
                    <c:selectItem itemValue="013511" itemLabel="中长期劳动合同员工" />
<%
    }
    if(bb.getRightShortFlag()){
%>
                    <c:selectItem itemValue="013512" itemLabel="短期劳动合同员工" />
<%
    }
%>

         </h:selectOneMenu>

        <h:outputText  styleClass="td_form_required" value="增员类别" />
        <h:panelGroup>
                <h:inputText styleClass="input" value="#{cont_contPersonBB.bo.addPersonClass}" id="addPersonClass"  code="" dict="yes" dict_num="0200" readonly="true" alt="增员类别|0" />
                <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:addPersonClass','0200110001,0200120001,0200130000,0200140001')" class="button_select"></c:verbatim>
        </h:panelGroup>

        <h:outputText value="来往单位" />
        <h:inputText styleClass="input" size="30" id="exchangeOrgName" value="#{cont_contPersonBB.bo.exchangeOrgName}" maxlength="25" />

        <h:outputText  styleClass="td_form_required" value="性别" />
        <h:panelGroup>
                <h:inputText styleClass="input" value="#{cont_contPersonBB.bo.personSex}" id="personSex"  code="" dict="yes" dict_num="0100" readonly="true" alt="性别|0" />
                <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:personSex')" class="button_select"></c:verbatim>
        </h:panelGroup>
        <h:outputText  styleClass="td_form_required" value="出生日期" />
        <h:panelGroup>
               <h:inputText styleClass="input" id="personBirthday" size="10" value="#{cont_contPersonBB.bo.personBirthday}" readonly="true" alt="出生日期|0"/>
               <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:personBirthday')"></c:verbatim>
        </h:panelGroup>

        <h:outputText  styleClass="td_form_required" value="民族" />
        <h:panelGroup>
                <h:inputText styleClass="input" value="#{cont_contPersonBB.bo.personFolk}" id="personFolk"  code="" dict="yes" dict_num="0115" readonly="true" alt="民族|0" />
                <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:personFolk')" class="button_select"></c:verbatim>
        </h:panelGroup>

        <h:outputText  styleClass="td_form_required" value="政治面貌" />
        <h:panelGroup>
                <h:inputText styleClass="input" value="#{cont_contPersonBB.bo.personPolity}" id="personPolity"  code="" dict="yes" dict_num="0120" readonly="true" alt="政治面貌|0" />
                <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:personPolity')" class="button_select"></c:verbatim>
        </h:panelGroup>

        <h:outputText styleClass="td_form_required"  value="身份证号码" />
        <h:inputText styleClass="input" size="23" id="IdCard" value="#{cont_contPersonBB.bo.idCard}" alt="身份证号码|0|s" maxlength="18"/>
        

        <h:outputText value="家庭居住地址" />
        <h:inputText styleClass="input" size="30" id="personHometown" value="#{cont_contPersonBB.bo.personHometown}" maxlength="60" />

         <h:outputText value="邮政编码" />
         <h:inputText styleClass="input" id="personPostalcode" value="#{cont_contPersonBB.bo.personPostalcode}" maxlength="6" alt="邮政编码|1|i" />
         <h:outputText value="" />
         <h:outputText value="" />

        <h:outputText  styleClass="td_form_required"  value="毕业院校" />
        <h:inputText styleClass="input" id="graduateSchool" value="#{cont_contPersonBB.bo.graduateSchool}" maxlength="20" alt="毕业院校|0" />

        <h:outputText  styleClass="td_form_required" value="毕业时间" />
        <h:panelGroup>
                 <h:inputText styleClass="input" id="graduateDate" size="10" value="#{cont_contPersonBB.bo.graduateDate}" readonly="true" alt="毕业时间|0"/>
                 <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDlg_OnlyMonth('form1:graduateDate')"></c:verbatim>
        </h:panelGroup>

        <h:outputText  styleClass="td_form_required" value="学历" />
        <h:panelGroup>
                 <h:inputText styleClass="input" value="#{cont_contPersonBB.bo.personEducation}" id="personEducation"  code="" dict="yes" dict_num="0365" readonly="true" alt="学历|0" />
                 <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:personEducation')" class="button_select"></c:verbatim>
        </h:panelGroup>

        <h:outputText value="学位" />
        <h:panelGroup>
                <h:inputText styleClass="input" value="#{cont_contPersonBB.bo.personDegree}" id="personDegree"  code="" dict="yes" dict_num="0380" readonly="true" alt="学位|1" />
                <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:personDegree')" class="button_select"></c:verbatim>
        </h:panelGroup>

        <h:outputText value="专业名称" />
        <h:inputText styleClass="input" id="personSpeciality" value="#{cont_contPersonBB.bo.personSpeciality}" maxlength="20"/>

        <h:outputText  styleClass="td_form_required" value="参加工作时间" />
        <h:panelGroup>
                <h:inputText styleClass="input" id="attendWorkTime" size="10" value="#{cont_contPersonBB.bo.attendWorkTime}" readonly="true"/>
                <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDlg_OnlyMonth('form1:attendWorkTime')"> </c:verbatim>
        </h:panelGroup>

        <h:outputText value="所在部门" />
        <h:panelGroup>
               <h:inputText styleClass="input" id="enterDepartmentId" value="#{cont_contPersonBB.bo.enterDepartmentId}" code="" dict="yes" dict_num="OU" readonly="true"/>
               <c:verbatim> <input type="button"  class="button_select" onclick="PopUpOrgDlg('form1:enterDepartmentId','1', '')"></c:verbatim>
        </h:panelGroup>

        <h:outputText  styleClass="td_form_required" value="所在机构" />
        <h:panelGroup>
                 <h:inputText styleClass="input" id="enterOrgId" value="#{cont_contPersonBB.bo.enterOrgId}" code="" dict="yes" dict_num="OU" readonly="true" alt="所在机构|0"/>
                 <c:verbatim> <input type="button"  class="button_select" onclick="PopUpOrgDlg('form1:enterOrgId','1', '')"></c:verbatim>
        </h:panelGroup>

        <h:outputText  styleClass="td_form_required" value="来公司时间" />
        <h:panelGroup>
               <h:inputText styleClass="input" id="createDate" size="10" value="#{cont_contPersonBB.bo.createDate}" readonly="true" alt="来公司时间|0"/>
               <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDlg_OnlyMonth('form1:createDate')"></c:verbatim>
        </h:panelGroup>

        <h:outputText  styleClass="td_form_required" value="创建机构" />
        <h:inputText styleClass="input" value="#{cont_contPersonBB.bo.createOrgId}" id="createOrgId"  code="" dict="yes" dict_num="OU" readonly="true" alt="创建机构|0"/>

    </h:panelGrid>

    <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="2">
        <h:commandButton styleClass="button01" value="保存" action="#{cont_contPersonBB.save}"  onclick="if( checkSubmit(document.forms(0))&&checkAll(document.forms(0)) ){ return confirmSave(document.forms(0));}else{return false;}"/>
        <h:commandButton styleClass="button01" value="取消返回" action="#{cont_contPersonBB.forwardList}"/>
    </h:panelGrid>

</h:form>
<c:verbatim>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
</c:verbatim>
</body>
</html>