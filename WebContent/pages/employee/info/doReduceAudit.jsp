<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
   
    <script type="text/javascript">
        function forView() {
            forViewPersonDetail(document.all("form1:personId").value);
        }
    </script>

    <x:saveState value="#{emp_personListBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{emp_personListBB.doReduceAudit}"/>
        <h:inputHidden id="code" value="#{emp_personListBB.code}"/>
        <h:inputHidden id="personId" value="#{emp_personListBB.reducebo.persID}"/>

        <c:verbatim>
        <table width="98%" align="center">
            <tr class="td_title">
                <td colspan=4 align="right">
         </c:verbatim>
                    <h:commandButton  styleClass="button01" value="��ϸ��Ϣ" onclick="forView();" type="button" />
                    <h:commandButton id="cancel" styleClass="button01" value="�˻�" onclick="return forsubmit(document.forms(0))" action="#{emp_personListBB.auditReduceNO}" />
                    <h:commandButton id="save" styleClass="button01" value="ͬ��" onclick="return forsubmit(document.forms(0))" action="#{emp_personListBB.auditReduceOK}" />
                    <h:commandButton type="button" styleClass="button01" value="�ر�" onclick="window.close()"/>
<c:verbatim>
                </td>
            </tr>

            <tr nowrap>
               <td class=td_form01><%=LanguageSupport.getResource("RYGL-2302","��λ����")%></td>
               <td class=td_form02 colspan=3>
</c:verbatim>
                    <h:outputText value="#{emp_personListBB.reducebo.orgName}"></h:outputText>
<c:verbatim>
               </td>
           </tr>

            <tr nowrap>
                <td class=td_form01><%=LanguageSupport.getResource("XTGL-1042","Ա�����")%></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.personbo.personCode}"></h:inputText>
<c:verbatim>
                </td>

                <td class=td_form01><%=LanguageSupport.getResource("MSG-0010","����")%></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.reducebo.persName}"></h:inputText>
<c:verbatim>
                </td>
           </tr>

             <tr nowrap>
                <td class=td_form01><%=LanguageSupport.getResource("MSG-0012","�Ա�")%></td>
                <td class=td_form02 >
 </c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.personbo.sex}"></h:inputText>
<c:verbatim>
                </td>

                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2308","�μӹ���ʱ��")%></td>
                <td class=td_form02 >
 </c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.personbo.workTime}"></h:inputText>
<c:verbatim>
                </td>
            </tr>

            <tr nowrap>
                <td class=td_form01><%=LanguageSupport.getResource("RYGL-1015","���֤��")%> </td>
                <td class=td_form02 >
 </c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.personbo.idCard}"></h:inputText>
<c:verbatim>
                </td>

                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2057","����")%></td>
                <td class=td_form02 >
 </c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.personbo.folk}"></h:inputText>
<c:verbatim>
                </td>
            </tr>

            <tr nowrap>
                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2307","��Աʱ��")%></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.reducebo.a016020}"></h:inputText>
<c:verbatim>
                </td>

                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2299","��Աԭ��")%></td>
                <td class=td_form02 >
 </c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.reducebo.a016010des}"></h:inputText>
<c:verbatim>
                </td>
            </tr>

            <tr nowrap>
               <td class=td_form01><%=LanguageSupport.getResource("RYGL-2306","ԭ���")%></td>
               <td class=td_form02>
</c:verbatim>
                    <h:inputText readonly="true" value="#{emp_personListBB.personbo.personType}"></h:inputText>
<c:verbatim>
               </td>
                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2298","��������")%></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.reducebo.a001054des}"></h:inputText>
<c:verbatim>
                </td>
           </tr>

            <tr nowrap>
               <td class=td_form01><%=LanguageSupport.getResource("RYGL-2305","ԭ״̬")%></td>
               <td class=td_form02 >
 </c:verbatim>
                    <h:inputText readonly="true" value="#{emp_personListBB.personbo.state}"></h:inputText>
<c:verbatim>
               </td>
                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2300","�����״̬")%></td>
                <td class=td_form02 >
 </c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.reducebo.a001725des}"></h:inputText>
<c:verbatim>
                </td>
           </tr>

    <tr nowrap>
       <td class=td_form01><%=LanguageSupport.getResource("RYGL-2304","����ʱ��")%></td>
       <td class=td_form02 >
 </c:verbatim>
            <h:inputText readonly="true" value="#{emp_personListBB.reducebo.applyDate}"></h:inputText>
<c:verbatim>
       </td>
        <td class=td_form01><%=LanguageSupport.getResource("RYGL-2303","������")%></td>
        <td class=td_form02 >
 </c:verbatim>
             <h:inputText readonly="true" value="#{emp_personListBB.reducebo.applyIDName}"></h:inputText>
<c:verbatim>
        </td>
   </tr>

    <tr nowrap>
       <td class=td_form01>ԭ��˵��</td>
       <td class=td_form02 colspan=3>
 </c:verbatim>
            <h:inputTextarea rows="3" cols="60" value="#{emp_personListBB.reducebo.auditOption}"></h:inputTextarea>
<c:verbatim>
       </td>
   </tr>

    <tr nowrap>
       <td class=td_form01>�ظ���Ϣ</td>
       <td class=td_form02 colspan=3>
 </c:verbatim>
            <h:selectBooleanCheckbox value="#{emp_personListBB.autoMessage}"></h:selectBooleanCheckbox>
            <h:outputText value="�Զ�����"></h:outputText>
<c:verbatim>
       </td>
   </tr>

        </table>
 </c:verbatim>
    </h:form>
