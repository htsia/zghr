<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">

      function postMgr(id) {
        window.showModalDialog("/xys/eva/SetKpiKeyLib.jsf?postId="+id, null, "dialogWidth:"+screen.width*0.8+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
       }
    </script>

<x:saveState value="#{xys_kpiLibSetMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_kpiLibSetMgrBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{xys_kpiLibSetMgrBB.superId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="��ǰ����:"></h:outputText>
                  <h:outputText value="#{xys_kpiLibSetMgrBB.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="��¼��:#{xys_kpiLibSetMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{xys_kpiLibSetMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{xys_kpiLibSetMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{xys_kpiLibSetMgrBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{xys_kpiLibSetMgrBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{xys_kpiLibSetMgrBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{xys_kpiLibSetMgrBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{xys_kpiLibSetMgrBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{xys_kpiLibSetMgrBB.postList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="��λ����"/></c:facet>
            <h:outputText value="#{list.name}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.orgId}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�ϼ���λ"/></c:facet>
            <h:outputText value="#{list.superId}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��λ����"/></c:facet>
            <h:outputText value="#{list.postType}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��λ����"/></c:facet>
            <h:outputText value="#{list.postLevel}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="ָ���ά��" onclick="return postMgr('#{list.postId}')" styleClass="button01"></h:commandButton>
        </h:column>
    </h:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
