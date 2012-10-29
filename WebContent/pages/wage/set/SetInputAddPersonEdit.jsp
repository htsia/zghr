<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String[] field = (String[]) session.getAttribute("field");
    String[] persId = (String[]) session.getAttribute("persId");
    HashMap rs = (HashMap) session.getAttribute("value");
%>
<html>
<head>
    <base target="_self">
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <%
       out.println("<script language='javascript'>");
       out.println("   function batchSetValue(){");
       for(int i=0;i<field.length;i++){
           out.println("    if (document.all('All"+field[i]+"').value!='') {");
           for(int j=0;j<persId.length;j++) {
               out.println("       document.all('"+persId[j] + "|" +field[i]+"').value=document.all('All"+field[i]+"').value;");
           }
           out.println("    }");
       }
       out.println("      return false;");
       out.println("   }");
       out.println("</script>");
      %>
</head>

<body>
<x:saveState value="#{wage_setInputBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_setInputBB.pageInit}"/>
    <h:panelGrid columns="3" width="95%" align="center">
        <h:outputText value="发薪单位:#{wage_setInputBB.unitName}"/>
        <h:outputText value="账套名称:#{wage_setInputBB.setName}"/>
        <h:panelGrid columns="3" cellspacing="2">
            <h:commandButton styleClass="button01" value="批量赋值" onclick="return batchSetValue()"/>
            <h:commandButton styleClass="button01" value="保存" action="#{wage_setInputBB.saveAddPersonInput}"
                             onclick="return forsubmit(form1)">
                <x:updateActionListener property="#{wage_computeBB.dateId}" value="#{wage_setInputBB.dateId}"/>
                <x:updateActionListener property="#{wage_computeBB.payoffDate}" value="#{wage_setInputBB.payoffDate}"/>
                <x:updateActionListener property="#{wage_computeBB.setId}" value="#{wage_setInputBB.setId}"/>
                <x:updateActionListener property="#{wage_computeBB.unitId}" value="#{wage_setInputBB.unitId}"/>
                <x:updateActionListener property="#{wage_computeBB.setName}" value="#{wage_setInputBB.setName}"/>
                <x:updateActionListener property="#{wage_computeBB.unitName}" value="#{wage_setInputBB.unitName}"/>
                <x:updateActionListener property="#{wage_computeBB.operCompute}" value="#{wage_setInputBB.operRight}"/>
            </h:commandButton>
            <h:commandButton styleClass="button01"  value="取消" action="success">
                <x:updateActionListener property="#{wage_computeBB.dateId}" value="#{wage_setInputBB.dateId}"/>
                <x:updateActionListener property="#{wage_computeBB.payoffDate}" value="#{wage_setInputBB.payoffDate}"/>
                <x:updateActionListener property="#{wage_computeBB.setId}" value="#{wage_setInputBB.setId}"/>
                <x:updateActionListener property="#{wage_computeBB.unitId}" value="#{wage_setInputBB.unitId}"/>
                <x:updateActionListener property="#{wage_computeBB.setName}" value="#{wage_setInputBB.setName}"/>
                <x:updateActionListener property="#{wage_computeBB.unitName}" value="#{wage_setInputBB.unitName}"/>
                <x:updateActionListener property="#{wage_computeBB.operCompute}" value="#{wage_setInputBB.operRight}"/>
            </h:commandButton>
        </h:panelGrid>
    </h:panelGrid>
    <c:verbatim escape="false">
        <br>
        <%
            if (persId != null && field != null) {
                int col = field.length;
                int row = persId.length;
        %>
        <table width="95%" align="center" cellpadding="2" cellspacing="0" class="table03">
            <tr>
                <td colspan="<%=col+1%>" nowrap class="td_top">已选择人员列表</td>
            </tr>

            <tr>
                <td nowrap class="td_top">姓名 </td>
                <%
                    for (int j = 0; j < col; j++) {
                        out.println("<td class=td_top>" + CodeUtil.interpertCode("INFOITEM", field[j]) + "</td>");
                    }
                %>
            </tr>
            <%
                 out.println("<tr>");
                 for (int j = -1; j < col; j++) {
                    if (j == -1) {
                        out.println("<td class=td_top><strong>批量赋值=></strong></td>");
                    } else {
                        String fldname = "All"+field[j];
                        InfoItemBO item= SysCacheTool.findInfoItem("A815",field[j]);
                        if (InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType())) {
                            out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|1|s'></td>");
                        } else {
                            out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='' class='input' size=10 maxlenght=20 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|1|f'></td>");
                        }
                    }
                 }
                 out.println("</tr>");
            %>
            <%
                for (int i = 0; i < row; i++) {
                    out.println("<tr>");
                    for (int j = -1; j < col; j++) {
                        if (j == -1) {
                            out.println("<td class=td_top>" + CodeUtil.interpertCode("PE", persId[i]) + "</td>");
                        } else {
                            String fldname = persId[i] + "|" + field[j];
                            InfoItemBO item= SysCacheTool.findInfoItem("A815",field[j]);
                            if (InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType())) {
                                String value = CommonFuns.filterNullToZero((String) rs.get(fldname));
                                out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + value + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td>");
                            } else {
                                String value = CommonFuns.filterNullToZero((String) rs.get(fldname));
                                out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + value + "' class='input' size=10 maxlenght=20 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|f'></td>");
                            }
                        }
                    }
                    out.println("</tr>");
                }
            %>
        </table>
        <%
            }
        %>
    </c:verbatim>
</h:form>
</body>
</html>