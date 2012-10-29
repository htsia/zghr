<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function showQryInfo(id) {
            window.showModalDialog("/xys/eva/PersonKpiScoreQryInfo.jsf?objId="+id, null, "dialogWidth:"+screen.width*0.6+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
    </script>

<x:saveState value="#{person_KpiAuditCtrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{person_KpiAuditCtrBB.initQry}"></h:inputHidden>
     <c:verbatim>
    <br>
       <table height=90% width=100% align="center">
       <tr><td height=8>
       </c:verbatim>
    <h:panelGrid width="98%" columns="2">
    	 <h:panelGrid align="center">
		  <h:panelGroup>
                  <h:outputText value="������Ա�����:"></h:outputText>
                  <h:inputText value="#{person_KpiAuditCtrBB.queryValue}" styleClass="input"></h:inputText>
                  <h:commandButton value="��ѯ" action="#{person_KpiAuditCtrBB.queryObj}" styleClass="button01"></h:commandButton>
              </h:panelGroup>
		  </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="��¼��:#{person_KpiAuditCtrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{person_KpiAuditCtrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{person_KpiAuditCtrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{person_KpiAuditCtrBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{person_KpiAuditCtrBB.first1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{person_KpiAuditCtrBB.pre1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{person_KpiAuditCtrBB.next1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{person_KpiAuditCtrBB.last1}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
     <x:dataTable value="#{person_KpiAuditCtrBB.objList}" var="list" align="center" id="dateList" rowIndexVar="index"
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
            <c:facet name="header"><h:outputText value="������"/></c:facet>
            <h:outputText value="#{list.allCount}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�������"/></c:facet>
            <h:outputText value="#{list.signCount}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="δ�������"/></c:facet>
            <h:outputText value="#{list.noSignCount}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="������" onclick="showQryInfo('#{list.objId}')" styleClass="button01" type="button"></h:commandButton>
            <h:commandButton value="ɾ��" action="#{person_KpiAuditCtrBB.deleteSbj}" onclick="return confirm('ȷʵҪɾ��ָ��������Ա��');"
                               styleClass="button01" >
                   <x:updateActionListener property="#{person_KpiAuditCtrBB.sbjId}" value="#{list.sbjId}"/>
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
