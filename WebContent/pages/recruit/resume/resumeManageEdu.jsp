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

function addDegree(){
	window.showModalDialog("/recruit/recruitEducationEdit.jsf", null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
    return false;
}



function modify(id){
	window.showModalDialog("/recruit/recruitEducationEdit.jsf?subid="+id, null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
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
		<td align="right"><input type="button" value="添加" class="button01" onclick="addDegree()"/></td>
     </tr>
     <tr>
     	<td colspan="3">
     	</f:verbatim>
  <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="linkList"  align="center" border="0"  value="#{ResumeManageRecuitBB.educationList}"    var="list">
        
        <h:column>
            <c:facet name="header"><h:outputText value="学历" /></c:facet>
            <h:outputText value="#{list.a004005}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="专业类别" /></c:facet>
            <h:outputText value="#{list.a004010}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="专业名称" /></c:facet>
            <h:outputText value="#{list.a004012}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="毕业院校" /></c:facet>
            <h:outputText value="#{list.a004035}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="入学时间"/></c:facet>
            <h:outputText value="#{list.a004015}" />
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="毕业时间" /></c:facet>
            <h:outputText value="#{list.a004030}" />
        </h:column>
		<h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modify('#{list.subid}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{ResumeManageRecuitBB.delete}" styleClass="button01">
                  <x:updateActionListener property="#{ResumeManageRecuitBB.subid}" value="#{list.subid}"/>
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

