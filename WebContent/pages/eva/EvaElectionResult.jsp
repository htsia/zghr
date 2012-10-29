<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<f:verbatim>
    <script type="text/javascript">
        function showResult(setId){
        	window.showModalDialog("/eva/ShowElecionResultAnalyse.jsf?setId="+setId+"&planId="+document.all("form1:planId").value, "", "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px; status:0;resizable:yes");
   	     	return true;
        }
        
    </script>
</f:verbatim>
<x:saveState value="#{eva_selectioncaclBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_selectioncaclBB.pageInit}"/>
	<h:inputHidden id="planId" value="#{eva_selectioncaclBB.planId}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" ��Ч���� ->ͶƱ�������"/>
        </h:panelGroup>
    </h:panelGrid>
    <h:panelGrid columns="1" align="center" width="98%">
        <h:dataTable value="#{eva_selectioncaclBB.setItemList}" width="100%" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03"  >
        <h:column>
            <c:facet name="header"><h:outputText value="�������"/></c:facet>
            <h:outputText value="#{list.setName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="ͳ����"/></c:facet>
            <h:outputText value="#{list.gradeItemsDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="�Ƿ����"/></c:facet>
            <h:outputText value="#{list.caclDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="�Ƿ�ǰ���"/></c:facet>
            <h:outputText value="#{list.selDes}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
             <h:commandButton value="�������"  styleClass="button01" onclick="return showResult('#{list.setId}');" />
        </h:column>

    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>