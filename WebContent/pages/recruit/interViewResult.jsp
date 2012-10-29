<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>

<f:verbatim>
    <script type="text/javascript">
        function doQuery(id) {
            window.open("/recruit/interViewPostPerson.jsf?planID="+id, null, "dialogWidth:900px; dialogHeight:450px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }

        function doManage(id) {
            window.open("/recruit/interViewManage.jsf?planID="+id, null, "dialogWidth:900px; dialogHeight:450px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function passer(id) {
            window.showModalDialog("/recruit/interViewPassPerson.jsf?planID="+id, null, "dialogWidth:900px; dialogHeight:450px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
    </script>
</f:verbatim>
<x:saveState value="#{recu_recuPersonBB}"/>
<h:form id="form1">
    <h:inputHidden value = "#{recu_recuPersonBB.initPage}"></h:inputHidden>
   <c:verbatim>
       <table height="98%" width="98%" align="center">
       <tr><td height="8"> 
    </c:verbatim>
    
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="��ǰ����:"></h:outputText>
                  <h:outputText value="#{recu_recuPersonBB.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:outputText value="��¼��:#{recu_recuPersonBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{recu_recuPersonBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{recu_recuPersonBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{recu_recuPersonBB.mypage.currentPage}ҳ"></h:outputText>
	            <h:commandButton value="��ҳ" action="#{recu_recuPersonBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{recu_recuPersonBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{recu_recuPersonBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{recu_recuPersonBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    
    <x:dataTable value="#{recu_recuPersonBB.planList}" width="100%" var="list" rowIndexVar="index" align="center" id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                     styleClass="table03" >
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
                 <c:facet name="header"><h:outputText value="����"/></c:facet>
                 <h:commandButton value="��������" styleClass="button01" onclick="return doQuery('#{list.planID}');"></h:commandButton>
                 <h:commandButton value="���Թ���" styleClass="button01" onclick="return doManage('#{list.planID}');"></h:commandButton>
            	 <h:commandButton value="��¼��Ա�ϱ�" styleClass="button01" onclick="return passer('#{list.planID}');"></h:commandButton>	
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