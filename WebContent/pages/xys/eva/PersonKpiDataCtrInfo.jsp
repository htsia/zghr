<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
        function showQryInfo(id,level) {
            window.showModalDialog("/xys/eva/PersonKpiDataInfo.jsf?objId="+id+"&level="+level, null, "dialogWidth:"+screen.width*0.6+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
    </script>
<x:saveState value="#{person_KpiAuditCtrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{person_KpiAuditCtrBB.initDataCtrObj}"></h:inputHidden>
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
                  <h:commandButton value="��ѯ" action="#{person_KpiAuditCtrBB.queryDataCtr}" styleClass="button01"></h:commandButton>
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
           		<h:commandButton value="��ҳ" action="#{person_KpiAuditCtrBB.first2}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{person_KpiAuditCtrBB.pre2}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{person_KpiAuditCtrBB.next2}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{person_KpiAuditCtrBB.last2}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
     <x:dataTable value="#{person_KpiAuditCtrBB.dataCtrObjList}" var="list" align="center" id="dateList" rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
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
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.deptId}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��λ����"/></c:facet>
            <h:outputText value="#{list.postId}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���ϼ�"/></c:facet>
            <h:commandLink value="#{list.weightPreLeader}" onclick="showQryInfo('#{list.objId}','4');"></h:commandLink>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ֱ���ϼ�"/></c:facet>
            <h:commandLink value="#{list.weightLeader}" onclick="showQryInfo('#{list.objId}','1');"></h:commandLink>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�����ϼ�"/></c:facet>
            <h:commandLink value="#{list.weightOtherLeader}" onclick="showQryInfo('#{list.objId}','5');"></h:commandLink>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="�������"/></c:facet>
            <h:selectOneMenu value="#{list.gradeType}" disabled="true">
            	<c:selectItem itemLabel="δ����" itemValue=""/>
            	<c:selectItem itemLabel="���ϲ�" itemValue="0"/>
                <c:selectItem itemLabel="�ϲ�" itemValue="1"/>
            </h:selectOneMenu>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�Ϸ���"/></c:facet>
            <h:outputText value="#{list.errorDes}" escape="false"/>
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
