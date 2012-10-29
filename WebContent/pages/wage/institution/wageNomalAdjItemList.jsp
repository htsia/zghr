<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
	
    <script type="text/javascript">
        function showTable(changId){
        	url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+changId+"&ORGUID=&Parameter=&Title=";
        	window.open(url);
        }
    </script>

<x:saveState value="#{wage_instNomalAdjListBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{wage_instNomalAdjListBB.initAdjItemList}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{wage_instNomalAdjListBB.adjId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=100% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif"> н����� -> ��ȵ���н������</td>
        </tr>
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
              	
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
             	<h:commandButton value="����" action="#{wage_instNomalAdjListBB.caculate}" styleClass="button01" rendered="#{wage_instNomalAdjListBB.status=='0'}"></h:commandButton>
             	 <h:outputText value="  "></h:outputText>
	            <h:commandButton value="��Ч" action="#{wage_instNomalAdjListBB.shengxiao}" styleClass="button01" rendered="#{wage_instNomalAdjListBB.status!='3'}"></h:commandButton>
                <h:outputText value="��¼��:#{wage_instNomalAdjListBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{wage_instNomalAdjListBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{wage_instNomalAdjListBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{wage_instNomalAdjListBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{wage_instNomalAdjListBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{wage_instNomalAdjListBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{wage_instNomalAdjListBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{wage_instNomalAdjListBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
				<h:selectOneMenu id="ReportID" style="width:190px">
               		<c:selectItems value="#{wage_instNomalAdjListBB.regTableList}"/>
           	    </h:selectOneMenu>
                <h:commandButton styleClass="button01" type="button" value="��ʾ" onclick="showTable('#{wage_instNomalAdjListBB.adjId}');"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{wage_instNomalAdjListBB.adjItemList}" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
               <c:facet name="header"><h:outputText value="���"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.personId}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�ɽ��"/></c:facet>
            <h:outputText value="#{list.resultOld}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�½��"/></c:facet>
            <h:outputText value="#{list.resultNew}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ԭ��Ӧ����"/></c:facet>
            <h:outputText value="#{list.wageOld}"/>
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="�¶�Ӧ����"/></c:facet>
            <h:outputText value="#{list.wageNew}"/>
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="�ų�" onclick="return confirm('ȷ��Ҫ�ų���?');" action="#{wage_instNomalAdjListBB.delete}" styleClass="button01">
                  <x:updateActionListener property="#{wage_instNomalAdjListBB.itemId}" value="#{list.itemId}"/>
            </h:commandButton>
            <h:commandButton styleClass="button01" type="button" value="��ʾ" onclick="showTable('#{list.itemId}');"></h:commandButton>
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
