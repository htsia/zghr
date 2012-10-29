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

function addLetter(){
	window.showModalDialog("/recruit/recruitLetterEdit.jsf", null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
    return false;
}
function modifyLetter(id){
	window.showModalDialog("/recruit/recruitLetterEdit.jsf?subid="+id, null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
    return false;
}
</script>
<x:saveState value="#{ResumeManageRecuitBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden id="initEdit" value="#{ResumeManageRecuitBB.initEdit}"></h:inputHidden>
<h:inputHidden id="personcode" value="#{ResumeManageRecuitBB.personcode}"></h:inputHidden>
<h:commandButton id="refresh" value="刷新" style="display:none;"  action="#{ResumeManageRecuitBB.query}"></h:commandButton>
<f:verbatim>
<br>
<br>
<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class=f04 width=75%></td>
         <td >
		</td>
		<td align="right"><input type="button" value="添加" class="button01" onclick="addLetter()"/></td>
     </tr>
     <tr>
     	<td colspan="3">
     	</f:verbatim>
  <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="linkList4"  align="center" border="0"  value="#{ResumeManageRecuitBB.letterList}"    var="list">

        <h:column>
            <c:facet name="header"><h:outputText value="专业技术资格" /></c:facet>
            <h:outputText value="#{list.a010005}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="专业" /></c:facet>
            <h:outputText value="#{list.a010706}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="专业技术级别" /></c:facet>
            <h:outputText value="#{list.a010006}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="取得时间" /></c:facet>
            <h:outputText value="#{list.a010015}"/>
        </h:column>

       <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modifyLetter('#{list.subId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{ResumeManageRecuitBB.delete4}" styleClass="button01">
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

