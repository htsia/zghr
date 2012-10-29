<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
	
    <script type="text/javascript">
         function addRule(){
             window.showModalDialog("/wage/adjust/adjRuleEdit.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:400px; dialogHeight:400px; status:0;resizable:yes");
             return true;
         }
        function modify(id){
            window.showModalDialog("/wage/adjust/adjRuleEdit.jsf?adjId="+id, "", "dialogWidth:400px; dialogHeight:400px; status:0;resizable:yes");
            return true;
        }
        function query(id){
            window.showModalDialog("/train/TrainClassAuditQuery.jsf?adjId="+id, null, "dialogWidth:500px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:no;");
            return true;
        }
    </script>

<x:saveState value="#{wage_nomalAdjListBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{wage_nomalAdjListBB.initRuleList}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{wage_nomalAdjListBB.superId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=100% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif"> н����� -> ��������</td>
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
                <h:outputText value="��¼��:#{wage_nomalAdjListBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{wage_nomalAdjListBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{wage_nomalAdjListBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{wage_nomalAdjListBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{wage_nomalAdjListBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{wage_nomalAdjListBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{wage_nomalAdjListBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{wage_nomalAdjListBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="����" onclick="return addRule();" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{wage_nomalAdjListBB.adjustRultList}" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
               <c:facet name="header"><h:outputText value="���"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="������λ"/></c:facet>
            <h:outputText value="#{list.adjCreateOrg}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���÷�Χ"/></c:facet>
            <h:outputText value="#{list.adjOrgId}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="������Χ1"/></c:facet>
            <h:outputText value="#{list.scopeValue}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="������Χ2"/></c:facet>
            <h:outputText value="#{list.scopeValue2}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
            <h:outputText value="#{list.timeField}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����ʱ�����"/></c:facet>
            <h:outputText value="#{list.timeValueLow}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����ʱ�����"/></c:facet>
            <h:outputText value="#{list.timeValueHigh}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�������"/></c:facet>
            <h:outputText value="#{list.resultValue}"/>
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="�޸�" onclick="return modify('#{list.adjId}')" styleClass="button01" rendered="#{list.ownOrg=='1'}"></h:commandButton>
            <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');" action="#{wage_nomalAdjListBB.delete}" styleClass="button01" rendered="#{list.ownOrg=='1'}">
                  <x:updateActionListener property="#{wage_nomalAdjListBB.adjId}" value="#{list.adjId}"/>
            </h:commandButton>
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
