<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.ucc.IPersonUCC" %>
<%@ page import="com.hr319wg.common.ucc.impl.AttachmentUCC" %>
<%@ page import="javax.faces.context.FacesContext" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.recruit.pojo.bo.recuPersonBO" %>
<%@ page import="com.hr319wg.recruit.pojo.bo.recuPersonAddressBO" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function saveDead(){
	if (confirm('�Ƿ���������')){
		window.close();
        return true;
       
    }else{
        return false;
    }
}
function saveHoubei(){
	if (confirm('�Ƿ������˲ſ�')){
		window.close();
        return true;
       
    }else{
        return false;
    }
}
function viewAtt(id,type){
	 window.open('/pages/recruit/showAttFile.jsp?attachmentId='+id+'&type='+type, "", 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+0.9*screen.width+',height='+0.9*screen.height+',left='+0.05*screen.width+', top='+0.05*screen.height);
}

</script>
<x:saveState value="#{recu_resumeInfoBB}"></x:saveState>
<h:form id="form1">
 	  <h:inputHidden  value="#{recu_resumeInfoBB.initResumeDetail}" />
 	  <h:inputHidden id="personId" value="#{recu_resumeInfoBB.personbo.id}"></h:inputHidden>
<f:verbatim>
<%
recuPersonBO personbo=(recuPersonBO)session.getAttribute("personbo");
recuPersonAddressBO addressbo=(recuPersonAddressBO)session.getAttribute("addressbo");
String degree=(String)session.getAttribute("degree");
String major=(String)session.getAttribute("major");

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
	        String id=aucc.getFileContentToFile(basepath, zpValue);
	    }
	}
	catch (Exception e) {

	}
}
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title"><img src="/images/tips.gif">�ⲿ��Ƹ->�������
        </td>
        
    </tr>
</table>
<br>
<input type="hidden" id="a080710" value="<%=addressbo.getA080710() %>">
<input type="hidden" id="a080725" value="<%=addressbo.getA080725() %>">
<table id="dtable" width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
<tr nowrap>
    <td class="td_form01" height="35">����</td>
    <td class="td_form02">
		<%=personbo.getA001001() %>
    </td>
    <td width="15%" class="td_form01" >�Ա�</td>
    <td class=td_form02>
		<%=personbo.getA001007() %>
    </td>
    <td class=td_form02  rowspan="5">
		<%
			out.println("<img alt='��Ƭ' id='photo' src='/file/tmp/"+tephto+".JPG' width='93' height='140'/>");
		%>
    </td>
</tr>

<tr nowrap>
    <td class="td_form01" height="35">��������</td>
    <td class=td_form02>
		<%=personbo.getA001011() %>       
    </td>
    <td class="td_form01" >���֤��</td>
    <td class=td_form02>
		<%=personbo.getA001077() %>
    </td>
</tr>

<tr nowrap>
    <td class="td_form01" height="35">ѧ��</td>
    <td class=td_form02>
		<%=degree%>       
    </td>
    <td class="td_form01" >רҵ</td>
    <td class=td_form02>
		<%=major%>
    </td>
</tr>

<tr>
    <td class=td_form01 height="35">�־�ס����</td>
    <td class=td_form02>
		<%=addressbo.getA080722() %>        
    </td>
    <td class=td_form01>�ƶ��绰</td>
    <td class=td_form02 >
		<%=addressbo.getA080710() %>
    </td>
</tr>
<tr>
    <td class=td_form01 height="35">��ͥ�绰</td>
    <td class=td_form02>
		<%=addressbo.getA080720() %>
    </td>
    <td class="td_form01">Email</td>
    <td class=td_form02>
    	<%=addressbo.getA080725() %>
    </td>
</tr>
<%
	String educationStr=(String)session.getAttribute("educationStr");
	String wokeInofStr=(String)session.getAttribute("wokeInofStr");
	String languageStr=(String)session.getAttribute("languageStr");
	String computerStr=(String)session.getAttribute("computerStr");
	String specialStr=(String)session.getAttribute("specialStr");
	String articleStr=(String)session.getAttribute("articleStr");
	String keyanStr=(String)session.getAttribute("keyanStr");
	String successStr=(String)session.getAttribute("successStr");
	String materStr=(String)session.getAttribute("materStr");
%>
    <tr nowrap>
    <td class=td_form01 width="19%" height="80">�ܽ������</td>
    <td class=td_form02 colspan="4" valign="top">
		<%=educationStr%>
    </td>
</tr>
    <tr nowrap>
    <td class=td_form01 width="19%" height="80">��������</td>
    <td class=td_form02 colspan="4" valign="top">
		<%=wokeInofStr%>
    </td>
</tr>
    <tr nowrap>
    <td class=td_form01 width="19%" height="80">��������</td>
    <td class=td_form02 colspan="4" valign="top">
		<%=languageStr %>
    </td>
</tr>
    <tr nowrap>
    <td class=td_form01 width="19%" height="80">���������</td>
    <td class=td_form02 colspan="4" valign="top">
		<%=computerStr %>
    </td>
</tr>
    <tr nowrap>
    <td class=td_form01 width="19%" height="80">רҵ�����ʸ�</td>
    <td class=td_form02 colspan="4" valign="top">
		<%=specialStr%>
    </td>
</tr>
    <tr nowrap>
    <td class=td_form01 width="19%" height="80">�����������</td>
    <td class=td_form02 colspan="4" valign="top">
		<%=articleStr %>
    </td>
</tr>
    <tr nowrap>
    <td class=td_form01 width="19%" height="80">����������</td>
    <td class=td_form02 colspan="4" valign="top">
		<%=keyanStr%>
    </td>
</tr>
<tr>
    <td class=td_form01 width="19%" height="80">�ɹ������������гɹ���</td>
    <td class=td_form02 colspan="4" valign="top">
		<%=successStr%>
    </td>
</tr>
    <tr nowrap>
    <td class=td_form01 width="19%" height="80">֤�鼰��ز��� </td>
    <td class=td_form02 colspan="4" valign="top">
		<%=materStr %>
    </td>
</tr>
</table>
<br><br>

<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
    <tr>
        <td align="right">
</f:verbatim>
		<h:commandButton value="�ⶨ����"  styleClass="button01"  action="#{recu_resumeInfoBB.niDingIv}" rendered="#{recu_resumeInfoBB.status=='0'&&recu_resumeInfoBB.firstAuditStatus=='0'}"></h:commandButton>
		<h:outputText value="  "></h:outputText>
		<h:commandButton value="���˲ſ�" styleClass="button01" action="#{recu_resumeInfoBB.saveHoubei}" onclick="saveHoubei()" rendered="#{recu_resumeInfoBB.status=='0'}">
       	</h:commandButton>
       	<h:outputText value="  "></h:outputText>
       	<h:commandButton value="������" styleClass="button01" action="#{recu_resumeInfoBB.saveDead}" onclick="saveDead()" rendered="#{recu_resumeInfoBB.status=='0'}">
       	</h:commandButton>
<f:verbatim>
        </td>
    </tr>
</table>
</f:verbatim>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
 </script>
