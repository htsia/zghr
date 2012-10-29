<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <base target="_self">
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
</head>

<body>
<x:saveState value="#{emp_pieceBatchEditBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{emp_pieceBatchEditBB.pageInit}"></h:inputHidden>
    <h:panelGrid align="center" columns="3" width="95%" >
        <h:outputText value="批量录入计量信息"/>
        <h:panelGrid align="center" columns="3" width="15%">
            <h:commandButton styleClass="button01" value="批量录入" onclick="return batchSetValue();"  />
            <h:commandButton styleClass="button01" value="确认" action="#{emp_pieceBatchEditBB.save}"   />
            <h:commandButton styleClass="button01" type="button" value="取消" onclick="window.close()"/>
        </h:panelGrid>
    </h:panelGrid>

    <c:verbatim escape="false">
     <br>
     <br>
        <%
            String[] persId=(String[])session.getAttribute("persId");            
            String[]  field=(String[])session.getAttribute("field");

            out.println("<script language='javascript'>");
            out.println("   function batchSetValue(){");
            out.println("     //debugger;");
               if (field!=null && persId!=null) {
                   for(int i=0;i<field.length;i++){
                       String inputField=field[i];
                       out.println("    if (document.all('All"+inputField+"').value!='') {");
                       for(int j=0;j<persId.length;j++) {
                           out.println("       document.all('"+persId[j] + "|" +inputField+"').value=document.all('All"+inputField+"').value;");
                       }
                       out.println("    }");
                   }
               }
               out.println("      return false;");
               out.println("   }");
               out.println("</script>");

            HashMap rs=(HashMap)session.getAttribute("table");
            if (persId != null && field != null) {
                int col = field.length;
                int row = persId.length;
        %>
        <table width="95%" align="center" cellpadding="2" cellspacing="0" class="table03">
            <tr>
                <td colspan="<%=col+1%>" nowrap class="td_top">已选择人员列表&nbsp&nbsp<%out.print("共有"+row+"人");%></td>
            </tr>
            <tr>
                <td>批量赋值:</td>
                <%
                    for (int j = 0; j < col; j++) {
                        out.println("<td class=td_top><input name='All" + field[j] + "' type='text' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td></td>");
                    }
                %>
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
                for (int i = 0; i < row; i++) {
                    out.println("<tr>");
                    for (int j = -1; j < col; j++) {
                        if (j == -1) {
                            out.println("<td class=td_top>" + CodeUtil.interpertCode("PE", persId[i]) + "</td>");
                        } else {
                            String fldname = persId[i] + "|" + field[j];
                            InfoItemBO item= SysCacheTool.findInfoItem("",field[j]);
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