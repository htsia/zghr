<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
      response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function addMonth() {
             PopUpCalendarDlg_OnlyMonth('form1:b736701');
             if (document.all('form1:b736701').value!=""){
                 document.all('form1:addmonth').click();
             }
         }
    </script>

    <x:saveState value="#{emp_PersonCountBB}"/>
    <h:form id="form1">
    <h:inputHidden value="#{emp_PersonCountBB.initNewMonth}"/>
    <c:verbatim>
        <table  align=center border=0 cellpadding=0 cellspacing=0 width=95% >
            <tr><td height=12></td></tr>
            <tr>
                <td width="90" class=td_form01><%=LanguageSupport.getResource("RYGL-2256","月份")%></td>
                <td  class=td_form02>
</c:verbatim>
                    <h:inputText styleClass="input" id="b736701" value="#{emp_PersonCountBB.b736701}"
                                 alt="增加日期|0|s|50||"/>
                    <h:commandButton id="addmonth" style="display:none" value="刷新" action="" />
<c:verbatim>
                    <input type="button" class="button_select" onclick="addMonth();">
                </td>
           </tr>

            <tr>
                 <td width="90" class=td_form01><%=LanguageSupport.getResource("RYGL-2257","上月基数")%></td>
                 <td  class=td_form02>
 </c:verbatim>
                        <h:inputText styleClass="input" id="b736702"
                                     value="#{emp_PersonCountBB.b736702}"
                                     alt="上月基数|1|s|50||"/>
<c:verbatim>
                </td>
            </tr>

            <tr><td height=5></td></tr>
            
            <tr>
                <td colspan=2 align="right">
 </c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="保存" onclick="return forsubmit(document.forms(0))" action="#{emp_PersonCountBB.save}" />
<c:verbatim>
                </td>
            </tr>
        </table>
</c:verbatim>        
    </h:form>
