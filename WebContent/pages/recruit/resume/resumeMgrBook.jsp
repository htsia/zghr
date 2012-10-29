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

function viewAtt(id,type){
 	 window.open('/pages/recruit/showAttFile.jsp?attachmentId='+id+'&type='+type, "", 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+0.9*screen.width+',height='+0.9*screen.height+',left='+0.05*screen.width+', top='+0.05*screen.height);
}

function addMater(){
	window.showModalDialog("/recruit/personMaterEdit.jsf?personId="+document.all("form1:personcode").value, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
	document.all('form1:refresh').click();
	return false;
}
function modifyMater(id){
	window.showModalDialog("/recruit/personMaterEdit.jsf?materId="+id, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
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
		<td align="right"><input type="button" value="添加" class="button01" onclick="addMater()"/></td>
     </tr>
     <tr>
     	<td colspan="3">
     	</f:verbatim>
  <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle" id="linkList5"  align="center" border="0"  value="#{ResumeManageRecuitBB.materList}"    var="list">

        <h:column>
            <c:facet name="header"><h:outputText value="标题" /></c:facet>
            <h:outputText value="#{list.title}"></h:outputText>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="附件" /></c:facet>
            <h:commandLink value="查看"   onclick="viewAtt('#{list.attId}','#{list.type}')" rendered="#{list.isHaveFile=='1'}">
            </h:commandLink>
            <h:outputText value="无附件" rendered="#{list.isHaveFile=='0'}"></h:outputText>
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modifyMater('#{list.materId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{ResumeManageRecuitBB.deleteMater}" styleClass="button01">
                  <x:updateActionListener property="#{ResumeManageRecuitBB.materId}" value="#{list.materId}"/>
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

