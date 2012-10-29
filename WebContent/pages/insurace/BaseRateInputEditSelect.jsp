<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.wage.ucc.impl.WageSetPersonUCC"%>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.wage.ucc.IWageItemPowerUCC" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.api.WageAPI" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    String[] persId=(String[]) session.getAttribute("persId");
    String[] field=(String[]) session.getAttribute("field");
    HashMap rs = (HashMap) request.getAttribute("value");
    // 基本养老保险个人月缴费基数(A755715)
    // 基本医疗保险个人月缴费基数(A760710)
    // 工伤保险单位月缴费基数(A765705)
    // 失业保险个人月缴费基数(A770710)
    //  生育保险单位月缴费基数(A775704)
    //  住房公积金个人月缴费基数(A780708)

    String setAllCommond="";
%>
    <script type="text/javascript">
        function doSetValue(id) {
            <%
            for(int i=0;i<field.length;i++){
                out.println("document.all(id+\"|"+field[i]+"\").value=document.all(\"Base_\"+id).value");
            }
            %>
        }
    </script>

<x:saveState value="#{ins_brieBB}"/>

<h:form id="form1">
    <h:panelGrid align="center" columns="2" width="95%" >
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="录入保险基数"/>
        </h:panelGroup>
        <h:panelGrid align="right" columns="3">
            <h:panelGroup>
                <h:inputText id="allrate" size="10"></h:inputText>
                <h:commandButton value="设置全部" styleClass="button01" type="button" onclick="doSetAll();"></h:commandButton>
                <h:selectBooleanCheckbox value="#{ins_brieBB.autoCalc}"></h:selectBooleanCheckbox>
                <h:outputText value="保存后自动计算缴费额"></h:outputText>
            </h:panelGroup>
            <h:commandButton styleClass="button01" value="确认" action="#{ins_brieBB.savePersonBase}"   />
            <h:commandButton styleClass="button01" type="button" value="取消" onclick="window.close()"/>
        </h:panelGrid>
    </h:panelGrid>

    <c:verbatim escape="false">
     <br>
     <br>
        <%
            if (persId != null && field != null) {
                int col = field.length;
                int row = persId.length;
        %>
        <table width="95%" align="center" cellpadding="2" cellspacing="0" class="table03" id="setlist">
            <tr>
                <td colspan="<%=col+3%>" nowrap class="td_top"><strong>已选择人员列表&nbsp&nbsp<%out.print("共有"+row+"人");%></strong></td>
            </tr>

            <tr>
                <td nowrap class="td_top" align="center"><strong>员工编号</strong></td>
                <td nowrap class="td_top" align="center"><strong>姓名</strong></td>
                <%if (col>1) { %>
                  <td nowrap class="td_top" align="center"><strong>基数</strong></td>
                <%
                    }
                    for (int j = 0; j < col; j++) {
                        out.println("<td class=td_top align=\"center\"><strong>" + CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM, field[j]) + "</strong></td>");
                    }
                %>
            </tr>
            <%

                for (int i = 0; i < row; i++) {
                    out.println("<tr>");
                    PersonBO pb=SysCacheTool.findPersonById(persId[i]);
                    for (int j = -1; j < col; j++) {
                        if (j == -1) {
                            out.println("<td width='80px' class=td_top>" + pb.getPersonCode() + "</td>");
                            out.println("<td width='80px' class=td_top>" + pb.getName()+ "</td>");
                            if (col>1){
                                out.println("<td width='120px' class=td_top>");
                                out.println("<input name='Base_" + pb.getPersonId() + "' type='text' value='' class='input' size=10>");
                                out.println("<input type='button' class='button01' value='设置' onclick='doSetValue(\""+pb.getPersonId()+"\")'>");
                                setAllCommond+="document.all('Base_"+pb.getPersonId()+"').value=document.all('form1:allrate').value;\r\n";
                                setAllCommond+="doSetValue('"+pb.getPersonId()+"');\r\n";
                                out.println("</td>");
                            }
                        } else {
                            String fldname = persId[i] + "|" + field[j];
                            InfoItemBO item = SysCacheTool.findInfoItem("", field[j]);
                            if (InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType())) {
                            	String value =CommonFuns.filterNullToZero((String) rs.get(fldname));
                                out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + value + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td>");
                            } else {
                                String value =CommonFuns.filterNullToZero((String) rs.get(fldname));
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
   function doSetAll(){
      if (document.all('form1:allrate').value!='')   {
          <%=setAllCommond%>
      }
      else{
          alert("请录入基数值！");
      }
   }
</script>
