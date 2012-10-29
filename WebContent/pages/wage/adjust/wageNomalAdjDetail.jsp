<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
	
    <script type="text/javascript">
         function addRule(){
             window.showModalDialog("/wage/adjust/adjRuleEdit.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:350px; dialogHeight:300px; status:0;resizable:yes");
             return true;
         }
        function modify(id){
            window.showModalDialog("/wage/adjust/adjRuleEdit.jsf?adjId="+id, "", "dialogWidth:350px; dialogHeight:300px; status:0;resizable:yes");
            return true;
        }
        function query(id){
            window.showModalDialog("/train/TrainClassAuditQuery.jsf?adjId="+id, null, "dialogWidth:500px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:no;");
            return true;
        }
    </script>

<x:saveState value="#{wage_AdjItemListBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{wage_AdjItemListBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{wage_AdjItemListBB.adjId}"></h:inputHidden>
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
             	<h:commandButton value="����" action="#{wage_AdjItemListBB.caculate}" styleClass="button01" rendered="#{wage_AdjItemListBB.status=='0'}"></h:commandButton>
             	 <h:outputText value="  "></h:outputText>
	            <h:commandButton value="����" action="#{wage_AdjItemListBB.baopi}" styleClass="button01" rendered="#{wage_AdjItemListBB.status=='0'||wage_AdjItemListBB.status=='4'}"></h:commandButton>
	             <h:outputText value="  "></h:outputText>
	            <h:commandButton value="��Ч" action="#{wage_AdjItemListBB.shengxiao}" styleClass="button01" rendered="#{wage_AdjItemListBB.status=='2'}"></h:commandButton>
                <h:outputText value="��¼��:#{wage_AdjItemListBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{wage_AdjItemListBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{wage_AdjItemListBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{wage_AdjItemListBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{wage_AdjItemListBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{wage_AdjItemListBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{wage_AdjItemListBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{wage_AdjItemListBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{wage_AdjItemListBB.adjItemList}" var="list" rowIndexVar="index" align="center" id="dateList"
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
            <c:facet name="header"><h:outputText value="������Χ"/></c:facet>
            <h:outputText value="#{list.scopeValue}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ʱ���ֶ�����ֵ"/></c:facet>
            <h:outputText value="#{list.timeValue}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="����ֶ�"/></c:facet>
            <h:outputText value="#{list.resultFiled}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�½��"/></c:facet>
            <h:outputText value="#{list.resultNew}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�ɽ��"/></c:facet>
            <h:outputText value="#{list.resultOld}"/>
        </h:column>
       
       <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="�ų�" onclick="return confirm('ȷ��Ҫ�ų���?');" action="#{wage_AdjItemListBB.delete}" styleClass="button01" rendered="#{list.isHaveAppring=='0'}">
                  <x:updateActionListener property="#{wage_AdjItemListBB.itemId}" value="#{list.itemId}"/>
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
