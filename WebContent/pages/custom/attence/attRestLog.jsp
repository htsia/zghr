<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<x:saveState value="#{attRestApplyBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{attRestApplyBB.initLog}"></h:inputHidden>
     <c:verbatim>
       <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
           <td class="td_title"><img src="/images/tips.gif">
                             ���ڹ��� ->�鿴��������
           </td>
           
        </tr>
    </table>
       <table height=100% width=100% align="center">
       <tr><td height="60%">
       <%
       	   String distanceId=(String)session.getAttribute("distanceId");
       %>
        <iframe id="main" frameborder="0" width=100% height=100% src="/pages/xys/workflow/showProcessImg.jsp?processInstanceId=<%=distanceId%>"></iframe>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
	<h:outputText value="��ǰ�������б�"/>
    <x:dataTable value="#{attRestApplyBB.currApproverList}" var="list1" align="center" id="currApproveList" rowIndexVar="index1"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index1+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list1.name}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
            <h:outputText value="#{list1.personSeq}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��Ա���"/></c:facet>
            <h:outputText value="#{list1.personType}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list1.secondDeptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���ڲ���"/></c:facet>
            <h:outputText value="#{list1.deptName}"/>
        </h:column>
    </x:dataTable>
    <c:verbatim><br/></c:verbatim>
    <h:outputText value="������¼�б�"/>
    <x:dataTable value="#{attRestApplyBB.logList}" var="list" align="center" id="dateList" rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="������"/></c:facet>
            <h:outputText value="#{list.personId}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
            <h:outputText value="#{list.auditTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�������"/></c:facet>
            <h:selectOneMenu value="#{list.auditResult}" disabled="true">
            	<c:selectItem itemLabel="ͨ��" itemValue="1"/>
		     	<c:selectItem itemLabel="�˻�" itemValue="0"/>
            </h:selectOneMenu>
        </h:column>
		<h:column>
            <c:facet name="header"><h:outputText value="�������"/></c:facet>
            <h:outputText value="#{list.auditxplan}"/>
        </h:column>
    </x:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
