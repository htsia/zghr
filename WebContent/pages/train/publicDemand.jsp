<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>

<f:verbatim>
    <script type="text/javascript">
    function add(){
        window.showModalDialog("/train/publicDemandEdit.jsf?new=true", "", "dialogWidth:600px; dialogHeight:500px; status:0;resizable:yes");
        return true;
    }
 
    </script>
</f:verbatim>
<x:saveState value="#{trainDemandBullMgrBB}"/>
<h:form id="form1">
    <h:inputHidden value = "#{trainDemandBullMgrBB.pageInit}"></h:inputHidden>
   <c:verbatim>
       <table height="98%" width="98%" align="center">
       <tr>
       	   <td class="td_title" height="8"><img src="/images/tips.gif"> ��ѵ���� ->  ��������</td>
       </tr>
       <tr><td height="8"> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">
         	<h:panelGroup>
                <h:outputText value="��¼��:#{trainDemandBullMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{trainDemandBullMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{trainDemandBullMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{trainDemandBullMgrBB.mypage.currentPage}ҳ"></h:outputText>
	            <h:commandButton value="��ҳ" action="#{trainDemandBullMgrBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{trainDemandBullMgrBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{trainDemandBullMgrBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{trainDemandBullMgrBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value=" "></h:outputText>
	            <h:commandButton value="����" onclick="return add()" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    
    <x:dataTable value="#{trainDemandBullMgrBB.bullList}" width="100%" var="list"  rowIndexVar="index" align="center" id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03"  >
             <h:column>
	             <c:facet name="header"><h:outputText value="���"/></c:facet>
	             <h:outputText value="#{index+1}"/>
       		 </h:column>
       		
       		<h:column>
                <c:facet name="header"><h:outputText value="��������"/></c:facet>
                <h:outputText value="#{list.demandType}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="������"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>
            
             <h:column>
                <c:facet name="header"><h:outputText value="���ʱ��"/></c:facet>
                <h:outputText value="#{list.createDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��ʼʱ��"/></c:facet>
                <h:outputText value="#{list.beginDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
                <h:outputText value="#{list.endDate}"/>
            </h:column>
            
			 <h:column>
                <c:facet name="header"><h:outputText value="״̬"/></c:facet>
                <h:outputText value="#{list.statusDes}"/>
            </h:column>
             <h:column>
                <c:facet name="header"><h:outputText value="�Ƿ񷢹���"/></c:facet>
                <h:outputText value="#{list.bulletinDes}"/>
            </h:column>
        	<h:column>
                 <c:facet name="header"><h:outputText value="����"/></c:facet>
                 <h:commandButton value="�༭" onclick="doEditBulletin('#{list.bulletin}')" styleClass="button01"></h:commandButton>
		         <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');" action="#{trainDemandBullMgrBB.delete}" styleClass="button01">
		             <x:updateActionListener property="#{trainDemandBullMgrBB.bullId}" value="#{list.bullId}"/>
		         </h:commandButton>
		         <h:commandButton value="����"  action="#{trainDemandBullMgrBB.finish}" styleClass="button01" rendered="#{list.status=='0'}">
		             <x:updateActionListener property="#{trainDemandBullMgrBB.bullId}" value="#{list.bullId}"/>
		         </h:commandButton>
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