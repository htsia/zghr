<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function showWF(){
            var ID=getFirstSelectValue(form1.chk);
            if (ID!=null && ID!=""){
               showWorkFlowLogByLinkID(ID);
            }
            else{
                alert("��ѡ����Ա!");
            }
            return false;
     }

    function doRemove(){
        if (!checkMutilSelect(form1.chk)) {
            alert("��ѡ����Ա!");
            return false;
        }
        document.all("form1:ids").value=getAllSelectValue(form1.chk,"|");
    }
    function doViewPerson(){
        var ID=getFirstSelectValue(form1.chk);
        if (ID!=null && ID!=""){
           forModifyPersonDetail(ID.split(",")[0]);
        }
        else{
            alert("��ѡ����Ա!");
        }
        return false;
    }
</script>

  <x:saveState value="#{wage_exitPersonSetBB}"/>
  <h:form id="form1">
  <h:inputHidden value="#{wage_exitPersonSetBB.listExitPerson}"/>

  <f:verbatim>
  <table width="98%" height="98%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
        <td class="td_title" height=8>
   </f:verbatim>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="#{wage_exitPersonSetBB.unitName}��Ա�����仯���"/>
<f:verbatim>
        </td>
        
        <td class="td_title" align="right"  height=8>
</f:verbatim>
            <h:outputText value="�����ѯʱ��"></h:outputText>
            <h:inputText  id="inputDate" readonly="true" value="#{wage_exitPersonSetBB.inputDate}"></h:inputText>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:inputDate')"/>
            <h:commandButton value="�鿴��Ա��Ϣ" styleClass="button01" type="button" onclick="doViewPerson();"></h:commandButton>
            <h:commandButton value="��ѯ" styleClass="button01" action="#{wage_exitPersonSetBB.queryExit}"></h:commandButton>
            <h:inputHidden id="ids" value="#{wage_exitPersonSetBB.ids}"/>
            <h:commandButton value="�Ƴ�����" styleClass="button01" action="#{wage_exitPersonSetBB.removeFromSet}" onclick="doRemove();"></h:commandButton>
            <h:commandButton value="����" styleClass="button01" type="button" onclick="doExport();"></h:commandButton>
<f:verbatim>
        </td>
    </tr>
     <tr><td colspan="2" height=8></td></tr>
     <tr><td colspan="2">
         <jsp:include page="/pages/common/activepage/ActiveList.jsp">
             <jsp:param name="hasOperSign" value="true"/>
             <jsp:param name="operSignType" value="checkbox"/>
             <jsp:param name="hasEdit" value="false"/>
             <jsp:param name="isEditList" value="false"/>
             <jsp:param name="isCheckRight" value="false"/>
         </jsp:include>
     </td>
     </tr>
  </table>
</f:verbatim>       
</h:form>
