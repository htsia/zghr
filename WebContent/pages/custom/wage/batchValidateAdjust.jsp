<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{wage_commonAdjustBB}"/>
<h:inputHidden value="#{wage_commonAdjustBB.initUserValidate}"/>
<h:form id="form1">
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8 align="right">
    </c:verbatim>
              <h:outputText escape="false" value="<strong>��Чʱ��</strong>"/>
              <h:inputText readonly="true" value="#{wage_commonAdjustBB.validate}"/>
              <h:commandButton value="��Ч" styleClass="button01" action="#{wage_commonAdjustBB.doOK}"/>
              <h:commandButton value="ȡ��" type="button" onclick="window.close();" styleClass="button01"/>
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td height="200">
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
    </c:verbatim>
    <x:dataTable value="#{wage_commonAdjustBB.wageUserList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" >
     
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
            <h:outputText value="#{list.personCode}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.name}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���ڲ���"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
    </x:dataTable>
	<c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
