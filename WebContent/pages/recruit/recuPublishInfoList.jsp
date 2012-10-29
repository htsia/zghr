<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script>
   function planpost(planid)
   {
	   window.open("/recruit/publishPostInfoList.jsf?planId="+planid+"&planMethod="+"1", "", 'height=500px, width=600px, top=100,left=200, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
	    return true;
    }
</script>
<c:verbatim><base target="_self"></c:verbatim>
<x:saveState value="#{recu_outterRecruitBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{recu_outterRecruitBB.initPage}"/>
   
    <h:panelGrid columns="1" align="center" width="98%">
       <h:panelGrid align="right" columns="2">
          <h:panelGroup>
            	<h:selectBooleanCheckbox value="#{recu_outterRecruitBB.selectAll}" onclick="submit();" valueChangeListener="#{recu_outterRecruitBB.queryAll}"/>
				<h:outputText value="ȫ����ʾ"/>
          </h:panelGroup>
            <h:panelGroup>
                <h:outputText value="��¼��:#{recu_outterRecruitBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{recu_outterRecruitBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{recu_outterRecruitBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{recu_outterRecruitBB.mypage.currentPage}ҳ"></h:outputText>
	            <h:commandButton value="��ҳ" action="#{recu_outterRecruitBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{recu_outterRecruitBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{recu_outterRecruitBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{recu_outterRecruitBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>
        <h:dataTable value="#{recu_outterRecruitBB.planList}" width="100%" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03">
        <h:column>
            <c:facet name="header"><h:outputText value="�ƻ�����"/></c:facet>
            <h:outputText value="#{list.planName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="״̬"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="������"/></c:facet>
            <h:outputText value="#{list.createID}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
            <h:outputText value="#{list.createDate}"/>
        </h:column>
        
         <h:column>
            <c:facet name="header"><h:outputText value="������"/></c:facet>
            <h:outputText value="#{list.approveID}"/>
        </h:column>
        
         <h:column>
            <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
            <h:outputText value="#{list.approveDate}"/>
        </h:column>
  
            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:commandButton value="����"  styleClass="button01" action="#{recu_outterRecruitBB.publish}" rendered="#{list.planStatus=='2'}">
                    <x:updateActionListener property="#{recu_outterRecruitBB.planID}" value="#{list.planID}"/>
                </h:commandButton>   
                <h:commandButton value="�鿴��λ"  styleClass="button01" onclick="planpost('#{list.planID}','#{list.planName}');"/>       
            </h:column>
    </h:dataTable>
    
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>