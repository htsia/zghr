<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>

<f:verbatim>
    <script type="text/javascript">
        function doAudit1(id){
            window.showModalDialog("/wage/adjust/AduitshowNomalAdj1.jsf?adjId="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
        function doAudit2(id){
            window.showModalDialog("/wage/adjust/AduitshowNomalAdj2.jsf?adjId="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
        function doAudit3(id){
            window.showModalDialog("/wage/adjust/AduitshowNomalAdj3.jsf?adjId="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
        function doQuery(id){
        	 window.showModalDialog("/wage/adjust/showNomalAdjDetail.jsf?adjId="+id, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
        	  return true;
        }
    </script>
</f:verbatim>
<x:saveState value="#{wage_AdjAduitListBB}"/>
<h:form id="form1">
    <h:inputHidden value = "#{wage_AdjAduitListBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{wage_AdjAduitListBB.superId}"></h:inputHidden>
   	<h:inputHidden id="operate" value="#{wage_AdjAduitListBB.operate}"></h:inputHidden>
   <c:verbatim>
       <table height="98%" width="98%" align="center">
       <tr><td height="8"> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="��ǰ����:"></h:outputText>
                  <h:outputText value="#{wage_AdjAduitListBB.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
          	 <h:panelGroup>
            	<h:selectBooleanCheckbox value="#{wage_AdjAduitListBB.selectAll}" onclick="submit();" valueChangeListener="#{wage_AdjAduitListBB.queryAll}"/>
				<h:outputText value="ȫ����ʾ"/>
          	</h:panelGroup>
         	<h:panelGroup>
                <h:outputText value="��¼��:#{wage_AdjAduitListBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{wage_AdjAduitListBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{wage_AdjAduitListBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{wage_AdjAduitListBB.mypage.currentPage}ҳ"></h:outputText>
	            <h:commandButton value="��ҳ" action="#{wage_AdjAduitListBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{wage_AdjAduitListBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{wage_AdjAduitListBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{wage_AdjAduitListBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    
    <x:dataTable value="#{wage_AdjAduitListBB.adjustList}" width="100%" var="list"  rowIndexVar="index" align="center" id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03"  >
             <h:column>
	             <c:facet name="header"><h:outputText value="���"/></c:facet>
	             <h:outputText value="#{index+1}"/>
       		 </h:column>
       		
       		<h:column>
                <c:facet name="header"><h:outputText value="������λ"/></c:facet>
                <h:outputText value="#{list.orgName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
                <h:outputText value="#{list.adjCreateDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="������Ա"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="״̬"/></c:facet>
                <h:outputText value="#{list.statusDes}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�������"/></c:facet>
                <h:outputText value="#{list.aduitdes1}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�������"/></c:facet>
                <h:outputText value="#{list.aduitdes2}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�������"/></c:facet>
                <h:outputText value="#{list.aduitdes3}"/>
            </h:column>
        <h:column>
                 <c:facet name="header"><h:outputText value="����"/></c:facet>
                 <h:commandButton value="����" styleClass="button01"  onclick="return doAudit1('#{list.adjId}');" rendered="#{list.canAduit=='0690'&& wage_AdjAduitListBB.operate=='0690'}"></h:commandButton>
                 <h:commandButton value="����" styleClass="button01"  onclick="return doAudit2('#{list.adjId}');" rendered="#{list.canAduit=='0691'&& wage_AdjAduitListBB.operate=='0691'}"></h:commandButton>
                 <h:commandButton value="����" styleClass="button01"  onclick="return doAudit3('#{list.adjId}');" rendered="#{list.canAduit=='0692'&& wage_AdjAduitListBB.operate=='0692'}"></h:commandButton>
                 <h:commandButton value="�鿴" styleClass="button01" onclick="return doQuery('#{list.adjId}');"></h:commandButton>
                 <h:commandButton value="�鿴����" onclick="return showWorkFlowLogByLinkID('#{list.adjId}')" styleClass="button01"></h:commandButton>
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