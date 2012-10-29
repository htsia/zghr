<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="com.hr319wg.common.Constants" %>

<script type="text/javascript">
        function forView() {
            forViewPersonDetail(document.all("form1:code").value);
        }
    </script>

    <x:saveState value="#{emp_personListBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{emp_personListBB.doReduceAudit}"/>
        <h:inputHidden id="code" value="#{emp_personListBB.code}"/>

        <c:verbatim>
        <table width="98%" align="center">
            <tr class="td_title">
                <td colspan=4 align="right">
         </c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="��������" onclick="return forsubmit(document.forms(0))" action="#{emp_personListBB.resumeAudit}" />
                    <h:commandButton type="button" styleClass="button01" value="�ر�" onclick="window.close()"/>
         <c:verbatim>
                </td>
            </tr>

            <tr nowrap>
                <td class=td_form01> <%=LanguageSupport.getResource("XTGL-1042","Ա�����") %></td>
                <td class=td_form02 >
         </c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.personbo.personCode}"></h:inputText>
        <c:verbatim>
                </td>

                <td class=td_form01><%=LanguageSupport.getResource("MSG-0010","����") %></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.reducebo.persName}"></h:inputText>
<c:verbatim>
                </td>
           </tr>


            <tr nowrap>
                <td class=td_form01> <%=LanguageSupport.getResource("MSG-0012","�Ա�") %></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.personbo.sex}"></h:inputText>
<c:verbatim>
                </td>

                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2308","�μӹ���ʱ��") %></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.personbo.workTime}"></h:inputText>
<c:verbatim>
                </td>
            </tr>

            <tr nowrap>
                <td class=td_form01> <%=LanguageSupport.getResource("RYGL-1015","���֤��") %></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.personbo.idCard}"></h:inputText>
<c:verbatim>
                </td>

                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2057","����") %></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.personbo.folk}"></h:inputText>
<c:verbatim>
                </td>
            </tr>

            <tr nowrap>
                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2190","����ʱ��") %></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.reducebo.applyDate}"></h:inputText>
<c:verbatim>
                </td>

                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2299","��Աԭ��") %></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:inputText readonly="true" code="" id="A016010" dict="yes" dict_num="0200" value="#{emp_personListBB.reducebo.a016010}"></h:inputText>
<c:verbatim>
                    <input type='button' class='button_select' onclick="PopUpCodeDlgOneControl('form1:A016010','0200120001')">
                </td>
            </tr>

            <tr nowrap>
               <td class=td_form01><%=LanguageSupport.getResource("RYGL-2306","ԭ���") %></td>
               <td class=td_form02>
</c:verbatim>
                    <h:inputText readonly="true" value="#{emp_personListBB.personbo.personType}"></h:inputText>
<c:verbatim>
               </td>
                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2298","��������") %></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:inputText readonly="true" id="A001054" value="#{emp_personListBB.reducebo.a001054}" code="" dict="yes" dict_num="0135"></h:inputText>
<c:verbatim>
                     <input type='button' class='button_select' onclick="PopUpCodeDlgOneControl('form1:A001054')">
                </td>
           </tr>

            <tr nowrap>
               <td class=td_form01><%=LanguageSupport.getResource("RYGL-2305","ԭ״̬") %></td>
               <td class=td_form02 >
</c:verbatim>
                    <h:inputText readonly="true" value="#{emp_personListBB.personbo.state}"></h:inputText>
<c:verbatim>
               </td>
                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2300","�����״̬") %></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:inputText readonly="true" code="" dict="yes" dict_num="0145" id="A001725" value="#{emp_personListBB.reducebo.a001725des}"></h:inputText>
<c:verbatim>
                      <input type='button' class='button_select' onclick="PopUpCodeDlgOneControl('form1:A001725')">
                </td>
           </tr>


        </table>
</c:verbatim>
</h:form>
        <script type="text/javascript">
           interpret(document.forms(0));
        </script>
