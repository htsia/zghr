<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.ucc.IPersonUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="javax.faces.context.FacesContext" %>
<%@ page import="com.hr319wg.common.ucc.impl.AttachmentUCC" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">

function forCheck() {
   	var idCard = document.all("form1:A001077").value;
    var birth = document.all("form1:A001011").value;
    var email=document.all("form1:a080725").value;
	var name=document.all("form1:A001001").value;
	
	if(idCard==""||name==""){
		alert("��ɫ�ֶ����ݱ�����д!");
		return false;
	}
    if(!( /^[^@]+@[^@]+\.[^@]+$/.test(email))){
        alert("�ʼ���ʽ����ȷ�밴(***@***)��ʽ����!");
        return false;
    }
    if (idCard.trim() != "") {
        if (!(idCard.trim().length == 15 || idCard.trim().length == 18)) {
            alert("���֤��ӦΪ15λ����18λ!");
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
            alert("���֤�źͳ������ڲ�ƥ��!");
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
<h:commandButton id="refresh" value="ˢ��" style="display:none;"  action="#{ResumeManageRecuitBB.query}"></h:commandButton>
<f:verbatim>
<br>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr nowrap>
    <td class="td_form01 td_form_required" width="120">����</td>
    <td class="td_form02">
</f:verbatim>
        <h:inputText styleClass="input" id="A001001" value="#{ResumeManageRecuitBB.personBo.a001001}" alt="����|0|s|50||"/>
<f:verbatim>
    </td>
    <td class=td_form01 rowspan=2 width="120">Ա����Ƭ</td>
    <td class=td_form02 rowspan=2 >
        <iframe name=uploadPhoto frameBorder=0 width=280 height=98% scrolling=no
                src='/common/UploadPhoto.jsf?imageItemId=A001780'></iframe>
        <div id=seryFilterDiv style="cursor:move;position:absolute;z-index:0;left:800px;top:55px;" onMouseDown="catchFilter()" onMouseUp="releaseFilter()">
            <img id=showZP src="../" width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> alt="��Ƭ">
        </div>
    </td>
</tr>
<tr nowrap>
    <td width="15%" class="td_form01 ">�Ա�</td>
    <td class=td_form02 width="30%">
</f:verbatim>
        <h:inputText styleClass="input" id="A001007" code="" dict="yes" dict_num="0100"
                     readonly="true" value="#{ResumeManageRecuitBB.personBo.a001007}"
                     alt="�Ա�|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001007')">
    </td>

</tr>

<tr nowrap>
    <td class="td_form01 ">��������</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001011" value="#{ResumeManageRecuitBB.personBo.a001011}"
                     readonly="true" alt="��������|1|d|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:A001011')">
    </td>
	 <td class=td_form01>����</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001021" code="" dict="yes" dict_num="0115"
                     readonly="true" value="#{ResumeManageRecuitBB.personBo.a001021}"
                     alt="����|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001021')">
    </td>
</tr>
<tr nowrap>
   <td class="td_form01">������ò</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a001009" code="" dict="yes" dict_num="0120"
                     readonly="true" value="#{ResumeManageRecuitBB.personBo.a001009}"
                     alt="������ò|1|s|50||"/>
<f:verbatim>
	 <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001009')">
    </td>
   	<td class="td_form01">�������ڵ�</td>
    <td class=td_form02>
	</f:verbatim>
        <h:inputText styleClass="input" id="a001071" code="" dict="yes" dict_num="0105"
                     readonly="true" value="#{ResumeManageRecuitBB.personBo.a001071}"
                     alt="����|1|s|50||"/>
	<f:verbatim>
	  <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:a001071')"></td>
    
</tr>
  <tr nowrap>
   <td class="td_form01">����״��</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001027" code="" dict="yes" dict_num="0130"
                     value="#{ResumeManageRecuitBB.personBo.a001027}" readonly="true"
                     alt="����״��|1|s|50||"/>
<f:verbatim>
	  <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001027')">
    </td>
    <td class="td_form01">����</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a001785"
                     value="#{ResumeManageRecuitBB.personBo.a001785}"
                     alt="����|1|s|50||"/>
<f:verbatim>
    </td>  
</tr>
 <tr nowrap>
   <td class="td_form01">�μӹ���ʱ��</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001041" value="#{ResumeManageRecuitBB.personBo.a001041}"
                     readonly="true" alt="�μӹ���ʱ��|1|d6|50||"/>
<f:verbatim>
	<script type="text/javascript">
        document.all('form1:A001041').alt = "<%=workTime.getItemName()%>|1|<%=InfoItemBO.getHtmlDataType(workTime.getItemDataType())%>|50||";
    </script>
   <input type="button" class="button_select" onclick="selWorkTime();"></td>
    <td class="td_form01 td_form_required">���֤��</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001077"  size="22"
                     value="#{ResumeManageRecuitBB.personBo.a001077}"
                     alt="���֤��|1|s|50||"/>
<f:verbatim>
    </td>
</tr>

<tr>
 <td class=td_form01 width="15%">�־�ס����</td>
    <td class=td_form02 width="30%">
</f:verbatim>
        <h:inputText styleClass="input" id="a080722" code="" dict="yes" dict_num="0105"
                     readonly="true" value="#{ResumeManageRecuitBB.addressBo.a080722}"
                     alt="������|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:a080722')"></td>
    <td class=td_form01 width="15%">��ͥסַ</td>
    <td class=td_form02 width="30%">
</f:verbatim>
        <h:inputText styleClass="input" id="a080721"  size="22"
                   value="#{ResumeManageRecuitBB.addressBo.a080721}"
                     alt="������|1|s|50||"/>
<f:verbatim>
       </td>
 </tr>

<tr>
    <td class=td_form01>��ͥ�绰</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a080720" value="#{ResumeManageRecuitBB.addressBo.a080720}"/>
<f:verbatim>
    </td>
     <td class=td_form01>�ƶ��绰</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="a080710" value="#{ResumeManageRecuitBB.addressBo.a080710}"/>
<f:verbatim>
    </td>
    
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
<br>
<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
    <tr>
        <td align="right">
        <b><font color="red" size="3">**��Ƭ���������Զ���ʾ,��ɫ�ֶ����ݱ�����д** </font></b>
</f:verbatim>
		<h:commandButton value="����" action="#{ResumeManageRecuitBB.saveResume}" styleClass="button01" onclick="javascript:return forSave()"></h:commandButton>
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
AttachmentUCC aucc;
String tephto=(String)session.getAttribute("photo");
if(tephto!=null && !tephto.equals("")){
	zpValue=tephto;
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
