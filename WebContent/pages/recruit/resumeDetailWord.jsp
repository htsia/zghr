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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">  
<html>  
 <head>  
   <%   
    out.clearBuffer();   
    response.setHeader("Content-Type","application/vnd.ms-word;charset=GBK");   
  	response.setHeader("Content-Disposition","attachment;filename=resume.html");   
  %>  
   <meta http-equiv="Content-Type" content="text/html; charset=GBK">  
    <meta http-equiv="pragma" content="no-cache">  
    <meta http-equiv="cache-control" content="no-cache">  
 </head>  
 <body> 
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
<table width=95%>
	<tr><td align="center" width="100%"><b>�ӱ�����ѧԺ�˲���Ƹ�ǼǱ�</b></td></tr>
	<tr><td align="center" width="100%">
	<table  width=100% align=center border="1" cellpadding="0" cellspacing="0">
<tr>
    <td width="15%"><b>����</b></td>
    <td>
		<%=personbo.getA001001() %>
    </td>
    <td width="15%"><b>�Ա�</b></td>
    <td>
		<%=personbo.getA001007() %>
    </td>
    <td rowspan="5">
		<%
		out.println("<img alt='��Ƭ' id='photo' src='/file/tmp/"+tephto+".JPG' width='93' height='140'/>");
		%>
    </td>
</tr>

<tr>
    <td><b>��������</b></td>
    <td>
		<%=personbo.getA001011() %>       
    </td>
     <td><b>���֤��</b></td>
    <td>
		<%=personbo.getA001077() %>
    </td>
</tr>
<tr nowrap>
    <td><b>ѧ��</b></td>
    <td>
		<%=degree%>       
    </td>
    <td><b>רҵ</b></td>
    <td>
		<%=major%>
    </td>
</tr>
<tr>
    <td ><b>�־�ס����</b></td>
    <td >
		<%=addressbo.getA080722() %>        
    </td>
    <td ><b>�ƶ��绰</b></td>
    <td >
		<%=addressbo.getA080710() %>
    </td>
</tr>
<tr>
    <td><b>��ͥ�绰</b></td>
    <td>
		<%=addressbo.getA080720() %>
    </td>
    <td><b>Email</b></td>
    <td>
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
    <tr>
    <td width="19%" height="80"><b>�ܽ������</b></td>
    <td  colspan="4" valign="top">
		<%=educationStr%>
    </td>
</tr>
<tr>
    <td  width="19%" height="80"><b>��������</b></td>
    <td  colspan="4" valign="top">
		<%=wokeInofStr%>
    </td>
</tr>
<tr>
    <td  width="19%" height="80"><b>��������</b></td>
    <td  colspan="4" valign="top">
		<%=languageStr %>
    </td>
</tr>
    <tr>
    <td  width="19%" height="80"><b>���������</b></td>
    <td  colspan="4" valign="top">
		<%=computerStr %>
    </td>
</tr>
    <tr>
    <td  width="19%" height="80"><b>רҵ�����ʸ�</b></td>
    <td  colspan="4" valign="top">
		<%=specialStr%>
    </td>
</tr>
<tr>
    <td  width="19%" height="80"><b>�����������</b></td>
    <td  colspan="4" valign="top">
		<%=articleStr %>
    </td>
</tr>
    <tr>
    <td  width="19%" height="80"><b>����������</b></td>
    <td  colspan="4" valign="top">
		<%=keyanStr%>
    </td>
</tr>
<tr>
    <td  width="19%" height="80"><b>�ɹ������������гɹ���</b></td>
    <td  colspan="4" valign="top">
		<%=successStr%>
    </td>
</tr>
    <tr>
    <td width="19%" height="80"><b>֤�鼰��ز���</b> </td>
    <td colspan="4" valign="top">
		<%=materStr %>
    </td>
</tr>
</table>
	</td></tr>
</table>

</body>  
</html> 


