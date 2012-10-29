<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script>
   function showResult(planId){
	    window.showModalDialog("/recruit/resumePostList.jsf?planId="+planId, "", "dialogHeight="+screen.height*0.8+"px; dialogWidth="+screen.width*0.8+"px; top=90;left=180; toolbar=no; menubar=no; scrollbars=yes; resizable=no;location=no; status=no");
	    return true;
   }
   function auditIv(planId){
	   window.showModalDialog("/recruit/AuditIvResume.jsf?planId="+planId, "", "dialogHeight="+screen.height*0.8+"px; dialogWidth="+screen.width*0.8+"px; top=90;left=180; toolbar=no; menubar=no; scrollbars=yes; resizable=no;location=no; status=no");
	    return true;
   }
</script>


<x:saveState value="#{recu_resumeInfoBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{recu_resumeInfoBB.initPage}"/>
    <h:panelGrid columns="1" align="center" width="98%">
         <h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:outputText value="��¼��:#{recu_resumeInfoBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{recu_resumeInfoBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{recu_resumeInfoBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{recu_resumeInfoBB.mypage.currentPage}ҳ"></h:outputText>
            
	            <h:commandButton value="��ҳ" action="#{recu_resumeInfoBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{recu_resumeInfoBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{recu_resumeInfoBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{recu_resumeInfoBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
       
        <h:dataTable value="#{recu_resumeInfoBB.planList}" width="100%" var="list" align="center" id="dateList"
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
                <h:commandButton value="�������"  styleClass="button01" onclick="return showResult('#{list.planID}');">
                </h:commandButton>
                <h:commandButton value="֪ͨ������������"  styleClass="button01" onclick="return auditIv('#{list.planID}');" rendered="#{recu_resumeInfoBB.operApply}">
                </h:commandButton>
            </h:column>

    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>