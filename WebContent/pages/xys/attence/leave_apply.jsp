<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
       function add() {
            window.showModalDialog("/xys/attence/leave_edit.jsf?new=new", null, "dialogWidth:"+screen.width*0.5+"px;dialogHeight:"+screen.height*0.5+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
       function modify(id) {
           window.showModalDialog("/xys/attence/leave_edit.jsf?leaveId="+id, null, "dialogWidth:"+screen.width*0.5+"px;dialogHeight:"+screen.height*0.5+"px;center:center;resizable:no;status:no;scroll:yes;");
           return true;
       }
       function showFlow(id){
    	   window.showModalDialog("/xys/attence/leave_log.jsf?leaveId="+id, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
           //window.showModalDialog("/pages/xys/workflow/showProcessImg.jsf?processInstanceId="+id, null, "dialogWidth:"+screen.width*0.7+"px; dialogHeight:"+screen.height*0.7+"px;center:center;resizable:yes;status:no;scroll:yes;");
           return true;
       }
    </script>

<x:saveState value="#{xysLeaveApplyBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xysLeaveApplyBB.pageInit}"></h:inputHidden>
     <c:verbatim>
       <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
           <td class="td_title"><img src="/images/tips.gif">
                             ���ڹ��� ->�������
           </td>
           <td class="td_title" align="right">
                 </c:verbatim>
                 <h:outputText value="����"></h:outputText>
                 <h:selectBooleanCheckbox value="#{xysLeaveApplyBB.selApply}" onclick="submit();" valueChangeListener="#{xysLeaveApplyBB.qryApply}"></h:selectBooleanCheckbox>
                 <h:outputText value="  "></h:outputText>
                 <h:outputText value="����"></h:outputText>
                 <h:selectBooleanCheckbox value="#{xysLeaveApplyBB.selAuditing}" onclick="submit();" valueChangeListener="#{xysLeaveApplyBB.qryAuditing}"></h:selectBooleanCheckbox>
                 <h:outputText value="  "></h:outputText>
                 <h:outputText value="��׼"></h:outputText>
                 <h:selectBooleanCheckbox value="#{xysLeaveApplyBB.selAudited}" onclick="submit();" valueChangeListener="#{xysLeaveApplyBB.qryAudited}"></h:selectBooleanCheckbox>
                 <h:outputText value="  "></h:outputText>
                 <h:outputText value="�˻�"></h:outputText>
                 <h:selectBooleanCheckbox value="#{xysLeaveApplyBB.selRefuse}" onclick="submit();" valueChangeListener="#{xysLeaveApplyBB.qryRefuse}"></h:selectBooleanCheckbox>
                 <h:outputText value="  "></h:outputText>
                 <c:verbatim>
           </td>
        </tr>
    </table>
       <table height=100% width=100% align="center">
       <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="��¼��:#{xysLeaveApplyBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{xysLeaveApplyBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{xysLeaveApplyBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{xysLeaveApplyBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{xysLeaveApplyBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{xysLeaveApplyBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{xysLeaveApplyBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{xysLeaveApplyBB.last}" styleClass="button01"></h:commandButton>
                 <h:outputText value="  "></h:outputText>
                <h:commandButton value="����"  styleClass="button01" onclick="add()"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
      
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{xysLeaveApplyBB.leaveList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="������"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�������"/></c:facet>
            <h:selectOneMenu value="#{list.leaveType}" disabled="true">
            	<c:selectItems value="#{xysLeaveApplyBB.leaveTypeList}"/>
            </h:selectOneMenu>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ʼʱ��"/></c:facet>
            <h:outputText value="#{list.beginTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
            <h:outputText value="#{list.endTime}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="���ʱ��"/></c:facet>
            <h:outputText value="#{list.applyDays}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
            <h:outputText value="#{list.applyTiem}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ԭ��"/></c:facet>
            <h:outputText value="#{list.reason}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="״̬"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>
        
       
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="�޸�" onclick="return modify('#{list.leaveId}');" styleClass="button01" rendered="#{list.status=='0'||list.status=='3'}"></h:commandButton>
            <h:commandButton value="ɾ��" action="#{xysLeaveApplyBB.deleteLeave}" onclick="return confirm('ȷ��Ҫɾ��ѡ�����������');"
                             rendered="#{list.status=='0' || list.status=='3'}" styleClass="button01">
                  <x:updateActionListener property="#{xysLeaveApplyBB.leaveId}" value="#{list.leaveId}"/>
            </h:commandButton>
            <h:commandButton value="����" action="#{xysLeaveApplyBB.applyLeave}" 
                             rendered="#{list.status=='0'}" styleClass="button01">
                  <x:updateActionListener property="#{xysLeaveApplyBB.leaveId}" value="#{list.leaveId}"/>
            </h:commandButton>
            <h:commandButton value="���±���" action="#{xysLeaveApplyBB.applyLeaveAgin}" 
                             rendered="#{list.status=='3'}" styleClass="button01">
                  <x:updateActionListener property="#{xysLeaveApplyBB.leaveId}" value="#{list.leaveId}"/>
            </h:commandButton>
            <h:commandButton value="�鿴����" onclick="showFlow('#{list.leaveId}')" styleClass="button01" rendered="#{list.status!='0'}"></h:commandButton>
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
