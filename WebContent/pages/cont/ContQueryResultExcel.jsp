<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.exception.SysException"%>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO"%>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO"%>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO"%>
<%@ page import="com.hr319wg.util.CodeUtil"%>
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
        if(request.getSession().getAttribute("cont_selPerObjs")==null){
             throw new SysException("","" ,null, this.getClass());
        }
        RecordVO[] selPerObjs = ((TableVO)request.getSession().getAttribute("cont_selPerObjs")).getRowData();
        if(selPerObjs==null||selPerObjs.length==0){
             throw new SysException("","" ,null, this.getClass());
        }
%>
<html>
<head>
<title></title>
</head>
<body>
<table  border="1">
<tr>
<td colspan="18" align="center"><b> <%=new String("��ͬ��ѯ���".getBytes("GBK"),"ISO8859_1")%> </b></td>
</tr>
</table>

<table  border="1">
<tr>
       <td colspan="2" align="center"><%=new String("�Ͷ���ͬ���".getBytes("GBK"),"ISO8859_1")%></td>
       <td colspan="2" align="center"><%=new String("����".getBytes("GBK"),"ISO8859_1")%></td>
       <td colspan="2" align="center"><%=new String("�Ա�".getBytes("GBK"),"ISO8859_1")%></td>
       <td colspan="2" align="center"><%=new String("����".getBytes("GBK"),"ISO8859_1")%></td>
       <td colspan="2" align="center"><%=new String("�Ͷ���ͬ�������".getBytes("GBK"),"ISO8859_1")%></td>
       <td colspan="2" align="center"><%=new String("Э�����".getBytes("GBK"),"ISO8859_1")%></td>
       <td colspan="2" align="center"><%=new String("�Ͷ���ͬ��������".getBytes("GBK"),"ISO8859_1")%></td>
       <td colspan="2" align="center"><%=new String("�Ͷ���ϵԼ����ʼʱ��".getBytes("GBK"),"ISO8859_1")%></td>
       <td colspan="2" align="center"><%=new String("�Ͷ���ϵԼ����ֹʱ��".getBytes("GBK"),"ISO8859_1")%></td>
</tr>
<%
 for (int i = 0; i < selPerObjs.length; i++) {
                   String contcode = ((CellVO)selPerObjs[i].cellArray2Hash().get("A708703")).getValue();
                   String personName = ((CellVO)selPerObjs[i].cellArray2Hash().get("A001001")).getValue();
                   String personSex_temp = ((CellVO)selPerObjs[i].cellArray2Hash().get("A001007")).getValue();
                   String personSex = CodeUtil.interpertCode("0100",personSex_temp);
                   String personAge = ((CellVO)selPerObjs[i].cellArray2Hash().get("A701701")).getValue();
                   String contClass_temp = ((CellVO)selPerObjs[i].cellArray2Hash().get("A708705")).getValue();
                   String contClass = CodeUtil.interpertCode("0220",contClass_temp);
                   String protClass_temp = ((CellVO)selPerObjs[i].cellArray2Hash().get("A708708")).getValue();
                   String protClass = CodeUtil.interpertCode("0222",protClass_temp);
                   String contTermClass_temp = ((CellVO)selPerObjs[i].cellArray2Hash().get("A708701")).getValue();
                   String contTermClass = CodeUtil.interpertCode("0215",contTermClass_temp);
                   String contStartDate = ((CellVO)selPerObjs[i].cellArray2Hash().get("A708710")).getValue();
                   String contEndDate = ((CellVO)selPerObjs[i].cellArray2Hash().get("A708715")).getValue();
%>
<tr>
    <td colspan="2" align="left"><%=new String(com.hr319wg.util.CommonFuns.filterNull(contcode).getBytes("GBK"),"ISO8859_1")%></td>
    <td colspan="2" align="left"><%=new String(com.hr319wg.util.CommonFuns.filterNull(personName).getBytes("GBK"),"ISO8859_1")%></td>
    <td colspan="2" align="left"><%=new String(com.hr319wg.util.CommonFuns.filterNull(personSex).getBytes("GBK"),"ISO8859_1")%></td>
    <td colspan="2" align="left"><%=new String(com.hr319wg.util.CommonFuns.filterNull(personAge).getBytes("GBK"),"ISO8859_1")%></td>
    <td colspan="2" align="left"><%=new String(com.hr319wg.util.CommonFuns.filterNull(contClass).getBytes("GBK"),"ISO8859_1")%></td>
    <td colspan="2" align="left"><%=new String(com.hr319wg.util.CommonFuns.filterNull(protClass).getBytes("GBK"),"ISO8859_1")%></td>
    <td colspan="2" align="left"><%=new String(com.hr319wg.util.CommonFuns.filterNull(contTermClass).getBytes("GBK"),"ISO8859_1")%></td>
    <td colspan="2" align="left"><%=new String(com.hr319wg.util.CommonFuns.filterNull(contStartDate).getBytes("GBK"),"ISO8859_1")%></td>
    <td colspan="2" align="left"><%=new String(com.hr319wg.util.CommonFuns.filterNull(contEndDate).getBytes("GBK"),"ISO8859_1")%></td>
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