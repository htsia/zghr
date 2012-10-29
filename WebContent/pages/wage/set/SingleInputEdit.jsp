<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script language=javascript src="/js/list.js"></script>
<script language=javascript >
    function doCheck(){
        return forsubmit(form1);
    }
</script>
<x:saveState value="#{wage_setInputBB}"/>
<h:form id="form1">
        <h:inputHidden value="#{wage_setInputBB.initSingleEdit}"/>
        <h:inputHidden value="#{wage_setInputBB.setId}"></h:inputHidden>
        <h:inputHidden value="#{wage_setInputBB.dateId}"></h:inputHidden>
        <c:verbatim>
        <table width=100%  cellspacing=0 cellpadding=0 border=0>
         <tr height=8 align="right"><td></td></tr>

         <tr height=8 align="right"><td>
        </c:verbatim>
                <h:commandButton styleClass="button01" value="保存" action="#{wage_setInputBB.savePersonInput}"
                                 onclick="return doCheck();"/>
                <h:commandButton styleClass="button01" type="button" value="取消" onclick="window.close()"/>
    <c:verbatim >
        </td></tr>

        <%
            String[] field = (String[]) session.getAttribute("field");
            String[] persId = (String[]) session.getAttribute("persId");
            HashMap rs = (HashMap) request.getAttribute("value");

            if (persId != null && field != null) {
                int col = field.length;

                PersonBO pb =SysCacheTool.findPersonById(persId[0]);
        %>
        <tr><td>
            <table  align="center" cellpadding="2" cellspacing="0" id="setlist">
                <tr>
                    <td colspan=4>
                        <strong>员工编号:</strong><%=pb.getPersonCode()%>
                        &nbsp;&nbsp;<strong>姓名:</strong><%=pb.getName()%>
                    </td>
                </tr>
                <%
                    int count = 0;
                    for (int j = 0; j < col; j++) {
                        if (count % 2 == 0) {
                            out.println("<tr nowrap>");
                        }

                        String fldname = persId[0] + "|" + field[j];
                        InfoItemBO item = SysCacheTool.findInfoItem("A815", field[j]);
                        out.println("<td class='td_form01'>"+item.getItemName()+"</td>");
                        if (InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType())) {
                            String value = CommonFuns.filterNullToZero((String) rs.get(fldname));
                            out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + value + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td>");
                        } else {
                            String value = CommonFuns.filterNullToZero((String) rs.get(fldname));
                            String dataType="f";
                            if (InfoItemBO.DATA_TYPE_INT.equals(item.getItemDataType())){
                                dataType="i";
                            }
                            if ("1".equals(Constants.WAGE_DATA_AUTO_FORMAT)){
                                out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + value + "' class='input' size=10 maxlenght=20 style=\"behavior:url('../../js/mytextbox.htc');\" ></td>");
                            }
                            else{
                                out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + value + "' class='input' size=10 maxlenght=20 style=\"behavior:url('../../js/mytextbox.htc');\" alt='"+item.getItemName()+"|1|"+dataType+"|"+item.getItemDataLength()+"|"+CommonFuns.filterNull(item.getItemMin())+"|"+CommonFuns.filterNull(item.getItemMax())+"|"+CommonFuns.filterNull(item.getItemPrecision())+"'></td>");
                            }

                        }
                        if (count % 2 == 1) {
                           out.println("</tr>");
                         }
                         count++;
                    }
                  }
                %>
            </table>
        </td></tr>

       </table>
    </c:verbatim>
</h:form>

