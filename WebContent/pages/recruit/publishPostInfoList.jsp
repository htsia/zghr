<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

 <c:verbatim><link href="/css/style.css" rel="stylesheet" type="text/css"/></c:verbatim>  
<x:saveState value="#{recu_resumeInfoBB}"></x:saveState>

<h:form id="form1">
    <h:inputHidden value="#{recu_resumeInfoBB.initPost}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{recu_resumeInfoBB.superId}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:outputText value="��¼��:#{recu_resumeInfoBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{recu_resumeInfoBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{recu_resumeInfoBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{recu_resumeInfoBB.mypage.currentPage}ҳ"></h:outputText>
            
	            <h:commandButton value="��ҳ" action="#{recu_resumeInfoBB.first1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{recu_resumeInfoBB.pre1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{recu_resumeInfoBB.next1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{recu_resumeInfoBB.last1}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
    </c:verbatim>

    <x:dataTable value="#{recu_resumeInfoBB.postList}" var="list" align="center" id="dateList1"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" rendered="#{recu_resumeInfoBB.planMethod=='1'}">
     
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="�ƻ�����"/></c:facet>
            <h:outputText value="#{list.planName}"/>
        </h:column>
        
        <h:column rendered="#{recu_resumeInfoBB.postMode=='0'}">
            <c:facet name="header"><h:outputText value="��λ"/></c:facet>
            <h:commandLink value="#{list.postName}" onclick="forViewPost('#{list.postId}')"></h:commandLink>
        </h:column>
        <h:column rendered="#{recu_resumeInfoBB.postMode=='1'}">
            <c:facet name="header"><h:outputText value="��λ���"/></c:facet>
            <h:outputText value="#{list.postType}"/>
        </h:column>
        <h:column rendered="#{recu_resumeInfoBB.postMode=='1'}">
            <c:facet name="header"><h:outputText value="רҵ"/></c:facet>
            <h:outputText value="#{list.majorType}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.needCount}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
            <h:outputText value="#{list.publishDate}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="������"/></c:facet>
            <h:outputText value="#{list.personName}"/>
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
