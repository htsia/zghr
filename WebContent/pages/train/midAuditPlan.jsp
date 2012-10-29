<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>

<f:verbatim>
    <script type="text/javascript">
        function doAudit1(id){
            window.showModalDialog("/train/trainPlanAuditLevel1.jsf?planID="+id, null, "dialogWidth:630px; dialogHeight:700px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function doAudit2(id){
            window.showModalDialog("/train/trainPlanAuditLevel2.jsf?planID="+id, null, "dialogWidth:630px; dialogHeight:700px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function doAudit3(id){
            window.showModalDialog("/train/trainPlanAuditLevel3.jsf?planID="+id, null, "dialogWidth:630px; dialogHeight:700px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function doQuery(id){
        	 window.showModalDialog("/train/trainPlanAuditQuery.jsf?planID="+id, null, "dialogWidth:630px; dialogHeight:700px;center:center;resizable:yes;status:no;scroll:no;");
             return true;
        }
        function viewAtt(id){
       	 window.open('/pages/train/download.jsp?attachmentId='+id, "", 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+0.9*screen.width+',height='+0.9*screen.height+',left='+0.05*screen.width+', top='+0.05*screen.height);
       	}
        function trainClassManager(id){
            window.showModalDialog("/train/trainClassManager.jsf?planID="+id, "", "dialogWidth:"+screen.width*0.75+"px; dialogHeight:550px; status:0;resizable:yes");
            return true;
        }
    </script>
</f:verbatim>
<x:saveState value="#{midTrainPlanauditBB}"/>
<h:form id="form1">
    <h:inputHidden value = "#{midTrainPlanauditBB.initPlanAudit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{midTrainPlanauditBB.superId}"></h:inputHidden>
   
   <c:verbatim>
       <table height="98%" width="98%" align="center">
       <tr>
       	   <td class="td_title" height="8"><img src="/images/tips.gif"> ��ѵ���� ->  ��ѵ�ƻ�����</td>
       </tr>
       <tr><td height="8"> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">
          	 <h:panelGroup>
            	<h:selectBooleanCheckbox value="#{midTrainPlanauditBB.selectAll}" onclick="submit();" valueChangeListener="#{midTrainPlanauditBB.queryAll}"/>
				<h:outputText value="ȫ����ʾ"/>
          	</h:panelGroup>
         	<h:panelGroup>
                <h:outputText value="��¼��:#{midTrainPlanauditBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{midTrainPlanauditBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{midTrainPlanauditBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{midTrainPlanauditBB.mypage.currentPage}ҳ"></h:outputText>
	            <h:commandButton value="��ҳ" action="#{midTrainPlanauditBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{midTrainPlanauditBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{midTrainPlanauditBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{midTrainPlanauditBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    
    <x:dataTable value="#{midTrainPlanauditBB.planList}" width="100%" var="list"  rowIndexVar="index" align="center" id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03"  >
             <h:column>
	             <c:facet name="header"><h:outputText value="���"/></c:facet>
	             <h:outputText value="#{index+1}"/>
       		 </h:column>
       		
       		<h:column>
                <c:facet name="header"><h:outputText value="�ƻ�����"/></c:facet>
                <h:outputText value="#{list.planName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="״̬"/></c:facet>
                <h:outputText value="#{list.statusDes}"/>
            </h:column>
            
             <h:column>
                <c:facet name="header"><h:outputText value="�������"/></c:facet>
                <h:outputText value="#{list.auditContent}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�ƻ�ʱ��"/></c:facet>
                <h:outputText value="#{list.dateValue}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="Ԥ���ܶ�"/></c:facet>
                <h:outputText value="#{list.planBudget}"/>
            </h:column>
            
			 <h:column>
                <c:facet name="header"><h:outputText value="�ƻ�����"/></c:facet>
                <h:outputText value="#{list.createaOper}"/>
            </h:column>
            <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="��" rendered="#{list.isHaveAtt=='0'}"/>
            <h:commandLink value="����"  rendered="#{list.isHaveAtt=='1'}" onclick="viewAtt('#{list.planAtt}')">
   			</h:commandLink>
        </h:column>
        <h:column>
                 <c:facet name="header"><h:outputText value="����"/></c:facet>
                 <h:commandButton value="����" styleClass="button01" rendered="#{list.status=='1' && list.curNodeOperate=='1870'}" onclick="return doAudit1('#{list.planID}');"></h:commandButton>
                 <h:commandButton value="����" styleClass="button01" rendered="#{list.status=='1' && list.curNodeOperate=='1871'}" onclick="return doAudit2('#{list.planID}');"></h:commandButton>
                 <h:commandButton value="����" styleClass="button01" rendered="#{list.status=='1' && list.curNodeOperate=='1872'}" onclick="return doAudit3('#{list.planID}');"></h:commandButton>
                 <h:commandButton value="�鿴" styleClass="button01" onclick="return doQuery('#{list.planID}');"></h:commandButton>
                 <h:commandButton value="�鿴��ѵ��" onclick="return trainClassManager('#{list.planID}')" styleClass="button01"></h:commandButton>
                 <h:commandButton value="�鿴����" onclick="return showWorkFlowLogByLinkID('#{list.planID}')" styleClass="button01"></h:commandButton>
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