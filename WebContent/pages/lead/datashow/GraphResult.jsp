<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.lead.pojo.bo.GraphResultBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>

<script type="text/javascript">
    function showbig(url) {
        window.open(url);
        return true;
    }
</script>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{graphget}"/>
    <h:form id="form1">
	<h:inputHidden id="init" value="#{graphget.pageInit}"></h:inputHidden>
    <h:inputHidden id="resId" value="#{graphget.resId}"></h:inputHidden>
    <c:verbatim>
        <table width=100% border="0" cellpadding="0" cellspacing="0">
        <tr><td colspan="3" height="8"></td></tr>
        <tr><td colspan="3">
    </c:verbatim>
        <h:outputText escape="false" value ="<strong>名称:</strong>#{graphget.showname}"/>
        <h:outputText value ="    "/>
        <h:outputText value ="选择日期:"/>
        <h:selectOneMenu value="#{graphget.selectDate}">
           <c:selectItems  value="#{graphget.dateList}"></c:selectItems>
        </h:selectOneMenu>
        <h:commandButton value="查看" styleClass="button01" action="#{graphget.queryGraphResult}"></h:commandButton>
     <c:verbatim>
            </td></tr>

            <tr><td colspan="3" height="8"></td></tr>

           <tr>
           <td width=350 valign="top" align="left">
              <table class="table03" id="dataTable" width=350>
                  <tr><td class='td_middle_center' ><strong>X标题</strong></td><td class='td_middle_center' ><strong>Y标题</strong></td><td class='td_middle_center' ><strong>数值</strong></td></tr>
                  <%
                      List list = (List) session.getAttribute("ChartList");
                      if (list != null && list.size() > 0) {
                    	  int total=0;
                          for (int i = 0; i < list.size(); i++) {
                              GraphResultBO gb = (GraphResultBO) list.get(i);
                              total+=Integer.valueOf(gb.getGraphValue());
                              out.println("<tr><td class='td_middle_center'>" + CommonFuns.filterNull(gb.getGraphXLabel()) + "</td><td class='td_middle_center'>"+CommonFuns.filterNull(gb.getGraphYLabel())+"</td><td class='td_middle_center'>"+CommonFuns.filterNull(gb.getGraphValue())+"</td></tr>");
                          }
                          out.println("<tr><td colspan='2' class='td_middle_center'><strong>合计<strong></td><td class='td_middle_center'>"+total+"</td></tr>");
                      }
                  %>
              </table>
           </td>
           <td width=12></td>
         <td valign="top" align="left">
</c:verbatim>
                <h:graphicImage value="#{graphget.smallFile}" alt="点击看大图"  onclick="showbig('#{graphget.bigFile}')"/>
<c:verbatim>
        </td>

           </tr>
        </table>
    </c:verbatim>
    </h:form>
<script type="text/javascript">
   setDataTableOver("dataTable");
</script>