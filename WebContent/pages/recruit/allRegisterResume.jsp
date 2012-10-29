<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script>
   function doQuery(id){
       window.open("/recruit/resumeDetail2.jsf?personId="+id, "", "height="+screen.height*0.8+", width="+screen.width*0.8+", toolbar= no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no,top=50,left=100");
       return true;
   }
   function showTable(personId){
		url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+personId+"&ORGUID=&Parameter=&Title=";
		window.open(url);
	}
</script>


<x:saveState value="#{recu_resumeInfoBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{recu_resumeInfoBB.initAllPerson}"/>
    <h:panelGrid columns="1" align="center" width="98%">
         <h:panelGrid align="right" columns="2">
            <h:panelGroup>
            	<h:outputText value="���"/>
    	  		<h:selectOneMenu id="ReportID" style="width:190px">
               		<c:selectItems value="#{recu_resumeInfoBB.regTableList}"/>
           	    </h:selectOneMenu>
           	    <h:outputText value="  "></h:outputText>
                <h:outputText value="��¼��:#{recu_resumeInfoBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{recu_resumeInfoBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{recu_resumeInfoBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{recu_resumeInfoBB.mypage.currentPage}ҳ"></h:outputText>
            
	            <h:commandButton value="��ҳ" action="#{recu_resumeInfoBB.firstPage}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{recu_resumeInfoBB.prePage}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{recu_resumeInfoBB.nextPage}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{recu_resumeInfoBB.lastPage}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
       
        <x:dataTable value="#{recu_resumeInfoBB.resumeList}" width="100%" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03">
        <h:column>
						<c:facet name="header">
							<h:outputText value="���" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.a001001}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="�Ա�"/></c:facet>
            <h:outputText value="��" rendered="#{list.a001007=='01001'}"/>
            <h:outputText value="Ů" rendered="#{list.a001007=='01002'}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.a001011}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="���֤��"/></c:facet>
            <h:outputText value="#{list.a001077}"/>
        </h:column>
        
         <h:column>
            <c:facet name="header"><h:outputText value="״̬"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>
        <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:commandButton value="�������" styleClass="button01"
							onclick="return doQuery('#{list.id}');"></h:commandButton>
				<h:commandButton value="ɾ��" styleClass="button01"
							onclick="return confirm('ȷ��ɾ����?');"
							action="#{recu_resumeInfoBB.deletePerson}">
							<x:updateActionListener property="#{recu_resumeInfoBB.personId}"
								value="#{list.id}" />
						</h:commandButton>
			    <h:commandButton value="��ʾ���" styleClass="button01" onclick="return showTable('#{list.id}');"/>     
        </h:column>
    </x:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>