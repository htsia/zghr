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
                             考勤管理 ->请假申请
           </td>
           <td class="td_title" align="right">
                 </c:verbatim>
                 <h:outputText value="申请"></h:outputText>
                 <h:selectBooleanCheckbox value="#{xysLeaveApplyBB.selApply}" onclick="submit();" valueChangeListener="#{xysLeaveApplyBB.qryApply}"></h:selectBooleanCheckbox>
                 <h:outputText value="  "></h:outputText>
                 <h:outputText value="报批"></h:outputText>
                 <h:selectBooleanCheckbox value="#{xysLeaveApplyBB.selAuditing}" onclick="submit();" valueChangeListener="#{xysLeaveApplyBB.qryAuditing}"></h:selectBooleanCheckbox>
                 <h:outputText value="  "></h:outputText>
                 <h:outputText value="批准"></h:outputText>
                 <h:selectBooleanCheckbox value="#{xysLeaveApplyBB.selAudited}" onclick="submit();" valueChangeListener="#{xysLeaveApplyBB.qryAudited}"></h:selectBooleanCheckbox>
                 <h:outputText value="  "></h:outputText>
                 <h:outputText value="退回"></h:outputText>
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
                <h:outputText value="记录数:#{xysLeaveApplyBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{xysLeaveApplyBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{xysLeaveApplyBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{xysLeaveApplyBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{xysLeaveApplyBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{xysLeaveApplyBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{xysLeaveApplyBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{xysLeaveApplyBB.last}" styleClass="button01"></h:commandButton>
                 <h:outputText value="  "></h:outputText>
                <h:commandButton value="增加"  styleClass="button01" onclick="add()"></h:commandButton>
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
            <c:facet name="header"><h:outputText value="申请人"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="请假类型"/></c:facet>
            <h:selectOneMenu value="#{list.leaveType}" disabled="true">
            	<c:selectItems value="#{xysLeaveApplyBB.leaveTypeList}"/>
            </h:selectOneMenu>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="开始时间"/></c:facet>
            <h:outputText value="#{list.beginTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="结束时间"/></c:facet>
            <h:outputText value="#{list.endTime}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="请假时间"/></c:facet>
            <h:outputText value="#{list.applyDays}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="申请时间"/></c:facet>
            <h:outputText value="#{list.applyTiem}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="原因"/></c:facet>
            <h:outputText value="#{list.reason}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>
        
       
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modify('#{list.leaveId}');" styleClass="button01" rendered="#{list.status=='0'||list.status=='3'}"></h:commandButton>
            <h:commandButton value="删除" action="#{xysLeaveApplyBB.deleteLeave}" onclick="return confirm('确定要删除选中请假申请吗？');"
                             rendered="#{list.status=='0' || list.status=='3'}" styleClass="button01">
                  <x:updateActionListener property="#{xysLeaveApplyBB.leaveId}" value="#{list.leaveId}"/>
            </h:commandButton>
            <h:commandButton value="报批" action="#{xysLeaveApplyBB.applyLeave}" 
                             rendered="#{list.status=='0'}" styleClass="button01">
                  <x:updateActionListener property="#{xysLeaveApplyBB.leaveId}" value="#{list.leaveId}"/>
            </h:commandButton>
            <h:commandButton value="重新报批" action="#{xysLeaveApplyBB.applyLeaveAgin}" 
                             rendered="#{list.status=='3'}" styleClass="button01">
                  <x:updateActionListener property="#{xysLeaveApplyBB.leaveId}" value="#{list.leaveId}"/>
            </h:commandButton>
            <h:commandButton value="查看流程" onclick="showFlow('#{list.leaveId}')" styleClass="button01" rendered="#{list.status!='0'}"></h:commandButton>
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
