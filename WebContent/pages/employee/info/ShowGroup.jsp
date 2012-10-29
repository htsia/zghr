<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function forViewPerson(pid){
            window.showModalDialog("/insurace/showBusiDetail.jsf?pid="+pid+"&timeField="+document.all("form1:timeField").value+"&beginTime="+document.all("form1:beginTime").value+"&endTime="+document.all("form1:endTime").value+"&setId=" + form1.all("form1:setId").value+"&groupField="+form1.all("form1:groupField").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        }
    </script>

  <x:saveState value="#{emp_busiqueryBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{emp_busiqueryBB.showGroup}"/>
      <h:inputHidden id="setId" value="#{emp_busiqueryBB.setId}"/>
      <h:inputHidden id="timeField" value="#{emp_busiqueryBB.timeField}"/>
      <h:inputHidden id="beginTime" value="#{emp_busiqueryBB.beginTime}"/>
      <h:inputHidden id="endTime" value="#{emp_busiqueryBB.endTime}"/>
      <h:inputHidden id="groupField" value="#{emp_busiqueryBB.sortField}"/>
      <c:verbatim>
      <table  width="98%" height=98% border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >
          <tr >
              <td class="td_title" height=8>
                  <img src="/images/tips.gif" >
                    <%=LanguageSupport.getResource("RYGL-2394","   汇总") %>  
                
               </td>

              <td  class="td_title" height=8 align="right">
        </c:verbatim>
                      <h:commandButton id="export" value="导出" styleClass="button01" onclick="ExportShowTable();" type="button"></h:commandButton>
                      <h:commandButton value="关闭" styleClass="button01" type="button" onclick="window.close()"></h:commandButton>
<c:verbatim>
              </td>
          </tr>

       <tr><td colspan=2>
          <jsp:include page="/pages/common/activepage/ShowTable.jsp">
              <jsp:param name="para" value="true"/>
              <jsp:param name="rowFuncName" value="forViewPerson"/>
          </jsp:include>
       </td></tr>
       </table>
</c:verbatim>
  </h:form>
