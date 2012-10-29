<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.ucc.IPersonUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
	function add(){
		window.showModalDialog("/wage/adjust/managerEdit.jsf?new=yes", null, "dialogWidth:300px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:no;");
		 document.all('form1:refresh').click();
	    return true;
	}
	function modify(id){
		window.showModalDialog("/wage/adjust/managerEdit.jsf?itemId="+id, null, "dialogWidth:300px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:no;");
		document.all('form1:refresh').click();
	    return true;
	}
</script>
<x:saveState value="#{wageReformJobSetBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden id="initEdit" value="#{wageReformJobSetBB.initManagerList}"></h:inputHidden>
<h:commandButton id="refresh" value="刷新" style="display:none;"  action="#{wageReformJobSetBB.refersh}"></h:commandButton>
<f:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title"><img src="/images/tips.gif">工资套改->套改岗位工资标准
        </td>
        <td class="td_title" align="right">
     </td>
    </tr>
</table>
<br>

<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
<tr>
                <td align="center" width="16%" class=activeTab><a href="SetJobStandard.jsf">管理岗位</a></td>
                <td align="center" width="16%" class=tab><a href="SetJobTitleStandard.jsf">专业技术岗位</a></td>
                <td align="center" width="16%" class=tab><a href="SetWorkStandard.jsf">工勤岗位</a></td>
</tr>
</table>
<br>
<table height=96% width=100%>
	<tr><td align="right" valign="top" height="10">
</f:verbatim>
	<h:commandButton value="增加" type="button"   onclick="add();" styleClass="button01" />
<f:verbatim>
&nbsp;&nbsp;&nbsp;	&nbsp;	&nbsp;	&nbsp;			
	</td></tr>
     <tr><td valign="top">
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <h:dataTable value="#{wageReformJobSetBB.managerList}" var="list" align="center"  id="dateList"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >
            <h:column>
                <c:facet name="header"><h:outputText value="源字段"/></c:facet>
                <h:outputText value="职务级别(A705718)"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="源值"/></c:facet>
                <h:outputText value="#{list.sourceCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="目的值"/></c:facet>
                <h:outputText value="#{list.desCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:panelGrid columns="5" align="center" cellspacing="2">
                	<h:commandButton value="修改" type="button"   onclick="modify('#{list.itemId}');" styleClass="button01" />
                	<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{wageReformJobSetBB.delete}" styleClass="button01">
                  <x:updateActionListener property="#{wageReformJobSetBB.itemId}" value="#{list.itemId}"/>
            </h:commandButton>
                </h:panelGrid>
            </h:column>
        </h:dataTable>
<f:verbatim>
        </div>
    </td></tr>
    </table>
</f:verbatim>

</h:form>
<script type="text/javascript">
setDataTableOver("form1:dateList");
</script>
