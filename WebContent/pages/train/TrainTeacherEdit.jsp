<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.ucc.impl.AttachmentUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="javax.faces.context.FacesContext" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

 
      
      <script type="text/javascript">
    	function chkData(){
             if (document.all('form1:teachername').value==""){
                alert("��������Ϊ��1!");
                return false;
             }
             if (document.all('form1:teacherSexcode').value==""){
                alert("�Ա���Ϊ��!");
                return false;
             }
             if (document.all('form1:teacherdegreecode').value==""){
                alert("ѧ������Ϊ��!");
                return false;
             }
             if (document.all('form1:major').value==""){
                alert("רҵ����Ϊ��!");
                return false;
             }
             if (document.all('form1:teacherCas').value==""){
                 alert("ְ�Ʋ���Ϊ��!");
                 return false;
              }
             return forsubmit(document.forms(0));
         }
       	function forBack(form){
             window.close();
        }
       	function window.onunload(){   
       	 window.opener.location.href=window.opener.location.href;
       	 return true;
        }
      </script>
  
  <x:saveState value="#{train_teachereditbb}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{train_teachereditbb.initEdit}"></h:inputHidden>
      
     <f:verbatim>
    
     <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title"><img src="/images/tips.gif"> ��ѵ���� -> �ⲿ��ʦ�༭
        </td>
    </tr>
</table>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr nowrap>
    <td class="td_form01" width="20%">��ʦ����</td>
    <td class="td_form02" width="35%">
</f:verbatim>
        <h:inputText value="#{train_teachereditbb.teacherbo.teacherName}" id="teachername"></h:inputText>
<f:verbatim>
    </td>
    <td class=td_form01 rowspan=2 width="15%">��ʦ��Ƭ</td>
    <td class=td_form02 rowspan=2 width="30%">
        <iframe name=uploadPhoto frameBorder=0 width=280 height=98% scrolling=no
                src='/common/UploadPhoto.jsf?imageItemId=A001780'></iframe>
        <div id=seryFilterDiv style="cursor:move;position:absolute;z-index:0;left:750px;top:55px;" onMouseDown="catchFilter()" onMouseUp="releaseFilter()">
            <img id=showZP src="" width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> alt="��Ƭ">
        </div>
    </td>
</tr>
<tr nowrap>
    <td class="td_form01 ">�Ա�</td>
    <td class=td_form02 >
</f:verbatim>
        <h:inputText styleClass="input" id="teacherSexcode" code="" dict="yes" dict_num="0100"
                     readonly="true" value="#{train_teachereditbb.teacherbo.teacherSex}"
                     alt="�Ա�|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:teacherSexcode')">
    </td>

</tr>

<tr nowrap>
    <td class="td_form01">��ʦ����</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="birthday" value="#{train_teachereditbb.teacherbo.teacherBirthday}"
                     readonly="true" alt="��������|1|d|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:birthday')">
    </td>

    <td class="td_form01" >��ҵԺУ</td>
    <td class=td_form02>
</f:verbatim>
       <h:inputText value="#{train_teachereditbb.teacherbo.teacherColleage}"></h:inputText>
<f:verbatim>
       </td>
</tr>
<tr>
    <td class=td_form01>ѧ��</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="teacherdegreecode" code="" dict="yes" dict_num="0365"
                     readonly="true"  value="#{train_teachereditbb.teacherbo.teacherDegree}"
                     alt="ѧ��|0|s|50||"/>
        <h:outputText value="  "></h:outputText>
        <h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:teacherdegreecode')"/>
<f:verbatim>
    </td>
    <td class=td_form01>רҵ</td>
    <td class=td_form02>
</f:verbatim>
          <h:inputText value="#{train_teachereditbb.teacherbo.teacherMajor}" id="major"></h:inputText>
<f:verbatim>
    </td>
</tr>
<tr>
    <td class=td_form01>ְ��</td>
    <td class=td_form02>
</f:verbatim>
       <h:inputText styleClass="input" id="teacherCas" code="" dict="yes" dict_num="0330"
                     readonly="true"  value="#{train_teachereditbb.teacherbo.teacherCas}"
                     alt="ְ��|0|s|50||"/>
        <h:outputText value="  "></h:outputText>
        <h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:teacherCas')"/>
<f:verbatim>
    </td>
    <td class=td_form01>������λ</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText value="#{train_teachereditbb.teacherbo.teacherWork}"></h:inputText>
<f:verbatim>
</tr>
<tr>
    <td class=td_form01>��ϵ�绰</td>
    <td class=td_form02>
</f:verbatim>
       <h:inputText value="#{train_teachereditbb.teacherbo.teacherTel}"></h:inputText>
<f:verbatim>
    </td>
    <td class=td_form01>�ֻ�</td>
    <td class=td_form02>
</f:verbatim>
         <h:inputText value="#{train_teachereditbb.teacherbo.teacherMobile}"></h:inputText>
<f:verbatim>
    </td>
</tr>
<tr>
    <td class=td_form01>email</td>
    <td class=td_form02>
</f:verbatim>
          <h:inputText value="#{train_teachereditbb.teacherbo.teacherEmail}"></h:inputText>
<f:verbatim>
    </td>
    <td class=td_form01>��ѵ����</td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText value="#{train_teachereditbb.teacherbo.teacherPric}"></h:inputText>
<f:verbatim>
</tr>
<tr nowrap>
    <td class=td_form01>Ӧ�÷�Χ</td>
    <td class=td_form02>
</f:verbatim>
         <h:selectOneMenu value="#{train_teachereditbb.teacherbo.teacherOrg}">
                      <c:selectItems value="#{train_teachereditbb.orgList}"></c:selectItems>
               </h:selectOneMenu>
<f:verbatim>
       
</tr>
</table>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr nowrap>
    <td class=td_form01 width="18%">����</td>
    <td class=td_form02>
</f:verbatim>
     <h:inputTextarea value="#{train_teachereditbb.teacherbo.teacherGlo}" cols="80" rows="3"></h:inputTextarea>
<f:verbatim>
       
</tr>
<tr nowrap>
    <td class=td_form01 width="18%">�����γ�</td>
    <td class=td_form02>
</f:verbatim>
     <h:inputTextarea value="#{train_teachereditbb.teacherbo.teacherCou}" cols="80" rows="3"></h:inputTextarea>
<f:verbatim>
       
</tr>
<tr nowrap>
    <td class=td_form01 width="18%">����ͻ�</td>
    <td class=td_form02>
</f:verbatim>
     <h:inputTextarea value="#{train_teachereditbb.teacherbo.teacherClie}" cols="80" rows="3"></h:inputTextarea>
<f:verbatim>
       
</tr>
<tr nowrap>
    <td class=td_form01 width="18%">��ע</td>
    <td class=td_form02>
</f:verbatim>
     <h:inputTextarea value="#{train_teachereditbb.teacherbo.teacherMemo}" cols="80" rows="3"></h:inputTextarea>
<f:verbatim>
       
</tr>
<tr height="20"></tr>
<tr>
<td></td>
<td align="right">
</f:verbatim>
 <h:commandButton value="����" id="save" onclick="return chkData();"
              	action="#{train_teachereditbb.save}" styleClass="button01"/>
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
String tephto=(String)session.getAttribute("teacherPhoto");
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

