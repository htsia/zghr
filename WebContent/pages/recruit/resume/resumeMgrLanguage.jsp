<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.ucc.IPersonUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="javax.faces.context.FacesContext" %>
<%@ page import="com.hr319wg.common.ucc.impl.AttachmentUCC" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">

function addLanguage(){
	window.showModalDialog("/recruit/recruitLanguageEdit.jsf", null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
    return false;
}

function modifyLanguage(id){
	window.showModalDialog("/recruit/recruitLanguageEdit.jsf?subid="+id, null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
    return false;
}
</script>
<x:saveState value="#{ResumeManageRecuitBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden id="initEdit" value="#{ResumeManageRecuitBB.initEdit}"></h:inputHidden>
<h:inputHidden id="personcode" value="#{ResumeManageRecuitBB.personcode}"></h:inputHidden>
<h:commandButton id="refresh" value="ˢ��" style="display:none;"  action="#{ResumeManageRecuitBB.query}"></h:commandButton>
<f:verbatim>

<br>
<br>
    <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
        <tr nowrap>
            <td class=f04 width=75%></td>
             <td >
            </td>
            <td align="right"><input type="button" value="����" class="button01" onclick="addLanguage()"/></td>
         </tr>
         <tr>
             <td colspan="3">
             </f:verbatim>
      <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
            columnClasses="td_middle_left,td_middle_left" id="linkList3"  align="center" border="0"  value="#{ResumeManageRecuitBB.languageList}"    var="list">

            <h:column>
                <c:facet name="header"><h:outputText value="����" /></c:facet>
                <h:outputText value="#{list.a842701}" />
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="��˵�����̶�" /></c:facet>
                <h:outputText value="#{list.a842702}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��д�����̶�"/></c:facet>
                <h:outputText value="#{list.a842708}" />
            </h:column>

           <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:commandButton value="�޸�" onclick="return modifyLanguage('#{list.subId}')" styleClass="button01"></h:commandButton>
                <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');" action="#{ResumeManageRecuitBB.delete3}" styleClass="button01">
                      <x:updateActionListener property="#{ResumeManageRecuitBB.subid}" value="#{list.subId}"/>
                </h:commandButton>
            </h:column>
        </x:dataTable>
    <f:verbatim>

             </td>
         </tr>
    </table>

</f:verbatim>
</h:form>

<script type="text/javascript">
 interpret(document.forms(0));
</script>

