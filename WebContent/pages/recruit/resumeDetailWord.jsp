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
	<tr><td align="center" width="100%"><b>河北北方学院人才招聘登记表</b></td></tr>
	<tr><td align="center" width="100%">
	<table  width=100% align=center border="1" cellpadding="0" cellspacing="0">
<tr>
    <td width="15%"><b>姓名</b></td>
    <td>
		<%=personbo.getA001001() %>
    </td>
    <td width="15%"><b>性别</b></td>
    <td>
		<%=personbo.getA001007() %>
    </td>
    <td rowspan="5">
		<%
		out.println("<img alt='照片' id='photo' src='/file/tmp/"+tephto+".JPG' width='93' height='140'/>");
		%>
    </td>
</tr>

<tr>
    <td><b>出生日期</b></td>
    <td>
		<%=personbo.getA001011() %>       
    </td>
     <td><b>身份证号</b></td>
    <td>
		<%=personbo.getA001077() %>
    </td>
</tr>
<tr nowrap>
    <td><b>学历</b></td>
    <td>
		<%=degree%>       
    </td>
    <td><b>专业</b></td>
    <td>
		<%=major%>
    </td>
</tr>
<tr>
    <td ><b>现居住地区</b></td>
    <td >
		<%=addressbo.getA080722() %>        
    </td>
    <td ><b>移动电话</b></td>
    <td >
		<%=addressbo.getA080710() %>
    </td>
</tr>
<tr>
    <td><b>家庭电话</b></td>
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
    <td width="19%" height="80"><b>受教育情况</b></td>
    <td  colspan="4" valign="top">
		<%=educationStr%>
    </td>
</tr>
<tr>
    <td  width="19%" height="80"><b>工作经历</b></td>
    <td  colspan="4" valign="top">
		<%=wokeInofStr%>
    </td>
</tr>
<tr>
    <td  width="19%" height="80"><b>语言能力</b></td>
    <td  colspan="4" valign="top">
		<%=languageStr %>
    </td>
</tr>
    <tr>
    <td  width="19%" height="80"><b>计算机能力</b></td>
    <td  colspan="4" valign="top">
		<%=computerStr %>
    </td>
</tr>
    <tr>
    <td  width="19%" height="80"><b>专业技术资格</b></td>
    <td  colspan="4" valign="top">
		<%=specialStr%>
    </td>
</tr>
<tr>
    <td  width="19%" height="80"><b>科研论文情况</b></td>
    <td  colspan="4" valign="top">
		<%=articleStr %>
    </td>
</tr>
    <tr>
    <td  width="19%" height="80"><b>参与课题情况</b></td>
    <td  colspan="4" valign="top">
		<%=keyanStr%>
    </td>
</tr>
<tr>
    <td  width="19%" height="80"><b>成果奖励（含科研成果）</b></td>
    <td  colspan="4" valign="top">
		<%=successStr%>
    </td>
</tr>
    <tr>
    <td width="19%" height="80"><b>证书及相关材料</b> </td>
    <td colspan="4" valign="top">
		<%=materStr %>
    </td>
</tr>
</table>
	</td></tr>
</table>

</body>  
</html> 


