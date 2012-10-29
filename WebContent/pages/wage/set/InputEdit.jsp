<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>

<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script language="javascript" src="<%=request.getContextPath()%>/js/selectitem.js"></script>
    <script type="text/javascript">
       function beginInput(){
           if (document.all("form1:dept").value=="-1"){
               alert("请选择部门!");
               return false;
           }

           if (document.all("form1:fields").value=="-1"){
               alert("请选择录入项目! ");
               return false;
           }
           return true;
       }
    </script>

<x:saveState value="#{wage_templateInputBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_templateInputBB.pageInit}"/>
    <h:inputHidden value="#{wage_templateInputBB.isTry}"/>
    <h:inputHidden value="#{wage_templateInputBB.dateId}"/>
    <h:panelGrid columns="2" width="95%" align="center" styleClass="td_title">
        <h:outputText value="发薪单位:#{wage_templateInputBB.unitName}"/>
        <h:outputText value="账套名称:#{wage_templateInputBB.setName}"/>
    </h:panelGrid>

    <h:panelGrid columns="2" width="95%" align="center">
        <h:panelGrid columns="3" cellspacing="2">
          <h:selectOneMenu id="dept" value="#{wage_templateInputBB.inputDept}">
              <f:selectItems value="#{wage_templateInputBB.deptList}"></f:selectItems>
          </h:selectOneMenu>
          <h:selectOneMenu  id="template" onchange="submit()" value="#{wage_templateInputBB.template}" valueChangeListener="#{wage_templateInputBB.changeTemplate}">
               <f:selectItems value="#{wage_templateInputBB.templateList}" ></f:selectItems>
          </h:selectOneMenu>
          <h:selectOneMenu  id="fields" value="#{wage_templateInputBB.inputField}">
              <f:selectItems value="#{wage_templateInputBB.fieldsList}" ></f:selectItems>
          </h:selectOneMenu>
        </h:panelGrid>

        <h:panelGrid columns="4" cellspacing="2" align="right">
            <h:commandButton styleClass="button01" value="开始录入" onclick="return beginInput();" action="#{wage_templateInputBB.beginInput}" />
            <h:commandButton styleClass="button01" type="button" value="批量赋值" onclick="return batchSetValue();"/>
            <h:commandButton styleClass="button01" value="保存" action="#{wage_templateInputBB.savePersonInput}"
                             onclick="return forsubmit(form1)"/>
            <h:commandButton styleClass="button01" type="button" value="返回" onclick="window.close()"/>
        </h:panelGrid>
    </h:panelGrid>
    <c:verbatim escape="false">
    <%
        String[] field = (String[]) session.getAttribute("field");
        String[] persId = (String[]) session.getAttribute("persId");
        String   inputField = (String) session.getAttribute("inputfield");
        HashMap rs = (HashMap) session.getAttribute("value");

       out.println("<script language='javascript'>");
       out.println("   function batchSetValue(){");
       if (field!=null && persId!=null && inputField!=null) {
           out.println("    if (document.all('All"+inputField+"').value!='') {");
               for(int j=0;j<persId.length;j++) {
                   out.println("       document.all('"+persId[j] + "|" +inputField+"').value=document.all('All"+inputField+"').value;");
               }
               out.println("    }");

       }
       out.println("      return false;");
       out.println("   }");
       out.println("</script>");
      %>
        

        <%
            if (persId != null && field != null) {
                int col = field.length;
                int row = persId.length;
        %>
        <table width="95%" align="center" cellpadding="2" cellspacing="0" class="table03" id="setlist">
            <tr>
                <td colspan="<%=col+4%>" align="left" nowrap class="td_top"><font color=red>模版录入&nbsp;&nbsp;共有人员:<%=row%></font></td>
            </tr>

            <tr>
                <td nowrap class="td_top" align="center">&nbsp;员工编号&nbsp;</td>
                <td nowrap class="td_top" align="center">&nbsp;薪资部门&nbsp;</td>
                <td nowrap class="td_top" align="center">&nbsp;薪资排序&nbsp;</td>
                <td nowrap class="td_top" align="center">&nbsp;&nbsp;姓名&nbsp;&nbsp; </td>
                <%
                    for (int j = 0; j < col; j++) {
                        out.println("<td class=td_top align=\"center\">" + CodeUtil.interpertCode("INFOITEM", field[j]) + "</td>");
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
                        if (item.getItemId().equals(inputField)) {
                            if (InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType())) {
                                out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|1|s'></td>");
                            } else {
                                out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='' class='input' size=10 maxlenght=20 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|1|f'></td>");
                            }
                        } else {
                            out.println("<td class=td_middle> </td>");
                        }
                    }
                }
                out.println("</tr>");

                for (int i = 0; i < row; i++) {
                    out.println("<tr>");
                    for (int j = -1; j < col; j++) {
                        if (j == -1) {
                            PersonBO pb=SysCacheTool.findPersonById(persId[i]);
                            out.println("<td class=td_top>" + pb.getPersonCode() + "</td>");
                            out.println("<td class=td_top>" + pb.getDeptSort() + "</td>");
                            out.println("<td class=td_top>" + pb.getSort() + "</td>");
                            if (persId[i].startsWith("@") || persId[i].startsWith("#")) {
                                out.println("<td class=td_top><font color=red>" + pb.getName() + "(副本)</font></td>");
                            } else {
                                out.println("<td class=td_top>" + pb.getName() + "</td>");
                            }

                        } else {
                            String fldname = persId[i] + "|" + field[j];
                            InfoItemBO item = SysCacheTool.findInfoItem("A815", field[j]);
                            String value = CommonFuns.filterNullToZero((String) rs.get(fldname));
                            if (item.getItemId().equals(inputField)) {
                                if (InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType())) {
                                    out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + value + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td>");
                                } else {
                                    out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + value + "' class='input' size=10 maxlenght=20 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|f'></td>");
                                }
                            } else {
                                out.println("<td class=td_middle>" + value + "</td>");
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
