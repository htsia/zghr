<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
  
    <script type="text/javascript">
        function checkInput(){
            if (document.all('form1:fieldID').value=='-1'){
                alert("��ѡ���޸���Ŀ");
                return false;
            }
            return true;
        }
    </script>    

    <x:saveState value="#{org_changeInfoBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{org_changeInfoBB.pageInit}"/>
        <h:inputHidden value="#{org_changeInfoBB.orguid}"/>
<c:verbatim>
        <table width="98%" align="center">
            <tr nowrap>
                <td class="td_form01 td_form_required" width="120">
                <%=LanguageSupport.getResource("JGGL-1099","�޸���Ϣ��")%> </td>
                <td class=td_form02>
</c:verbatim>
                    <h:selectOneMenu id="fieldID" value="#{org_changeInfoBB.modi.fieldID}">
                        <c:selectItems value="#{org_changeInfoBB.fieldList}"></c:selectItems>
                    </h:selectOneMenu>
                    <h:commandButton id="modi" styleClass="button01" value="��ʼ�޸�" onclick="return checkInput();" action="#{org_changeInfoBB.changeField}" />
                    <h:commandButton type="button" styleClass="button01" value="�ر�" onclick="window.close()"/>
<c:verbatim>
                </td>
            </tr>

            <tr>
                <td class="td_form01 td_form_required" width="120">
                <%=LanguageSupport.getResource("JGGL-1100","ԭֵ")%>
                </td>
                <td class=td_form02>
 </c:verbatim>
                    <h:inputText styleClass="input" id="A016020"
                                 readonly="true" value="#{org_changeInfoBB.modi.oldValue}" alt="��Աʱ��|0|d6|50||"/>
<c:verbatim>
                </td>
            </tr>

            <tr nowrap>
               <td class=td_form01><%=LanguageSupport.getResource("JGGL-1101","��ֵ")%></td>
               <td class=td_form02>
 </c:verbatim>
                    <h:inputText value="#{org_changeInfoBB.modi.newValue}" ></h:inputText>
<c:verbatim>
               </td>
           </tr>

            <tr class="td_title">
                <td colspan=2 align="right">
</c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="����" onclick="return checkInput();" rendered="#{org_changeInfoBB.modistate}" action="#{org_changeInfoBB.Save}" />
<c:verbatim>
                </td>
            </tr>

        </table>
</c:verbatim>
    </h:form>
