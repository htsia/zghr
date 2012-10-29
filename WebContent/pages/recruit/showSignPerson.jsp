<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<c:verbatim><link href="/css/style.css" rel="stylesheet" type="text/css"/></c:verbatim>  
<script type="text/javascript">
        function audit(id){
            window.showModalDialog("/recruit/auditInnerPerson.jsf?detailId="+id, "", "dialogWidth:800px; dialogHeight:600px; status:0;resizable:yes");
            return true;
        }
    </script>
<x:saveState value="#{innerRecuResultBB}"></x:saveState>

<h:form id="form1">
    <h:inputHidden value="#{innerRecuResultBB.initResult}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{innerRecuResultBB.superId}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:outputText value="��¼��:#{innerRecuResultBB.mypage2.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{innerRecuResultBB.mypage2.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{innerRecuResultBB.mypage2.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{innerRecuResultBB.mypage2.currentPage}ҳ"></h:outputText>
            
	            <h:commandButton value="��ҳ" action="#{innerRecuResultBB.first2}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{innerRecuResultBB.pre2}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{innerRecuResultBB.next2}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{innerRecuResultBB.last2}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
    </c:verbatim>
    <x:dataTable value="#{innerRecuResultBB.detialList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index">
     
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.pid}"/>
        </h:column>

       <h:column>
            <c:facet name="header"><h:outputText value="ӦƸ��λ"/></c:facet>
            <h:outputText value="#{list.postname}"/>
        </h:column>

       <h:column>
            <c:facet name="header"><h:outputText value="ӦƸʱ��"/></c:facet>
            <h:outputText value="#{list.applyDate}"/>
       </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ӦƸ���"/></c:facet>
            <h:outputText value="#{list.resultDes}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="����" onclick="return audit('#{list.detailid}')" styleClass="button01" rendered="#{list.isAudit=='0'}"></h:commandButton>
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
