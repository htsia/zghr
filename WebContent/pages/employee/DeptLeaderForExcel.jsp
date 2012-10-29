<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.emp.pojo.vo.DeptLeaderVO"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<%
    response.setHeader("Content-Disposition", "filename=" + new String(com.hr319wg.util.CommonFuns.filterNull("�����쵼����.xls").getBytes("GBK"),"ISO8859_1"));
%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
</head>

<body>
    <table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" class="table03">
        <tr class="td_form01">
            <td nowrap><%=LanguageSupport.getResource("RYGL-2406","����") %></td>
            <td nowrap><%=LanguageSupport.getResource("GWGL-1017","����") %></td>
            <td nowrap><%=LanguageSupport.getResource("RYGL-2407","�ܾ���") %></td>
            <td nowrap><%=LanguageSupport.getResource("RYGL-2408","���ܾ���") %></td>
            <td nowrap><%=LanguageSupport.getResource("RYGL-2409","�ܾ�������") %></td>
            <td nowrap><%=LanguageSupport.getResource("RYGL-2410","���쵼ְ��") %></td>
        </tr>

<%

    DeptLeaderVO[] vos = (DeptLeaderVO[])session.getAttribute("table1");
    if(vos != null){
        for(int i=0;i<vos.length;i++){
           DeptLeaderVO vo = vos[i];

%>
        <tr>
           <td nowrap><%=vo.getOrg()%></td>
            <td nowrap><%=vo.getDept()%></td>
            <td nowrap><%=vo.getGeneralManager()%></td>
            <td nowrap><%=vo.getViceManager()%></td>
            <td nowrap><%=vo.getManagerAssistant()%></td>
            <td nowrap><%=vo.getNonLeader()%></td>
        </tr>
        <%
              }
    }
        %>
    </table>

</body>
</html>