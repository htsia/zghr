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
<h:commandButton id="refresh" value="ˢ��" style="display:none;"  action="#{wageReformJobSetBB.refersh}"></h:commandButton>
<f:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title"><img src="/images/tips.gif">�����׸�->�׸ĸ�λ���ʱ�׼
        </td>
        <td class="td_title" align="right">
     </td>
    </tr>
</table>
<br>

<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
<tr>
                <td align="center" width="16%" class=activeTab><a href="SetJobStandard.jsf">�����λ</a></td>
                <td align="center" width="16%" class=tab><a href="SetJobTitleStandard.jsf">רҵ������λ</a></td>
                <td align="center" width="16%" class=tab><a href="SetWorkStandard.jsf">���ڸ�λ</a></td>
</tr>
</table>
<br>
<table height=96% width=100%>
	<tr><td align="right" valign="top" height="10">
</f:verbatim>
	<h:commandButton value="����" type="button"   onclick="add();" styleClass="button01" />
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
                <c:facet name="header"><h:outputText value="Դ�ֶ�"/></c:facet>
                <h:outputText value="ְ�񼶱�(A705718)"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="Դֵ"/></c:facet>
                <h:outputText value="#{list.sourceCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="Ŀ��ֵ"/></c:facet>
                <h:outputText value="#{list.desCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:panelGrid columns="5" align="center" cellspacing="2">
                	<h:commandButton value="�޸�" type="button"   onclick="modify('#{list.itemId}');" styleClass="button01" />
                	<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');" action="#{wageReformJobSetBB.delete}" styleClass="button01">
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
