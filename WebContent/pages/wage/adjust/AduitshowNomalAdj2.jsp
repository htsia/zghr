<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{wage_AdjAduiteditBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{wage_AdjAduiteditBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{wage_AdjAduiteditBB.adjId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=100% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif"> н����� -> ������������</td>
        </tr>
        <tr height=30>
            <td>
		</c:verbatim>
		<h:panelGrid width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
    	 <h:outputText value="�������"/>
            <h:selectOneMenu id="status" value="#{wage_AdjAduiteditBB.adjustBo.auditResult2}">
                <c:selectItem itemValue="1" itemLabel="ͬ��"/>
                <c:selectItem itemValue="0" itemLabel="��ͬ��"/>
            </h:selectOneMenu>

            <h:outputText value="ԭ��"/>
            <h:inputTextarea value="#{wage_AdjAduiteditBB.adjustBo.auditOption2}" rows="3" cols="80"/>

            <h:outputText value="����"/>
            <h:commandButton styleClass="button01" value="����" action="#{wage_AdjAduiteditBB.audit2}"/>
    	
    	</h:panelGrid>
    <c:verbatim>
			</td>
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
                <h:outputText value="��¼��:#{wage_AdjAduiteditBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{wage_AdjAduiteditBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{wage_AdjAduiteditBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{wage_AdjAduiteditBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{wage_AdjAduiteditBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{wage_AdjAduiteditBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{wage_AdjAduiteditBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{wage_AdjAduiteditBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{wage_AdjAduiteditBB.adjItemList}" var="list" rowIndexVar="index" align="center" id="dateList"
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
            <c:facet name="header"><h:outputText value="��Χ�ֶ�����ֵ"/></c:facet>
            <h:outputText value="#{list.scopeValue}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ʱ���ֶ�����ֵ"/></c:facet>
            <h:outputText value="#{list.timeValue}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�½��"/></c:facet>
            <h:outputText value="#{list.resultNew}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�ɽ��"/></c:facet>
            <h:outputText value="#{list.resultOld}"/>
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
