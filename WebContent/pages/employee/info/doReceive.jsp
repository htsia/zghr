<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
    <x:saveState value="#{emp_CadresImportBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{emp_CadresImportBB.receiveEdit}"/>
        <c:verbatim>
        <table width="98%" align="center">
            <tr class="td_title">
                <td colspan=2 align="right">
</c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="����" onclick="return forsubmit(document.forms(0))" action="#{emp_CadresImportBB.saveReceive}" />
                    <h:commandButton type="button" styleClass="button01" value="�ر�" onclick="window.close()"/>
<c:verbatim>
                </td>
            </tr>
            <tr nowrap>
                <td class="td_form01 td_form_required" width="120"><%=LanguageSupport.getResource("XTGL-1047","��Ա���")%></td>
                <td class=td_form02>
 </c:verbatim>
                    <h:inputText styleClass="input" id="A016010" code="" dict="yes" dict_num="0200"
                                 readonly="true" value="#{emp_CadresImportBB.personchangevo.changeType}"
                                 alt="��Ա���|0|s|50||"/>
                    <h:commandButton type="button" styleClass="button_select"    onclick="PopUpCodeDlgOneControl('form1:A016010','0200110001')" />
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01 td_form_required" width="120"><%=LanguageSupport.getResource("RYGL-2282","��Աʱ��")%></td>
                <td class=td_form02>
 </c:verbatim>
                    <h:inputText styleClass="input" id="A016020" value="#{emp_CadresImportBB.personchangevo.changeDate}"
                                 readonly="true" alt="��Աʱ��|0|d6|50||"/>
                    <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:A016020')" />
<c:verbatim>
                </td>
            </tr>
            <tr nowrap>
               <td class=td_form01><%=LanguageSupport.getResource("RYGL-1016","����")%></td>
               <td class=td_form02>
</c:verbatim>
                    <h:inputText readonly="true" value="#{emp_CadresImportBB.cadbo.name}"></h:inputText>
<c:verbatim>
               </td>
           </tr>

            <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("XTGL-1044","Ա�����")%></td>
            <td class=td_form02>
 </c:verbatim>
                <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                             readonly="true" value="#{emp_CadresImportBB.personvo.personType}"
                             alt="Ա�����|0|s|50||"/>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:A001054')"/>
<c:verbatim>
            </td>

             <tr nowrap>
                <td class=td_form01 td_form_required><%=LanguageSupport.getResource("RYGL-2019","���벿��")%></td>
                <td class=td_form02 >
 </c:verbatim>
                    <h:inputText styleClass="input" id="A016030" value="#{emp_CadresImportBB.personvo.deptId}" dict="yes" dict_num="OU"  code=""
                            readonly="true"    alt="���벿��|1|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpOrgDlg('form1:A016030',2)">
                </td>
            </tr>
        </table>
 </c:verbatim>
    </h:form>
