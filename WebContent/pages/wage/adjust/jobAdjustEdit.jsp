<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
</script>
<c:verbatim><link href="/css/style.css" rel="stylesheet" type="text/css"/></c:verbatim>  
<x:saveState value="#{jobAjustChangeBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{jobAjustChangeBB.pageInit1}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">
            <h:panelGroup>
            	<h:outputText value="�ֶμ��㹤�ʣ�"></h:outputText>
                <h:selectOneMenu value="#{jobAjustChangeBB.isPartWage}">
                    <c:selectItem itemLabel="��" itemValue="0"></c:selectItem>
                    <c:selectItem itemLabel="��" itemValue="1"></c:selectItem>
                </h:selectOneMenu>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td height="200">
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
    </c:verbatim>
    <x:dataTable value="#{jobAjustChangeBB.wageItemList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" >
     
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="ָ����"/></c:facet>
            <h:outputText value="#{list.fieldId}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="ָ������"/></c:facet>
            <h:outputText value="#{list.fieldDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="ԭֵ"/></c:facet>
            <h:outputText value="#{list.oldValue}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ֵ"/></c:facet>
            <h:outputText value="#{list.newValue}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="״̬"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��Чʱ��"/></c:facet>
            <h:outputText value="#{list.updateDate}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.adjCause}"/>
        </h:column>
    </x:dataTable>

	<c:verbatim>
	</div>
	</td></tr>
	<tr>
		<td align="right">
	</c:verbatim>
		<h:commandButton value="��Ч" styleClass="button01" action="#{jobAjustChangeBB.shengxiao}"></h:commandButton>
	<c:verbatim>	
		&nbsp;&nbsp;&nbsp;</td>
	</tr>
	</table>
	</c:verbatim>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
