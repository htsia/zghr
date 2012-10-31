<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript" contenteditable="inherit">
   function forSel() {
	 	PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'');
	 	var type = document.all("form1:personType").value;
	 	if(type==null || type==""){
	 		return false;
	 	}
	 	return true;
   }
    function yearAttenceDay(){
        window.showModalDialog("/custom/attence/attPutoffMgrYearAttenceEdit.jsf", null, "dialogWidth:350px; dialogHeight:230px; status:0;resizable:yes");
        return true;
    }
</script>

<x:saveState value="#{attPutoffMgrBB}"></x:saveState>
<h:inputHidden value="#{attPutoffMgrBB.attYearInit}"></h:inputHidden>
<h:form id="form1">
	<h:inputHidden id="putoffsum" value="#{attPutoffMgrBB.putoffsum}"/>
	<h:inputHidden id="personType" value="#{attPutoffMgrBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{attPutoffMgrBB.personTypeValue}"/>
     <c:verbatim>
       <table height=100% width=100% align="center">
       <tr><td height=1>
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
	    <h:panelGrid align="left" columns="1">
	       <h:panelGroup>
	       	   <h:commandButton value="���������"
							onclick="yearAttenceDay()"
							styleClass="button01"></h:commandButton>
	       	   <h:outputText value="  "/>
	       	   <h:outputText value="��������"/>
               <h:inputText value="#{attPutoffMgrBB.nameStr}" styleClass="input" size="10"/> 
               <h:commandButton styleClass="button01" value="��Ա���" onclick="return forSel();" action="#{attPutoffMgrBB.doQuery}"/>
               <h:commandButton styleClass="button01" value="��ѯ" action="#{attPutoffMgrBB.attYearDoQuery}"/> 
	           <h:outputText value="��¼��:#{attPutoffMgrBB.mypage.totalRecord}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="ҳ��:#{attPutoffMgrBB.mypage.totalPage}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="ÿҳ��#{attPutoffMgrBB.mypage.pageSize}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="��ǰΪ��#{attPutoffMgrBB.mypage.currentPage}ҳ"></h:outputText>
		     		<h:commandButton value="��ҳ" action="#{attPutoffMgrBB.first}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="��ҳ" action="#{attPutoffMgrBB.pre}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="��ҳ" action="#{attPutoffMgrBB.next}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="βҳ" action="#{attPutoffMgrBB.last}" styleClass="button01"></h:commandButton>
		      </h:panelGroup>
	    </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
      
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{attPutoffMgrBB.yearList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
            <h:outputText value="#{list.id}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.name}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.secDeptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���ڲ���"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>             
        <h:column>
            <c:facet name="header"><h:outputText value="Ӧ��������"/></c:facet>
            <h:outputText value="#{list.shouldDays}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ʵ�ʳ�������"/></c:facet>
            <h:outputText value="#{list.realDays}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="������"/></c:facet>
            <h:outputText value="#{list.attRate}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���ڽ���"/></c:facet>
            <h:outputText value="#{list.attBonus}"/>
        </h:column>
    </h:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
