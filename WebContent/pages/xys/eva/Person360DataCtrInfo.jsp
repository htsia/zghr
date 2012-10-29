<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function showQryInfo(id,level) {
	    window.showModalDialog("/xys/eva/Person360DataInfo.jsf?objId="+id+"&level="+level, null, "dialogWidth:"+screen.width*0.8+"px;dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
	    return true;
	}
</script>
<x:saveState value="#{person_360AuditCtrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{person_360AuditCtrBB.initDataCtrObj}"></h:inputHidden>
     <c:verbatim>
    <br>
       <table height=90% width=100% align="center">
       <tr><td height=8>
       </c:verbatim>
    <h:panelGrid width="98%" columns="2">
    	  <h:panelGrid align="center">
		  <h:panelGroup>
                  <h:outputText value="������Ա�����:"></h:outputText>
                  <h:inputText value="#{person_360AuditCtrBB.queryValue}" styleClass="input"></h:inputText>
                  <h:commandButton value="��ѯ" action="#{person_360AuditCtrBB.queryDataCtr}" styleClass="button01"></h:commandButton>
              </h:panelGroup>
		  </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="��¼��:#{person_360AuditCtrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{person_360AuditCtrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{person_360AuditCtrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{person_360AuditCtrBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{person_360AuditCtrBB.first2}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{person_360AuditCtrBB.pre2}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{person_360AuditCtrBB.next2}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{person_360AuditCtrBB.last2}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
     <x:dataTable value="#{person_360AuditCtrBB.dataCtrObjList}" var="list" align="center" id="dateList" rowIndexVar="index"
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
            <c:facet name="header"><h:outputText value="ͬ��"/></c:facet>
             <h:commandLink value="#{list.weightVis}" onclick="showQryInfo('#{list.objId}','2');"></h:commandLink>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����ͬ��"/></c:facet>
            <h:commandLink value="#{list.weightOtherVis}" onclick="showQryInfo('#{list.objId}','6');"></h:commandLink>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�¼�"/></c:facet>
            <h:commandLink value="#{list.weightLower}" onclick="showQryInfo('#{list.objId}','3');"></h:commandLink>
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
