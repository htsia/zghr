<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
       
    </script>

<x:saveState value="#{xys_evaPlanCaclBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_evaPlanCaclBB.initPers360}"></h:inputHidden>
     <c:verbatim>
    <br>
       <table height=90% width=100% align="center">
       <tr><td height=8>
       </c:verbatim>
    <h:panelGrid width="98%" columns="2">
    	  <h:panelGrid align="center">
		  <h:panelGroup>
                  <h:outputText value="������Ա�����:"></h:outputText>
                  <h:inputText value="#{xys_evaPlanCaclBB.queryValue}" styleClass="input"></h:inputText>
                  <h:commandButton value="��ѯ" action="#{xys_evaPlanCaclBB.queryPerson360}" styleClass="button01"></h:commandButton>
              </h:panelGroup>
		  </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="��¼��:#{xys_evaPlanCaclBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{xys_evaPlanCaclBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{xys_evaPlanCaclBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{xys_evaPlanCaclBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{xys_evaPlanCaclBB.first2}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{xys_evaPlanCaclBB.pre2}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{xys_evaPlanCaclBB.next2}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{xys_evaPlanCaclBB.last2}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
     <x:dataTable value="#{xys_evaPlanCaclBB.pers360ObjList}" var="list" align="center" id="dateList" rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��λ����"/></c:facet>
            <h:outputText value="#{list.postName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���ϼ�"/></c:facet>
            <h:outputText value="#{list.scorePreLeader}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ֱ���ϼ�"/></c:facet>
            <h:outputText value="#{list.scoreLeader}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�����ϼ�"/></c:facet>
            <h:outputText value="#{list.scoreOtherLeader}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ͬ��"/></c:facet>
            <h:outputText value="#{list.scoreVis}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����ͬ��"/></c:facet>
            <h:outputText value="#{list.scoreOtherVis}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�¼�"/></c:facet>
            <h:outputText value="#{list.scoreLower}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�÷�"/></c:facet>
            <h:outputText value="#{list.score}" escape="false"/>
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
