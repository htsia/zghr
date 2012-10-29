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
%>
    <script language="javascript">
        function doCheck(){
            if (document.all("form1:copyDate").value==""){
                alert("请选择要复制的数据！");
                return false;
            }
            return true;
        }
       function beginInput(){
           if (document.all('form1:inputField').value=="-1"){
               alert("请选择录入项目！");
               return false;
           }
           else{
               return true;
           }
       }
    </script>

    <x:saveState value="#{wage_deptInputBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_deptInputBB.pageInit}"/>
    <h:inputHidden id="setId" value="#{wage_deptInputBB.setId}"/>
    <h:inputHidden id="unitId"value="#{wage_deptInputBB.unitId}"/>
    <h:inputHidden id="dateId" value="#{wage_deptInputBB.dateId}"/>
    <%
       String field =(String)session.getAttribute("field");
       String[] deptId = (String[]) session.getAttribute("deptId");
       HashMap rs = (HashMap) session.getAttribute("value");
       out.println("<script language='javascript'>");
       out.println("   function batchSetValue(){");
       if (deptId!=null && field!=null && !field.equals("")){
           out.println("    if (document.all('All"+field+"').value!='') {");
           for(int j=0;j<deptId.length;j++) {
               out.println("       document.all('"+deptId[j] + "|" +field+"').value=document.all('All"+field+"').value;");
           }
           out.println("    }");
       }
       out.println("      return false;");
       out.println("   }");
       out.println("</script>");
      %>

    <h:panelGrid styleClass="td_title" columns="2" width="100%" align="center">
        <h:panelGroup>
            <h:outputText escape="false" value="发薪单位:#{wage_deptInputBB.unitName}&nbsp;&nbsp;"/>
            <c:verbatim><br></c:verbatim>
            <h:outputText escape="false" value="账套名称:#{wage_deptInputBB.setName}&nbsp;&nbsp;"/>
        </h:panelGroup>

        <h:panelGroup>
             <h:selectOneMenu id="inputField" value="#{wage_deptInputBB.inputField}">
                <c:selectItems value="#{wage_deptInputBB.inputList}"></c:selectItems>
            </h:selectOneMenu>
            <h:commandButton styleClass="button01" value="开始录入" onclick="return beginInput();" action="#{wage_deptInputBB.changeInput}"/>
            
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="1" width="98%" align="center">
        <h:panelGrid  columns="1" align="right">
            <h:panelGroup>
                <h:selectOneMenu id="copyDate" value="#{wage_deptInputBB.copyDate}" >
                    <c:selectItems value="#{wage_deptInputBB.dateList}"></c:selectItems>
                </h:selectOneMenu>
                <h:commandButton styleClass="button01" value="复制" onclick="return doCheck();" action="#{wage_deptInputBB.doCopy}"/>
                <h:commandButton styleClass="button01" value="批量赋值" type="button" onclick="return batchSetValue()"/>
                <h:commandButton styleClass="button01" value="保存" action="#{wage_deptInputBB.save}"
                                 onclick="return forsubmit(form1)"/>
                <h:commandButton styleClass="button01" type="button" value="取消" onclick="window.close()"/>
            </h:panelGroup>
        </h:panelGrid>

    </h:panelGrid>

    <c:verbatim escape="false">
        <br>
        <%
            if (deptId != null && field != null) {
                int row = deptId.length;
        %>
        <table width="95%" align="center" cellpadding="2" cellspacing="0" class="table03">
            <tr>
                <td nowrap class="td_top">薪资部门 </td>
                <%
                     out.println("<td class=td_top>" + CodeUtil.interpertCode("INFOITEM", field) + "</td>");
                %>
            </tr>
            <%
                out.println("<tr>");
                out.println("<td class=td_top><strong>批量赋值=></strong></td>");
                String fldname = "All"+field;
                InfoItemBO item= SysCacheTool.findInfoItem("B732",field);
                if (InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType())) {
                    out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|1|s'></td>");
                } else {
                    out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='' class='input' size=10 maxlenght=20 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|1|f'></td>");
                }
                out.println("</tr>");

                for (int i = 0; i < row; i++) {
                    out.println("<tr>");
                    out.println("<td class=td_top>" + deptId[i] + "</td>");
                    fldname=deptId[i]+"|"+field;
                    if (InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType())) {
                        String value = CommonFuns.filterNullToZero((String) rs.get(fldname));
                        out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + value + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td>");
                    } else {
                        String value = CommonFuns.filterNullToZero((String) rs.get(fldname));
                        out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + value + "' class='input' size=10 maxlenght=20 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|f'></td>");
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
