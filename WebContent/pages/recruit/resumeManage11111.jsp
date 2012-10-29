<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.ucc.IPersonUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="javax.faces.context.FacesContext" %>
<%@ page import="com.hr319wg.common.ucc.impl.AttachmentUCC" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function viewAtt(id,type){
 	 window.open('/pages/recruit/showAttFile.jsp?attachmentId='+id+'&type='+type, "", 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+0.9*screen.width+',height='+0.9*screen.height+',left='+0.05*screen.width+', top='+0.05*screen.height);
}
function addDegree(){
	window.showModalDialog("/recruit/recruitEducationEdit.jsf", null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
    return false;
}
function addLanguage(){
	window.showModalDialog("/recruit/recruitLanguageEdit.jsf", null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
    return false;
}
function addMater(){
	window.showModalDialog("/recruit/personMaterEdit.jsf?personId="+document.all("form1:personcode").value, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
	return false;
}
function modifyMater(id){
	window.showModalDialog("/recruit/personMaterEdit.jsf?materId="+id, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
	return false;
}
function addComputerLevel(){
	window.showModalDialog("/recruit/recuA843Edit.jsf?personId="+document.all("form1:personcode").value, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
	return false;
}
function modifyComputerLevel(id){
	window.showModalDialog("/recruit/recuA843Edit.jsf?subId="+id, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
	return false;
}
function addA836(){
	window.showModalDialog("/recruit/recuA836Edit.jsf?personId="+document.all("form1:personcode").value, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
	return false;
}
function modifyA836(id){
	window.showModalDialog("/recruit/recuA836Edit.jsf?subId="+id, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
	return false;
}
function addA837(){
	window.showModalDialog("/recruit/recuA837Edit.jsf?personId="+document.all("form1:personcode").value, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
	return false;
}
function modifyA837(id){
	window.showModalDialog("/recruit/recuA837Edit.jsf?subId="+id, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
	return false;
}
function addA838(){
	window.showModalDialog("/recruit/recuA838Edit.jsf?personId="+document.all("form1:personcode").value, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
	return false;
}
function modifyA838(id){
	window.showModalDialog("/recruit/recuA838Edit.jsf?subId="+id, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
	return false;
}
function modifyLanguage(id){
	window.showModalDialog("/recruit/recruitLanguageEdit.jsf?subid="+id, null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
    return false;
}
function addLetter(){
	window.showModalDialog("/recruit/recruitLetterEdit.jsf", null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
    return false;
}
function modifyLetter(id){
	window.showModalDialog("/recruit/recruitLetterEdit.jsf?subid="+id, null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
    return false;
}
function modify(id){
	window.showModalDialog("/recruit/recruitEducationEdit.jsf?subid="+id, null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
    return false;
}
function addWorkInfo(){
	window.showModalDialog("/recruit/recruitWorkInfoEdit.jsf", null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
    return false;
}

function modifyWorkInfo(id){
	window.showModalDialog("/recruit/recruitWorkInfoEdit.jsf?subid="+id, null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
    return false;
}
function forCheck() {
   	var idCard = document.all("form1:A001077").value;
    var birth = document.all("form1:A001011").value;
    var email=document.all("form1:a080725").value;
	var name=document.all("form1:A001001").value;
	
	if(idCard==""||name==""){
		alert("蓝色字段内容必须填写!");
		return false;
	}
    if(!( /^[^@]+@[^@]+\.[^@]+$/.test(email))){
        alert("邮件格式不正确请按(***@***)格式输入!");
        return false;
    }
    if (idCard.trim() != "") {
        if (!(idCard.trim().length == 15 || idCard.trim().length == 18)) {
            alert("身份证号应为15位或者18位!");
            return false;
        }
    }

    if (idCard.trim() != "") {
        var tmpCard ;
        if (idCard.length == 15) {
            tmpCard = "19" + idCard.substring(6, 12);
        }
        if (idCard.length == 18) {
            tmpCard = idCard.substring(6, 14);
        }
        var tmpBirth = birth.replace(/\-/g, "");
        if (tmpCard != tmpBirth) {
            alert("身份证号和出生日期不匹配!");
            return false;
        }
    }
    return true;
	}
function selWorkTime() {
    <%
       InfoItemBO workTime=SysCacheTool.findInfoItem("A001","A001041");
       if (InfoItemBO.DATA_TYPE_DATE6.equals(workTime.getItemDataType())){
    %>
        PopUpCalendarDlg_OnlyMonth("form1:A001041");
    <%
       }
       else{
     %>
         PopUpCalendarDialog("form1:A001041");
    <%
     }
    %>
}
	function forSave() {
	    if (forCheck()) {
	        return forsubmit(document.forms(0));
	    }
    return false;
}
</script>
<x:saveState value="#{ResumeManageRecuitBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden id="initEdit" value="#{ResumeManageRecuitBB.initEdit}"></h:inputHidden>
<h:inputHidden id="personcode" value="#{ResumeManageRecuitBB.personcode}"></h:inputHidden>
<h:commandButton id="refresh" value="刷新" style="display:none;"  action="#{ResumeManageRecuitBB.query}"></h:commandButton>
<f:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title"><img src="/images/tips.gif"> 外部招聘 ->简历编辑
        </td>
        <td class="td_title" align="right">
        </td>
    </tr>
</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%>基本信息</td>
        <td>
		</td>
     </tr>
</table>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr nowrap>
    <td class="td_form01 td_form_required" width="120">姓名</td>
    <td class="td_form02">
</f:verbatim>
        <h:inputText styleClass="input" id="A001001" value="#{ResumeManageRecuitBB.personBo.a001001}" alt="姓名|0|s|50||"/>
<f:verbatim>
    </td>
    <td class=td_form01 rowspan=2 width="120">员工照片</td>
    <td class=td_form02 rowspan=2 >
        <iframe name=uploadPhoto frameBorder=0 width=280 height=98% scrolling=no
                src='/common/UploadPhoto.jsf?imageItemId=A001780'></iframe>
        <div id=seryFilterDiv style="cursor:move;position:absolute;z-index:0;left:800px;top:55px;" onMouseDown="catchFilter()" onMouseUp="releaseFilter()">
            <img id=showZP src="" width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> alt="照片">
        </div>
    </td>
</tr>
<tr nowrap>
    <td width="15%" class="td_form01 ">性别</td>
    <td class=td_form02 width="30%">
</f:verbatim>
        <h:inputText styleClass="input" id="A001007" code="" dict="yes" dict_num="0100"
                     readonly="true" value="#{ResumeManageRecuitBB.personBo.a001007}"
                     alt="性别|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001007')">
    </td>

</tr>

<tr nowrap>
    <td class="td_form01 ">出生日期</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001011" value="#{ResumeManageRecuitBB.personBo.a001011}"
                     readonly="true" alt="出生日期|1|d|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:A001011')">
    </td>
	 <td class=td_form01>民族</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001021" code="" dict="yes" dict_num="0115"
                     readonly="true" value="#{ResumeManageRecuitBB.personBo.a001021}"
                     alt="民族|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001021')">
    </td>
</tr>
<tr nowrap>
   <td class="td_form01">政治面貌</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a001009" code="" dict="yes" dict_num="0120"
                     readonly="true" value="#{ResumeManageRecuitBB.personBo.a001009}"
                     alt="政治面貌|1|s|50||"/>
<f:verbatim>
	 <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001009')">
    </td>
   	<td class="td_form01">户口所在地</td>
    <td class=td_form02>
	</f:verbatim>
        <h:inputText styleClass="input" id="a001071" code="" dict="yes" dict_num="0105"
                     readonly="true" value="#{ResumeManageRecuitBB.personBo.a001071}"
                     alt="籍贯|1|s|50||"/>
	<f:verbatim>
	  <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:a001071')"></td>
    
</tr>
  <tr nowrap>
   <td class="td_form01">婚姻状况</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001027" code="" dict="yes" dict_num="0130"
                     value="#{ResumeManageRecuitBB.personBo.a001027}" readonly="true"
                     alt="婚姻状况|1|s|50||"/>
<f:verbatim>
	  <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001027')">
    </td>
    <td class="td_form01">国籍</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a001785"
                     value="#{ResumeManageRecuitBB.personBo.a001785}"
                     alt="国籍|1|s|50||"/>
<f:verbatim>
    </td>  
</tr>
 <tr nowrap>
   <td class="td_form01">参加工作时间</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001041" value="#{ResumeManageRecuitBB.personBo.a001041}"
                     readonly="true" alt="参加工作时间|1|d6|50||"/>
<f:verbatim>
	<script type="text/javascript">
        document.all('form1:A001041').alt = "<%=workTime.getItemName()%>|1|<%=InfoItemBO.getHtmlDataType(workTime.getItemDataType())%>|50||";
    </script>
   <input type="button" class="button_select" onclick="selWorkTime();"></td>
    <td class="td_form01 td_form_required">身份证号</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001077"  size="22"
                     value="#{ResumeManageRecuitBB.personBo.a001077}"
                     alt="身份证号|1|s|50||"/>
<f:verbatim>
    </td>
</tr>
<tr nowrap>
   <td class="td_form01">其他有效证件名称</td>
    <td class=td_form02>
</f:verbatim>
       
        <h:inputText styleClass="input" id="a001710" code="" dict="yes" dict_num="0107"
                     readonly="true" value="#{ResumeManageRecuitBB.personBo.a001710}"
                     alt="其他证件类型|1|s|50||"/>
<f:verbatim>
	 <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:a001710')"></td>
	 </td>
    <td class="td_form01">其他有效证件号码</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a001711" size="22"
                     value="#{ResumeManageRecuitBB.personBo.a001711}" />
<f:verbatim>
    </td>  
</tr>
<tr nowrap>
	<td class=td_form01>专长</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001783" value="#{ResumeManageRecuitBB.personBo.a001783}"
                     alt="专长|1|s|50||"/></td>
<f:verbatim>
	<td class=td_form01 ></td>
    <td class=td_form02 ></td>
</tr>
</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%>联系方式</td>
        <td>
		</td>
     </tr>
</table>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr>
 <td class=td_form01 width="15%">现居住地区</td>
    <td class=td_form02 width="30%">
</f:verbatim>
        <h:inputText styleClass="input" id="a080722" code="" dict="yes" dict_num="0105"
                     readonly="true" value="#{ResumeManageRecuitBB.addressBo.a080722}"
                     alt="出生地|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:a080722')"></td>
    <td class=td_form01 width="15%">家庭住址</td>
    <td class=td_form02 width="30%">
</f:verbatim>
        <h:inputText styleClass="input" id="a080721"  size="22"
                   value="#{ResumeManageRecuitBB.addressBo.a080721}"
                     alt="出生地|1|s|50||"/>
<f:verbatim>
       </td>
 </tr>

<tr>
    <td class=td_form01>家庭电话</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a080720" value="#{ResumeManageRecuitBB.addressBo.a080720}"/>
<f:verbatim>
    </td>
     <td class=td_form01>移动电话</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a080710" value="#{ResumeManageRecuitBB.addressBo.a080710}"/>
<f:verbatim>
    </td>
    
</tr>
<tr>
    <td class=td_form01 width="15%">QQ</td>
    <td class=td_form02 width="30%">
</f:verbatim>
        <h:inputText styleClass="input" id="a080726" 
                      value="#{ResumeManageRecuitBB.addressBo.a080726}"
                     alt="出生地|1|s|50||"/>
<f:verbatim>
      </td>
    
    <td class=td_form01>MSN</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a080728" value="#{ResumeManageRecuitBB.addressBo.a080728}"/>
<f:verbatim>
    </td>
</tr>
<tr>
    <td class=td_form01 width="15%">个人主页/博客</td>
    <td class=td_form02 width="30%">
</f:verbatim>
        <h:inputText styleClass="input" id="a080727" 
                     value="#{ResumeManageRecuitBB.addressBo.a080727}"
                     alt="出生地|1|s|50||"/>
<f:verbatim>
       </td>
    
   <td class=td_form01>邮政编码</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a080735" value="#{ResumeManageRecuitBB.addressBo.a080735}"/></td>
<f:verbatim>
</tr>
<tr>
	<td class="td_form01 td_form_required">Email</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a080725" 
                      value="#{ResumeManageRecuitBB.addressBo.a080725}"/>
<f:verbatim>
    </td>
    <td class=td_form01 ></td>
    <td class=td_form02 ></td>
</tr>
</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%>求职需求</td>
        <td>
		</td>
     </tr>
</table>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr>
 <td class=td_form01 width="15%">期望工作性质</td>
    <td class=td_form02 width="30%">
</f:verbatim>
        <h:inputText styleClass="input" id="desireType" code="" dict="yes" dict_num="2212"
                     readonly="true" value="#{ResumeManageRecuitBB.desirebo.desireType}"
                     alt="出生地|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:desireType')"></td>
    <td class=td_form01 width="15%">期望工作地点</td>
    <td class=td_form02 width="30%">
</f:verbatim>
       
       <h:inputText styleClass="input" id="desireCity" code="" dict="yes" dict_num="0105"
                     readonly="true" value="#{ResumeManageRecuitBB.desirebo.desireCity}"
                     alt="籍贯|1|s|50||"/>
<f:verbatim>
	 <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:desireCity')">
       </td>
 </tr>
<tr>
	<td class="td_form01">工资</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="desireWage" 
                      value="#{ResumeManageRecuitBB.desirebo.desireWage}"/>
<f:verbatim>
    </td>
    <td class=td_form01 ></td>
    <td class=td_form02 ></td>
</tr>
</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%>受教育情况</td>
         <td >
		</td>
		<td align="right"><input type="button" value="添加" class="button01" onclick="addDegree()"/></td>
     </tr>
     <tr>
     	<td colspan="3">
     	</f:verbatim>
  <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="linkList"  align="center" border="0"  value="#{ResumeManageRecuitBB.educationList}"    var="list">
        
        <h:column>
            <c:facet name="header"><h:outputText value="学历" /></c:facet>
            <h:outputText value="#{list.a004005}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="专业" /></c:facet>
            <h:outputText value="#{list.a004010}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="毕业院校" /></c:facet>
            <h:outputText value="#{list.a004035}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="入学时间"/></c:facet>
            <h:outputText value="#{list.a004015}" />
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="毕业时间" /></c:facet>
            <h:outputText value="#{list.a004030}" />
        </h:column>
		<h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modify('#{list.subid}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{ResumeManageRecuitBB.delete}" styleClass="button01">
                  <x:updateActionListener property="#{ResumeManageRecuitBB.subid}" value="#{list.subid}"/>
            </h:commandButton>
        </h:column>
    </x:dataTable>
<f:verbatim>
     	
     	</td>
     </tr>
</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%>工作经历</td>
         <td>
		</td>
		<td align="right"><input type="button" value="添加" class="button01" onclick="addWorkInfo()"/></td>
     </tr>
     <tr>
     	<td colspan="3">
     	</f:verbatim>
  <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="linkList2"  align="center" border="0"  value="#{ResumeManageRecuitBB.workInfoList}"    var="list">
        
        <h:column>
            <c:facet name="header"><h:outputText value="单位名称" /></c:facet>
            <h:outputText value="#{list.a019015}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="从事工作" /></c:facet>
            <h:outputText value="#{list.a019020}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="进入时间"/></c:facet>
            <h:outputText value="#{list.a019005}" />
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="离开时间" /></c:facet>
            <h:outputText value="#{list.a019010}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="证明人" /></c:facet>
            <h:outputText value="#{list.a019025}" />
        </h:column>
		<h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modifyWorkInfo('#{list.subId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{ResumeManageRecuitBB.delete2}" styleClass="button01">
                  <x:updateActionListener property="#{ResumeManageRecuitBB.workSubid}" value="#{list.subId}"/>
            </h:commandButton>
        </h:column>
    </x:dataTable>
<f:verbatim>
     	
     	</td>
     </tr>
</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%>语言能力</td>
         <td >
		</td>
		<td align="right"><input type="button" value="添加" class="button01" onclick="addLanguage()"/></td>
     </tr>
     <tr>
     	<td colspan="3">
     	</f:verbatim>
  <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="linkList3"  align="center" border="0"  value="#{ResumeManageRecuitBB.languageList}"    var="list">
        
        <h:column>
            <c:facet name="header"><h:outputText value="语种" /></c:facet>
            <h:outputText value="#{list.a842701}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="听说熟练程度" /></c:facet>
            <h:outputText value="#{list.a842702}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="读写熟练程度"/></c:facet>
            <h:outputText value="#{list.a842708}" />
        </h:column>

       <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modifyLanguage('#{list.subId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{ResumeManageRecuitBB.delete3}" styleClass="button01">
                  <x:updateActionListener property="#{ResumeManageRecuitBB.subid}" value="#{list.subId}"/>
            </h:commandButton>
        </h:column>
    </x:dataTable>
<f:verbatim>
     	
     	</td>
     </tr>
</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%>计算机能力</td>
         <td >
		</td>
		<td align="right"><input type="button" value="添加" class="button01" onclick="addComputerLevel()"/></td>
     </tr>
     <tr>
     	<td colspan="3">
     	</f:verbatim>
  <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="a843List"  align="center" border="0"  value="#{ResumeManageRecuitBB.a843List}"    var="list">
        
        <h:column>
            <c:facet name="header"><h:outputText value="科目" /></c:facet>
            <h:outputText value="#{list.a843703}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="级别" /></c:facet>
            <h:outputText value="#{list.a843704}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="发证时间"/></c:facet>
            <h:outputText value="#{list.a843701}" />
        </h:column>
		<h:column>
            <c:facet name="header"><h:outputText value="发证机关"/></c:facet>
            <h:outputText value="#{list.a843702}" />
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modifyComputerLevel('#{list.subId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{ResumeManageRecuitBB.deleteComLevel}" styleClass="button01">
                  <x:updateActionListener property="#{ResumeManageRecuitBB.subid}" value="#{list.subId}"/>
            </h:commandButton>
        </h:column>
    </x:dataTable>
<f:verbatim>
     	
     	</td>
     </tr>
</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%>专业技术资格</td>
         <td >
		</td>
		<td align="right"><input type="button" value="添加" class="button01" onclick="addLetter()"/></td>
     </tr>
     <tr>
     	<td colspan="3">
     	</f:verbatim>
  <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="linkList4"  align="center" border="0"  value="#{ResumeManageRecuitBB.letterList}"    var="list">
        
        <h:column>
            <c:facet name="header"><h:outputText value="专业技术资格" /></c:facet>
            <h:outputText value="#{list.a010005}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="专业" /></c:facet>
            <h:outputText value="#{list.a010706}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="专业技术级别" /></c:facet>
            <h:outputText value="#{list.a010006}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="取得时间" /></c:facet>
            <h:outputText value="#{list.a010015}"/>
        </h:column>

       <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modifyLetter('#{list.subId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{ResumeManageRecuitBB.delete4}" styleClass="button01">
                  <x:updateActionListener property="#{ResumeManageRecuitBB.subid}" value="#{list.subId}"/>
            </h:commandButton>
        </h:column>
    </x:dataTable>
<f:verbatim>
     	
     	</td>
     </tr>
</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%>科研论文情况</td>
         <td >
		</td>
		<td align="right"><input type="button" value="添加" class="button01" onclick="addA837()"/></td>
     </tr>
     <tr>
     	<td colspan="3">
     	</f:verbatim>
  <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="a837List"  align="center" border="0"  value="#{ResumeManageRecuitBB.a837List}"    var="list">
        
        <h:column>
            <c:facet name="header"><h:outputText value="题目" /></c:facet>
            <h:outputText value="#{list.a837701}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="刊物或出版社" /></c:facet>
            <h:outputText value="#{list.a837702}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="位次"/></c:facet>
            <h:outputText value="#{list.a837704}" />
        </h:column>
		 <h:column>
            <c:facet name="header"><h:outputText value="发表时间"/></c:facet>
            <h:outputText value="#{list.a837700}" />
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modifyA837('#{list.subId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{ResumeManageRecuitBB.deleteA837}" styleClass="button01">
                  <x:updateActionListener property="#{ResumeManageRecuitBB.subid}" value="#{list.subId}"/>
            </h:commandButton>
        </h:column>
    </x:dataTable>
<f:verbatim>
     	
     	</td>
     </tr>
</table>

<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%></f:verbatim><h:outputText value="参与课题情况 " rendered="#{ResumeManageRecuitBB.showA838!='0'}"></h:outputText><f:verbatim></td>
         <td >
		</td>
		<td align="right"></f:verbatim><h:commandButton type="button" styleClass="button01" value="添加" onclick="addA838()" rendered="#{ResumeManageRecuitBB.showA838!='0'}"></h:commandButton><f:verbatim></td>
     </tr>
     <tr>
     	<td colspan="3">

     	</f:verbatim>
  <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="a838List"  align="center" border="0"  value="#{ResumeManageRecuitBB.a838List}"    var="list" rendered="#{ResumeManageRecuitBB.showA838!='0'}">
        
        <h:column>
            <c:facet name="header"><h:outputText value="题目" /></c:facet>
            <h:outputText value="#{list.a838702}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="级别" /></c:facet>
            <h:outputText value="#{list.a838703}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="位次"/></c:facet>
            <h:outputText value="#{list.a838704}" />
        </h:column>
		<h:column>
            <c:facet name="header"><h:outputText value="时间"/></c:facet>
            <h:outputText value="#{list.a838701}" />
        </h:column>
		
       <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modifyA838('#{list.subId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{ResumeManageRecuitBB.deleteA838}" styleClass="button01">
                  <x:updateActionListener property="#{ResumeManageRecuitBB.subid}" value="#{list.subId}"/>
            </h:commandButton>
        </h:column>
    </x:dataTable>
<f:verbatim>
     	</td>
     </tr>
</table>

<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%>成果奖励（含科研成果）</td>
         <td >
		</td>
		<td align="right"><input type="button" value="添加" class="button01" onclick="addA836()"/></td>
     </tr>
     <tr>
     	<td colspan="3">
     	</f:verbatim>
  <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="a836List"  align="center" border="0"  value="#{ResumeManageRecuitBB.a836List}"    var="list">
        
        <h:column>
            <c:facet name="header"><h:outputText value="项目" /></c:facet>
            <h:outputText value="#{list.a836701}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="批准机关" /></c:facet>
            <h:outputText value="#{list.a836702}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="等级"/></c:facet>
            <h:outputText value="#{list.a836703}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="位次"/></c:facet>
            <h:outputText value="#{list.a836704}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="奖励时间"/></c:facet>
            <h:outputText value="#{list.a836700}" />
        </h:column>

       <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modifyA836('#{list.subId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{ResumeManageRecuitBB.deleteA836}" styleClass="button01">
                  <x:updateActionListener property="#{ResumeManageRecuitBB.subid}" value="#{list.subId}"/>
            </h:commandButton>
        </h:column>
    </x:dataTable>
<f:verbatim>
     	
     	</td>
     </tr>
</table>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%>证书及相关材料</td>
         <td >
		</td>
		<td align="right"><input type="button" value="添加" class="button01" onclick="addMater()"/></td>
     </tr>
     <tr>
     	<td colspan="3">
     	</f:verbatim>
  <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle" id="linkList5"  align="center" border="0"  value="#{ResumeManageRecuitBB.materList}"    var="list">
        
        <h:column>
            <c:facet name="header"><h:outputText value="标题" /></c:facet>
            <h:outputText value="#{list.title}"></h:outputText>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="附件" /></c:facet>
            <h:commandLink value="查看"   onclick="viewAtt('#{list.attId}','#{list.type}')" rendered="#{list.isHaveFile=='1'}">
            </h:commandLink>
            <h:outputText value="无附件" rendered="#{list.isHaveFile=='0'}"></h:outputText>
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modifyMater('#{list.materId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{ResumeManageRecuitBB.deleteMater}" styleClass="button01">
                  <x:updateActionListener property="#{ResumeManageRecuitBB.materId}" value="#{list.materId}"/>
            </h:commandButton>
        </h:column>
    </x:dataTable>
<f:verbatim>
     	
     	</td>
     </tr>
</table>
<br>
<br>
<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
    <tr>
        <td align="right">
        <font color="red">**蓝色字段内容必须填写** </font>
</f:verbatim>
		<h:commandButton value="保存" action="#{ResumeManageRecuitBB.saveResume}" styleClass="button01" onclick="javascript:return forSave()"></h:commandButton>
<f:verbatim>
        </td>
    </tr>
</table>
</f:verbatim>
</h:form>

<script type="text/javascript">
    interpret(document.forms(0));
</script>
<script language=javascript>
<%
String zpValue = "";
String sfzValue = "";
String tephto=(String)session.getAttribute("photo");
if(tephto!=null && !tephto.equals("")){
	zpValue=tephto;
}else{
	zpValue="";
}

AttachmentUCC aucc;
try {
	ServletContext context = (ServletContext) FacesContext.getCurrentInstance().getExternalContext().getContext();
	String basepath  = context.getRealPath("/");
    aucc = (AttachmentUCC) SysContext.getBean("common_attachmentUCC");
    if (!aucc.checkAttachFileExist(basepath, zpValue)) {
        aucc.getFileContentToFile(basepath, zpValue);
    }
}
catch (Exception e) {

}

%>
    <%
        if (zpValue!=null && !"".equals(zpValue)){
           out.println("document.all('showZP').src='';");
           out.println("document.all('showZP').src='/file/tmp/"+zpValue+".JPG';");
        }
        if (sfzValue!=null && !"".equals(sfzValue)){
           out.println("document.all('showSFZ').src='';");
           out.println("document.all('showSFZ').src='/file/tmp/"+sfzValue+".JPG';");
        }

    %>
    document.all.seryFilterDiv.style.left = document.body.scrollWidth - 120;
    
    var bIsCatchSery = false;
    var dragClickX = 0;
    var dragClickY = 0;

    var bIsCatchSery2 = false;
    var dragClickX2 = 0;
    var dragClickY2 = 0;

    function myload_setFilter() {
        seryFilterDiv.style.top = document.body.scrollTop + 100;
        seryFilterDiv.style.left = document.body.scrollLeft + 100;
    }
    function catchFilter(e) {
        bIsCatchSery = true;
        var x = event.x + document.body.scrollLeft;
        var y = event.y + document.body.scrollTop;
        dragClickX = x - seryFilterDiv.style.pixelLeft;
        dragClickY = y - seryFilterDiv.style.pixelTop;
        seryFilterDiv.setCapture();
        document.onmousemove = moveFilter;
    }
   

    function releaseFilter(e) {
        bIsCatchSery = false;
        seryFilterDiv.releaseCapture();
        document.onmousemove = null;
    }
   

    function moveFilter(e) {
        if (bIsCatchSery) {
            seryFilterDiv.style.left = event.x + document.body.scrollLeft - dragClickX;
            seryFilterDiv.style.top = event.y + document.body.scrollTop - dragClickY;
        }
    }
  
</script>
