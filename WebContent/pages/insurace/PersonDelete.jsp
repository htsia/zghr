<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="../include/taglib.jsp" %>
<%
      response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <x:saveState value="#{ins_PersonInfoBB}"/>
    <h:form id="form1">
    <h:inputHidden value="#{ins_PersonInfoBB.pageInit}"/>
        <%
            String ids = (String)request.getParameter("perIds");
        %>
        <c:verbatim>
        <br>
        <table  align=center border=0 cellpadding=0 cellspacing=0 width=95%>
            <tr><td colspan=2> <strong>������ԱҪ�����ռ�Ա:</strong><br>
</c:verbatim>
              <h:outputLabel value="#{ins_PersonInfoBB.namelist}"></h:outputLabel>
<c:verbatim>
              </td>
            </tr>
            <tr><td colspan=2 height=10></td></tr>

            <tr nowrap>
                <td width="90" class=td_form01>�������</td>
                <td  class=td_form02>
 </c:verbatim>
                    <h:inputText styleClass="input" id="B731702" code="" dict="yes" dict_num="0200"
                                 value="#{ins_PersonInfoBB.changeType}" alt="�������|0|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:B731702','02010020')" >
                </td>
            </tr>
            <tr>
                <td width="90" class=td_form01>��������</td>
                <td  class=td_form02>
 </c:verbatim>
                    <h:inputText styleClass="input" id="B731701" value="#{ins_PersonInfoBB.changeDate}"
                                 alt="��������|0|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:B731701')"/>
                </td>
           </tr>

            <tr nowrap>
                 <td width="90" class=td_form01>������λ</td>
                 <td  class=td_form02>
 </c:verbatim>
                        <h:inputText styleClass="input" id="B731703"
                                     value="#{ins_PersonInfoBB.depName}"
                                     alt="������λ|1|s|50||"/>
<c:verbatim>
                </td>
            </tr>
            <tr>
            	<td width="90" class=td_form01>�䶯ԭ��</td>
                <td  class=td_form02>
 </c:verbatim>
                	<h:inputText styleClass="input" id="B731209" value="#{ins_PersonInfoBB.changeReason}" alt="�䶯ԭ��|1|s|50||"/>
<c:verbatim>
                </td>
            </tr>
            <tr><td colspan=2 height=20></td></tr>
            <tr>
                <td colspan=2 align="right">
 </c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="����" onclick="return forsubmit(document.forms(0))" action="#{ins_PersonInfoBB.delete}" /></td>
<c:verbatim>
            </tr>
        </table>
</c:verbatim>
</h:form>
