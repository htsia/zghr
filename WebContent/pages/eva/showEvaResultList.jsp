<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

 <c:verbatim><link href="/css/style.css" rel="stylesheet" type="text/css"/></c:verbatim>  
 <script type="text/javascript">
 function showTable(changId){
		url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+changId+"&ORGUID=&Parameter=&Title=";
		window.open(url);
 }
 function showTatalTable(){
	 	changId=document.all("form1:planID").value;
	 	url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+changId+"&ORGUID=&Parameter=&Title=";
		window.open(url);
 }
 </script>
<x:saveState value="#{eva_resultAuditBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{eva_resultAuditBB.initResult}"></h:inputHidden>
    <h:inputHidden id="planID" value="#{eva_resultAuditBB.planID}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr>
       		<td height=8>
       		</c:verbatim>
       			<h:outputText value="�������ƣ�" rendered="#{eva_resultAuditBB.evaModel=='0'}"></h:outputText>
         		<h:inputText value="#{eva_resultAuditBB.queryValue}" styleClass="input" size="20" rendered="#{eva_resultAuditBB.evaModel=='0'}"></h:inputText>
         		<h:commandButton styleClass="button01"  value="��ѯ" action="#{eva_resultAuditBB.queryResult}" rendered="#{eva_resultAuditBB.evaModel=='0'}"></h:commandButton>
         		<h:outputText value=" "></h:outputText>
         		<h:outputText value="������:"></h:outputText>
				<h:selectOneMenu id="ReportID" style="width:190px">
               		<c:selectItems value="#{eva_resultAuditBB.regTableList}"/>
           	    </h:selectOneMenu>
           	    <h:commandButton value="��ʾ" styleClass="button01" onclick="return showTatalTable();"></h:commandButton>
           	    <h:outputText value="  "></h:outputText>
       		<c:verbatim>
       		</td>
       </tr>
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:outputText value="��¼��:#{eva_resultAuditBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{eva_resultAuditBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{eva_resultAuditBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{eva_resultAuditBB.mypage.currentPage}ҳ"></h:outputText>
            
	            <h:commandButton value="��ҳ" action="#{eva_resultAuditBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{eva_resultAuditBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{eva_resultAuditBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{eva_resultAuditBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
    </c:verbatim>
    <x:dataTable value="#{eva_resultAuditBB.objectScoreList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" rendered="#{eva_resultAuditBB.evaModel=='0'||eva_resultAuditBB.evaModel=='3'}">
     
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
            <h:outputText value="#{list.personNum}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>

        <h:column rendered="#{eva_resultAuditBB.evaModel=='0'}">
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="������"/>
        </h:column>
        <h:column rendered="#{eva_resultAuditBB.evaModel=='3'}">
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="ͶƱ"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="���÷�"/></c:facet>
            <h:outputText value="#{list.score}" rendered="#{eva_resultAuditBB.isVittual=='0'}"/>
            <h:outputText value="#{list.sumScore}" rendered="#{eva_resultAuditBB.isVittual=='1'}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���˵ȼ�"/></c:facet>
            <h:outputText value="#{list.gradeName}" rendered="#{eva_resultAuditBB.isVittual=='0'}"/>
            <h:outputText value="#{list.sumGrade}" rendered="#{eva_resultAuditBB.isVittual=='1'}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.sortId}" rendered="#{eva_resultAuditBB.isVittual=='0'}"/>
            <h:outputText value="#{list.sumSort}" rendered="#{eva_resultAuditBB.isVittual=='1'}"/>
        </h:column>
       	<h:column>
       		<c:facet name="header"><h:outputText value="����"/></c:facet>
       		 <h:commandButton value="��ʾ���" styleClass="button01" onclick="return showTable('#{list.objectID}');"/>
       	</h:column>
    </x:dataTable>

  
    <x:dataTable value="#{eva_resultAuditBB.jobEstimateScoreList}" var="list" align="center" id="dateList1"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" rendered="#{eva_resultAuditBB.evaModel=='1'}">
     
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
            <h:outputText value="#{list.personNum}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="��λְ�𿼺�"/>
        </h:column>

       <h:column>
            <c:facet name="header"><h:outputText value="���÷�"/></c:facet>
            <h:outputText value="#{list.score}" rendered="#{eva_resultAuditBB.isVittual=='0'}"/>
            <h:outputText value="#{list.sumScore}" rendered="#{eva_resultAuditBB.isVittual=='1'}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���˵ȼ�"/></c:facet>
            <h:outputText value="#{list.gradeName}" rendered="#{eva_resultAuditBB.isVittual=='0'}"/>
            <h:outputText value="#{list.sumGrade}" rendered="#{eva_resultAuditBB.isVittual=='1'}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.sortId}" rendered="#{eva_resultAuditBB.isVittual=='0'}"/>
            <h:outputText value="#{list.sumSort}" rendered="#{eva_resultAuditBB.isVittual=='1'}"/>
        </h:column>
       	<h:column>
       		<c:facet name="header"><h:outputText value="����"/></c:facet>
       		 <h:commandButton value="��ʾ���" styleClass="button01" onclick="return showTable('#{list.itemID}');"/>
       	</h:column>
       	
    </x:dataTable>
    
     <x:dataTable value="#{eva_resultAuditBB.masterList}" var="list" align="center" id="dateList2"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" rendered="#{eva_resultAuditBB.evaModel=='2'}">
     
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
            <h:outputText value="#{list.personNum}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
		 <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="���񿼺�"/>
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="���÷�"/></c:facet>
            <h:outputText value="#{list.score}" rendered="#{eva_resultAuditBB.isVittual=='0'}"/>
            <h:outputText value="#{list.sumScore}" rendered="#{eva_resultAuditBB.isVittual=='1'}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���˵ȼ�"/></c:facet>
            <h:outputText value="#{list.gradeName}" rendered="#{eva_resultAuditBB.isVittual=='0'}"/>
            <h:outputText value="#{list.sumGrade}" rendered="#{eva_resultAuditBB.isVittual=='1'}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.sortId}" rendered="#{eva_resultAuditBB.isVittual=='0'}"/>
            <h:outputText value="#{list.sumSort}" rendered="#{eva_resultAuditBB.isVittual=='1'}"/>
        </h:column>
       	<h:column>
       		<c:facet name="header"><h:outputText value="����"/></c:facet>
       		 <h:commandButton value="��ʾ���" styleClass="button01" onclick="return showTable('#{list.masterId}');"/>
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
