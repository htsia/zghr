<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function modify(id){
        window.showModalDialog("/wage/adjust/CommonWageItemEdit.jsf?adjustID="+id, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
</script>
<x:saveState value="#{wage_commonAdjustBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{wage_commonAdjustBB.initDetail}"></h:inputHidden>
    <h:inputHidden value="#{wage_commonAdjustBB.itemID}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>

    <c:verbatim>
	  </td></tr>
	  
	  <tr><td height="200">
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
    </c:verbatim>
    <x:dataTable value="#{wage_commonAdjustBB.wageItemList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" >
     
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="ָ����"/></c:facet>
            <h:outputText value="#{list.fieldName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="ԭֵ"/></c:facet>
            <h:outputText value="#{list.oldValue}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ֵ"/></c:facet>
            <h:outputText value="#{list.newValue}"/>
        </h:column>

        <h:column>
            <c:facet name="header">
            <f:verbatim>
                <%=LanguageSupport.getResource("YXGL-1026", "����")%>
            </f:verbatim>
            </c:facet>
        <h:commandButton value="¼����ֵ"
            onclick="return modify('#{list.adjustID}')" styleClass="button01" action="#{wage_commonAdjustBB.refreshDetail}"></h:commandButton>
        <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');"
            action="#{wage_commonAdjustBB.delete}" styleClass="button01">
            <x:updateActionListener
                property="#{wage_commonAdjustBB.adjustId}"
                value="#{list.adjustID}" />
        </h:commandButton>
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
