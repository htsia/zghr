<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
       function selItem(){
    	   var returnValue=window.showModalDialog("/xys/eva/SelGrade.jsf?planId="+document.all("form1:planId").value, null, "dialogWidth:"+screen.width*0.6+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:yes;");
    	   if(returnValue!=null&&!returnValue==""){
    		   document.all("form1:itemId").value=returnValue;
        	   return true;
    	   }
    	   return false;
       }
    </script>

<x:saveState value="#{xys_evaPlanCaclBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_evaPlanCaclBB.initEvaObj}"></h:inputHidden>
    <h:inputHidden id="planId" value="#{xys_evaPlanCaclBB.planId}"></h:inputHidden>
    <h:inputHidden id="itemId" value="#{xys_evaPlanCaclBB.itemId}"></h:inputHidden>
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
                  <h:commandButton value="��ѯ" action="#{xys_evaPlanCaclBB.queryEvaObj}" styleClass="button01"></h:commandButton>
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
           		<h:commandButton value="��ҳ" action="#{xys_evaPlanCaclBB.first4}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{xys_evaPlanCaclBB.pre4}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{xys_evaPlanCaclBB.next4}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{xys_evaPlanCaclBB.last4}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
     <x:dataTable value="#{xys_evaPlanCaclBB.evaObjList}" var="list" align="center" id="dateList" rowIndexVar="index"
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
            <c:facet name="header"><h:outputText value="KPI"/></c:facet>
            <h:outputText value="#{list.scoreKpi}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����̬��"/></c:facet>
            <h:outputText value="#{list.score360}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.scoreXspj}"/>
        </h:column>
              <h:column>
            <c:facet name="header"><h:outputText value="�ܷ�"/></c:facet>
            <h:outputText value="#{list.totalScore}"/>
        </h:column>
        
        
        <h:column>
            <c:facet name="header"><h:outputText value="����ƽ����"/></c:facet>
            <h:outputText value="#{list.scoreDeptAvg}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���ż�Ч��"/></c:facet>
            <h:outputText value="#{list.scoreDeptKpi}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���ż�Ч��ԭ"/></c:facet>
            <h:outputText value="#{list.scoreDeptKpiRecover}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="������÷�"/></c:facet>
            <h:outputText value="#{list.adjustTotalScore}"/>
        </h:column>
  
        
        <h:column rendered="#{xys_evaPlanCaclBB.showMode=='1' }">
            <c:facet name="header"><h:outputText value="�ȼ�"/></c:facet>
            <h:outputText value="#{list.natureGrade}"/>
        </h:column>
        <h:column rendered="#{xys_evaPlanCaclBB.showMode=='1' }">
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.natureSort}"/>
        </h:column>
        <h:column rendered="#{xys_evaPlanCaclBB.showMode=='2' }">
            <c:facet name="header"><h:outputText value="�ȼ�"/></c:facet>
            <h:outputText value="#{list.forceGrade}"/>
        </h:column>
        <h:column rendered="#{xys_evaPlanCaclBB.showMode=='2' }">
            <c:facet name="header"><h:outputText value="����������"/></c:facet>
            <h:outputText value="#{list.forceSort}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="�ȼ�����" action="#{xys_evaPlanCaclBB.chgNatureGrade}" onclick="return selItem();" styleClass="button01" rendered="#{xys_evaPlanCaclBB.showMode=='1'}">
                  <x:updateActionListener property="#{xys_evaPlanCaclBB.objId}" value="#{list.objId}"/>
            </h:commandButton>
            <h:commandButton value="�ȼ�����" action="#{xys_evaPlanCaclBB.chgForceGrade}" onclick="return selItem();" styleClass="button01" rendered="#{xys_evaPlanCaclBB.showMode=='2'}">
                  <x:updateActionListener property="#{xys_evaPlanCaclBB.objId}" value="#{list.objId}"/>
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
