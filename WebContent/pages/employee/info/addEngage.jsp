<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
      response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function doCheck() {
            if (document.all("form1:A001054").value==""){
                alert("û��ѡ����Ա���!");
                return false;
            }
            if (document.all("form1:A016030").value==""){
                alert("û��ѡ��Ƹ����!");
                return false;
            }

            return forsubmit(document.forms(0));
         }
        function selectRetirePerson(){
            fPopUpPerDlgFilter('form1:recName', 'form1:recID',"p.personType not in ('<%=Constants.IN_SERVICE_TYPE.replaceAll(",","','")%>')");
        }
    </script>

    <x:saveState value="#{emp_engageBB}"/>
    <h:form id="form1">
        <c:verbatim>
        <table  align=center border=0 cellpadding=0 cellspacing=0 width=95% >
            <tr><td height=12></td></tr>

            <tr>
                <td width="90" class=td_form01> <%=LanguageSupport.getResource("XTGL-1182","��Ա")%>  </td>
                <td  class=td_form02>
</c:verbatim>
                    <h:inputHidden id="recID" value="#{emp_engageBB.pid}"></h:inputHidden>
                    <h:inputText readonly="true" id="recName" value="#{emp_engageBB.PName}" />
<c:verbatim>
                    <input class="button_select" type="button" onclick="selectRetirePerson()">
                </td>
           </tr>

    <tr>
    <td class="td_form01 td_form_required" width="120">��Ƹʱ��</td>
    <td class=td_form02>
 </c:verbatim>
        <h:inputText styleClass="input" id="A016020"
                     readonly="true" value="#{emp_engageBB.changeDate}"
                     alt="��Ƹʱ��|0|s|50||"/>
<c:verbatim>
        <input type="button" class="button_select"    onclick="PopUpCalendarDialog('form1:A016020')">
    </tr>

        <tr>
            <td class="td_form01 td_form_required" width="120"><%=LanguageSupport.getResource("XTGL-1047","��Ա���")%></td>
            <td class=td_form02>
 </c:verbatim>
                <h:inputText styleClass="input" id="A016010" code="" dict="yes" dict_num="0200"
                             readonly="true" value="#{emp_engageBB.changeType}"
                             alt="��Ա���|0|s|50||"/>
<c:verbatim>
                <input type="button" class="button_select"    onclick="PopUpCodeDlgOneControl('form1:A016010','<%=Constants.EMP_ENGAGE_ADD_TYPE%>')">
        </tr>

            <tr>
                 <td width="90" class="td_form01 td_form_required"><%=LanguageSupport.getResource("RYGL-2255","Ƹ����Ա���")%>  </td>
                 <td  class=td_form02>
 </c:verbatim>
                     <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                                  value="#{emp_engageBB.afterType}" alt="�������Ա���|0|s|50||"/>
 <c:verbatim>
                     <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001054','<%=Constants.EMP_ENGAGE_PERSON_TYPE%>')">
                </td>
            </tr>

            <tr>
                 <td width="90" class="td_form01 td_form_required"><%=LanguageSupport.getResource("RYGL-2019","���벿��")%>  </td>
                 <td  class=td_form02>
  </c:verbatim>
                     <h:inputText styleClass="input" id="A016030" value="#{emp_engageBB.chgs}" dict="yes" dict_num="OU"  code=""
                             readonly="true"    alt="���벿��|1|s|50||"/>
<c:verbatim>
                     <input type="button" class="button_select" onclick="PopUpOrgDlg('form1:A016030',2,'<% User user=(User)session.getAttribute(Constants.USER_INFO);out.print(user.getOrgId());%>')">
                </td>
            </tr>

            <tr><td height=5></td></tr>
            
            <tr>
                <td colspan=2 align="right">
 </c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="����" onclick="return doCheck();" action="#{emp_engageBB.addPerson}" />
<c:verbatim>
                </td>
            </tr>
        </table>
 </c:verbatim>
    </h:form>
