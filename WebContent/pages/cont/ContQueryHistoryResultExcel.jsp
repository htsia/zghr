<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setContentType("application/vnd.ms-excel");
    response.setHeader("Content-Disposition", "filename=" + new String(com.hr319wg.util.CommonFuns.filterNull("����excel�ļ�.xls").getBytes("GBK"),"ISO8859_1"));
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%
 try {
%>
<%
    String personId = request.getParameter("personId");
    String personName = com.hr319wg.sys.cache.SysCacheTool.findPersonById(personId).getName();
    com.hr319wg.cont.ucc.IContSignUCC ucc = (com.hr319wg.cont.ucc.IContSignUCC) SysContext.getBean("cont_iContSignUCC");
    com.hr319wg.cont.pojo.bo.ContSignBO[] bos = ucc.queryContHistoryByPersonId(personId);
%>
<html>
<head>
<title></title>
</head>
<body>
<table  border="1">
<tr>
<td colspan="12" align="center"><b> <%=new String( ("["+ personName + "]��ͬ��ʷǩ�����").getBytes("GBK"),"ISO8859_1")%> </b></td>
</tr>
</table>

<table  border="1">
<tr>
       <td colspan="1" align="center"><%=new String("���".getBytes("GBK"),"ISO8859_1")%></td>
       <td colspan="2" align="center"><%=new String("��ͬ��Э����".getBytes("GBK"),"ISO8859_1")%></td>
       <td colspan="2" align="center"><%=new String("��ͬ��Э�����".getBytes("GBK"),"ISO8859_1")%></td>
       <td colspan="2" align="center"><%=new String("��Чʱ��".getBytes("GBK"),"ISO8859_1")%></td>
       <td colspan="2" align="center"><%=new String("��ʼʱ��".getBytes("GBK"),"ISO8859_1")%></td>
       <td colspan="2" align="center"><%=new String("����ʱ��".getBytes("GBK"),"ISO8859_1")%></td>
       <td colspan="2" align="center"><%=new String("�Ͷ���ͬ��������".getBytes("GBK"),"ISO8859_1")%></td>

</tr>
<%
 for (int i = 0; i < bos.length; i++) {

%>
<tr>
    <td colspan="1" align="left"><%=(i+1)%></td>
    <td colspan="2" align="left"><%=new String(com.hr319wg.util.CommonFuns.filterNull(bos[i].getContCode()).getBytes("GBK"),"ISO8859_1")%></td>
    <td colspan="2" align="left"><%=new String(com.hr319wg.util.CommonFuns.filterNull(bos[i].getContClassName()).getBytes("GBK"),"ISO8859_1")%></td>
    <td colspan="2" align="left"><%=new String(com.hr319wg.util.CommonFuns.filterNull(bos[i].getValidDate()).getBytes("GBK"),"ISO8859_1")%></td>
    <td colspan="2" align="left"><%=new String(com.hr319wg.util.CommonFuns.filterNull(bos[i].getContStartDate()).getBytes("GBK"),"ISO8859_1")%></td>
    <td colspan="2" align="left"><%=new String(com.hr319wg.util.CommonFuns.filterNull(bos[i].getContEndDate()).getBytes("GBK"),"ISO8859_1")%></td>
    <td colspan="2" align="left"><%=new String(com.hr319wg.util.CommonFuns.filterNull(bos[i].getContTermClass()).getBytes("GBK"),"ISO8859_1")%></td>
</tr>

<%
    }
%>
</table>
<br/>
</body>
</html>
<%
    } catch (Exception e) {
        out.println("\n export excel error!");
    }
%>