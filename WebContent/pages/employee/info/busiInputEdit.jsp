<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    String[] field = (String[]) session.getAttribute("field");
    String[] persId = (String[]) session.getAttribute("persId");
    HashMap rs = (HashMap) request.getAttribute("value");
    
%>

<x:saveState value="#{emp_baseInputBB}"/>
<h:form id="form1">
    <h:panelGrid columns="3" width="95%" align="center">
        <h:panelGrid columns="3" cellspacing="2">
            <h:commandButton styleClass="button01" value="批量赋值" onclick="return batchSetValue()"/>
            <h:commandButton styleClass="button01" value="保存" action="#{emp_baseInputBB.savePersonInput}"
                             onclick="return forsubmit(form1)"/>
            <h:commandButton styleClass="button01" type="button" value="取消" onclick="window.close()"/>
        </h:panelGrid>
    </h:panelGrid>
    <c:verbatim >
        <br>
        <%
            if (persId != null && field != null) {
                int col = field.length;
                int row = persId.length;
        %>
        <table width="95%" align="center" cellpadding="2" cellspacing="0" class="table03" id="setlist">
            <tr>
                <td colspan="<%=col+4%>" nowrap class="td_top">已选择人员列表</td>
            </tr>

            <tr>
                <td nowrap class="td_top">员工编号 </td>
                <td nowrap class="td_top">姓名 </td>
                <td nowrap class="td_top">薪资部门</td>
                <%
                    for (int j = 0; j < col; j++) {
                        InfoItemBO ib=SysCacheTool.findInfoItem("",field[j]);
                %>
                        <td class=td_top>
                <%
                        out.println(ib.getItemName()+"<br>"+CommonFuns.filterNull(ib.getItemDesc()) );
                 %>
                        </td>
                <%
                    }
                %>
            </tr>
            <%
                 out.println("<tr>");
                 for (int j = -1; j < col; j++) {
                    if (j == -1) {
                        out.println("<td class=td_top colspan=3><strong>批量赋值=></strong></td>");
                    } else {
                        String fldname = "All"+field[j];
                        InfoItemBO item= SysCacheTool.findInfoItem("",field[j]);
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
                            PersonBO pb = SysCacheTool.findPersonById(persId[i]);
                            out.println("<td class=td_top>" + pb.getPersonCode() + "</td>");
                            out.println("<td class=td_top>" + pb.getName() + "</td>");
                            out.println("<td class=td_top>" + pb.getDeptSort() + "</td>");
                        } else {
                            String fldname = persId[i] + "|" + field[j];
                            InfoItemBO item = SysCacheTool.findInfoItem("", field[j]);
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
<script type="text/javascript">
   setTableInputOver("setlist");
</script>
<script language='javascript'>
    function batchSetValue(){
<%

   for(int i=0;i<field.length;i++){
       out.println("    if (document.all('All"+field[i]+"').value!='') {");
       for(int j=0;j<persId.length;j++) {
           out.println("       document.all('"+persId[j] + "|" +field[i]+"').value=document.all('All"+field[i]+"').value;");
       }
       out.println("    }");
   }
  %>
        return false;
       }
</script>
