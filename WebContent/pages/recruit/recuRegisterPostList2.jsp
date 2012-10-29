<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script>
   function doCheckIn(personId){
	window.showModalDialog("/recruit/checkInDetail.jsf?detailId="+personId, "", "dialogWidth:600px; dialogHeight:300px; status:0;resizable:yes");
    return true;
   }
   function doQuery(id){
	    window.showModalDialog("/recruit/resumeDetail2.jsf?personId="+id, "", "dialogWidth:"+screen.width*0.7+"px; dialogHeight:"+screen.height*0.7+"px; status:0;resizable:yes");
	    return true;
	}
</script>
 <c:verbatim><link href="/css/style.css" rel="stylesheet" type="text/css"/></c:verbatim>  
<x:saveState value="#{recu_registerManageBB}"></x:saveState>

<h:form id="form1">
    <h:inputHidden value="#{recu_registerManageBB.initPost}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{recu_registerManageBB.superId}"></h:inputHidden>
        <h:inputHidden id="sgecontent" value="#{recu_registerManageBB.signemailbo.sgContent}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">
          <h:panelGroup>
          	<h:selectBooleanCheckbox value="#{recu_registerManageBB.selectAll}" onclick="submit();" valueChangeListener="#{recu_registerManageBB.queryAll}" />
			<h:outputText value="δ������Ա"/>
			<h:outputText value=" "/>
            <h:selectOneMenu id="tem" style="width:200px"  onchange="submit();"  valueChangeListener="#{recu_registerManageBB.getInitInterViewPassPerson}">
					<c:selectItems value="#{recu_registerManageBB.recuOutterList}" />
				</h:selectOneMenu>   
            </h:panelGroup>
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
    </c:verbatim>  
    <x:dataTable value="#{recu_registerManageBB.outterInterViewPassPersonList2}" var="list" align="center" id="dateList1"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index">
     
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="ӦƸ��"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
		 <h:column rendered="#{recu_registerManageBB.postMode=='0'}">
            <c:facet name="header"><h:outputText value="��λ����"/></c:facet>
            <h:outputText value="#{list.postName}"/>
        </h:column>
        <h:column rendered="#{recu_registerManageBB.postMode=='1'}">
            <c:facet name="header"><h:outputText value="��λ����"/></c:facet>
            <h:outputText value="#{list.postType}"/>
        </h:column>
        <h:column rendered="#{recu_registerManageBB.postMode=='1'}">
            <c:facet name="header"><h:outputText value="רҵ"/></c:facet>
            <h:outputText value="#{list.majorType}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="״̬"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>
        <h:column>
			<c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="����"  styleClass="button01" onclick="return doCheckIn('#{list.detailId}');" rendered="#{list.status=='6'}"/>  
            <h:commandButton value="������Ϣ" styleClass="button01" onclick="return doQuery('#{list.personId}');"></h:commandButton>       
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
