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

function addComputerLevel(){
	window.showModalDialog("/recruit/recuA843Edit.jsf?personId="+document.all("form1:personcode").value, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
	return false;
}
function modifyComputerLevel(id){
	window.showModalDialog("/recruit/recuA843Edit.jsf?subId="+id, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
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
		<td align="right"><input type="button" value="���" class="button01" onclick="addComputerLevel()"/></td>
     </tr>
     <tr>
     	<td colspan="3">
     	</f:verbatim>
  <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="a843List"  align="center" border="0"  value="#{ResumeManageRecuitBB.a843List}"    var="list">

        <h:column>
            <c:facet name="header"><h:outputText value="��Ŀ" /></c:facet>
            <h:outputText value="#{list.a843703}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����" /></c:facet>
            <h:outputText value="#{list.a843704}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��֤ʱ��"/></c:facet>
            <h:outputText value="#{list.a843701}" />
        </h:column>
		<h:column>
            <c:facet name="header"><h:outputText value="��֤����"/></c:facet>
            <h:outputText value="#{list.a843702}" />
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="�޸�" onclick="return modifyComputerLevel('#{list.subId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');" action="#{ResumeManageRecuitBB.deleteComLevel}" styleClass="button01">
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

