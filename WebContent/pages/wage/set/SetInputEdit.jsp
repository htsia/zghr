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

    String[] field = (String[]) session.getAttribute("field");
    String[] persId = (String[]) session.getAttribute("persId");
    HashMap rs = (HashMap) request.getAttribute("value");
    
%>
<script language=javascript src="/js/list.js"></script>
<script language=javascript >
    function doCheck(){
        return forsubmit(form1);
    }
</script>
<x:saveState value="#{wage_setInputBB}"/>
<h:form id="form1">
        <h:inputHidden value="#{wage_setInputBB.isTry}"/>
        <c:verbatim>
        <table width=100% height=98% cellspacing=0 cellpadding=0 border=0>
         <tr height=8><td>
        </c:verbatim>
        <h:panelGrid columns="3" width="95%" align="center">
            <h:outputText value="发薪单位:#{wage_setInputBB.unitName}"/>
            <h:panelGrid columns="3" cellspacing="2">
                <h:commandButton styleClass="button01" value="批量赋值" onclick="return batchSetValue()"/>
                <h:commandButton styleClass="button01" value="保存" action="#{wage_setInputBB.savePersonInput}"
                                 onclick="return doCheck();"/>
                <h:commandButton styleClass="button01" type="button" value="取消" onclick="window.close()"/>
            </h:panelGrid>
        </h:panelGrid>
    <c:verbatim >
        </td></tr>

        <%
            if (persId != null && field != null) {
                int col = field.length;
                int row = persId.length;
        %>
        <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
            <table  align="center" cellpadding="2" cellspacing="0" class="table03" id="setlist">
                <tr>
                    <td nowrap id="locked" style='z-index:3' class="locked_top" align="center"><strong>员工编号</strong></td>
                    <td nowrap id="locked" style='z-index:3' class="locked_top" align="center" width=70><strong>姓名</strong></td>
                    <td nowrap id="locked" style='z-index:3' class="locked_top" align="center" width=80><strong>薪资部门</strong></td>
                    <td nowrap id="locked" style='z-index:3' class="locked_top" align="center"><strong>薪资排序</strong></td>
                    <%
                        for (int j = 0; j < col; j++) {
                            InfoItemBO ib=SysCacheTool.findInfoItem("",field[j]);
                    %>
                            <td class="locked_top" style='z-index:2' id="locked" align="center"><strong>
                    <%
                            out.println(ib.getItemName()+"<br>"+CommonFuns.filterNull(ib.getItemDesc()) );
                     %>
                            </strong></td>
                    <%
                        }
                    %>
                </tr>
                <%
                    out.println("<tr>");
                    for (int j = -1; j < col; j++) {
                        if (j == -1) {
                            out.println("<td class=td_top colspan=4><strong>批量赋值=></strong></td>");
                        } else {
                            String fldname = "All" + field[j];
                            InfoItemBO item = SysCacheTool.findInfoItem("A815", field[j]);
                            String dataType = "f";
                            if (InfoItemBO.DATA_TYPE_INT.equals(item.getItemDataType())) {
                                dataType = "i";
                            }
                            
                            if (InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType())) {
                                out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|1|s'></td>");
                            } else {
                                if ("1".equals(Constants.WAGE_DATA_AUTO_FORMAT)){
                                    out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='' class='input' size=10 maxlenght=20 style=\"behavior:url('../../js/mytextbox.htc');\"'></td>");
                                }
                                else{
                                    out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='' class='input' size=10 maxlenght=20 style=\"behavior:url('../../js/mytextbox.htc');\" alt='" + item.getItemName() + "|1|" + dataType + "|" + item.getItemDataLength() + "|" + CommonFuns.filterNull(item.getItemMin()) + "|" + CommonFuns.filterNull(item.getItemMax()) + "|" + CommonFuns.filterNull(item.getItemPrecision()) + "'></td>");
                                }
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
                                PersonBO pb =SysCacheTool.findPersonById(persId[i]);
                                out.println("<td  class=locked_top>" + pb.getPersonCode() + "</td>");
                                out.println("<td  class=locked_top>" + pb.getName() + "</td>");
                                out.println("<td  class=locked_top>" + ((pb.getDeptSort()!=null && !"".equals(pb.getDeptSort()) && pb.getDeptSort().length()>2)?pb.getDeptSort().substring(2):pb.getDeptSort())+ "</td>");
                                out.println("<td  class=locked_top>" + CommonFuns.filterNull(pb.getSort()) + "</td>");
                            } else {
                                String fldname = persId[i] + "|" + field[j];
                                InfoItemBO item = SysCacheTool.findInfoItem("A815", field[j]);
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
                            }
                        }
                        out.println("</tr>");
                    }
                %>
            </table>
        </div>
        </td></tr>
        <%
            }
        %>
       </table>
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
       out.println("      if (checkOne('All"+field[i]+"')=='1'){");
       for(int j=0;j<persId.length;j++) {
           out.println("       document.all('"+persId[j] + "|" +field[i]+"').value=document.all('All"+field[i]+"').value;");
       }
       out.println("      } ");
       out.println("    }");
   }
  %>
        return false;
       }

        try{
            listControl=setlist;
        }
        catch(e){

        }

       tableFixCol=4;
       window.setInterval('setFix()', 700);
       window.setInterval('setFixCol()', 700);
</script>
