<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<script type="text/javascript">
    function doCheck(){
        if (document.all("form1:wageUnit").value==""){
            alert("��ѡ��н�굥λ!");
            return false;
        }
        return true;
    }
</script>
    <x:saveState value="#{emp_PersonDismissBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{emp_PersonDismissBB.receiveWageEdit}"/>
       <c:verbatim>
        <table width="98%" align="center">
            <tr class="td_title">
                <td colspan=2 align="right">
</c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="����" onclick="return doCheck();" action="#{emp_PersonDismissBB.saveReceiveWage}" />
                    <h:commandButton type="button" styleClass="button01" value="�ر�" onclick="window.close()"/>
<c:verbatim>
                </td>
            </tr>
            <tr nowrap>
               <td class=td_form01>  <%=LanguageSupport.getResource("MSG-0010","����") %></td>
               <td class=td_form02>
</c:verbatim>
                    <h:inputText readonly="true" value="#{emp_PersonDismissBB.changevo.name}"></h:inputText>
<c:verbatim>
               </td>
           </tr>
            <tr nowrap>
               <td class=td_form01>  <%=LanguageSupport.getResource("RYGL-2155","������λ") %></td>
               <td class=td_form02>
</c:verbatim>
                    <h:inputText readonly="true" value="#{emp_PersonDismissBB.changevo.fromOrgName}"></h:inputText>
<c:verbatim>
               </td>
           </tr>

    <tr nowrap>
       <td class="td_form01">н���ϵ</td>
       <td class=td_form02 >
   </c:verbatim>
           <h:inputHidden id="wageUnit" value="#{emp_PersonDismissBB.wageUnit}"></h:inputHidden>
           <h:inputText id="wageUnitName" readonly="true"></h:inputText>
   <c:verbatim>
          <input type="button" class="button_org" onclick="fPopUpWageUnitDlg2('form1:wageUnit','form1:wageUnitName','true')">
       </td>

   </tr>

       <tr nowrap>
          <td class="td_form01">��������</td>
          <td class=td_form02 >
      </c:verbatim>
              <h:selectOneMenu value="#{emp_PersonDismissBB.wageset}">
                  <c:selectItems value="#{emp_PersonDismissBB.wagesets}"></c:selectItems>
              </h:selectOneMenu>
      <c:verbatim>
          </td>
      </tr>

        </table>
</c:verbatim>
    </h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
</script>
