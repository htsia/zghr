<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript" contenteditable="inherit">
       function forSel() {
	    	PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'');
	    	var type = document.all("form1:personType").value;
	    	if(type==null || type==""){
	    		return false;
	    	}
	    	return true;
	    }
       function showFlow(id){
    	   window.showModalDialog("/custom/attence/attLeaveLog.jsf?leaveId="+id, null, "dialogWidth:"+screen.width+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
           return true;
       }
       function leaveback(id){
    	   //alert(id);
    	   window.showModalDialog("/custom/attence/attLeaveBack.jsf?leaveId="+id, null, "dialogWidth:"+screen.width*0.2+"px; dialogHeight:"+screen.height*0.2+"px;center:center;resizable:yes;status:no;scroll:yes;");
           return true;
       }
    </script>

<x:saveState value="#{attLeaveApplyBB}"/>
<h:inputHidden value="#{attLeaveApplyBB.queryInit}"/>
<h:form id="form1">
	<h:inputHidden id="personType" value="#{attLeaveApplyBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{attLeaveApplyBB.personTypeValue}"/>
    <!-- 当前登陆用户 -->
    <h:inputHidden id="userId" value="#{attLeaveApplyBB.userId}"/>
     <c:verbatim>
       <table height=100% width=100% align="center">
       <tr><td height=1>
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
	    <h:panelGrid align="right" columns="1">
	       <h:panelGroup>
                 <h:outputText value="我的单据"/>
                 <h:selectBooleanCheckbox value="#{attLeaveApplyBB.selMyAtt}" onclick="submit();" valueChangeListener="#{attLeaveApplyBB.qryMyAtt}"></h:selectBooleanCheckbox>
                 <h:outputText value="  请假单状态:"/>
                 <h:outputText value="报批"/>
                 <h:selectBooleanCheckbox value="#{attLeaveApplyBB.selAuditing}" onclick="submit();" valueChangeListener="#{attLeaveApplyBB.qryAuditing}"></h:selectBooleanCheckbox>
                 <h:outputText value="  "/>
                 <h:outputText value="批准"/>
                 <h:selectBooleanCheckbox value="#{attLeaveApplyBB.selAudited}" onclick="submit();" valueChangeListener="#{attLeaveApplyBB.qryAudited}"></h:selectBooleanCheckbox>
                 <h:outputText value="  "/>
                 <h:outputText value="退回"/>
                 <h:selectBooleanCheckbox value="#{attLeaveApplyBB.selRefuse}" onclick="submit();" valueChangeListener="#{attLeaveApplyBB.qryRefuse}"></h:selectBooleanCheckbox>
                 <h:outputText value="  "/>
                 <h:outputText value="开始日期从"/>
                 <h:inputText id="beginDate" value="#{attLeaveApplyBB.beginDate}" styleClass="input Wdate" size="15" onclick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',el:'form1:beginDate'})"/>
                 <h:outputText value="至"/>
                 <h:inputText id="endDate" value="#{attLeaveApplyBB.endDate}" styleClass="input Wdate" size="15" onclick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',el:'form1:endDate'})"/>
                 <h:outputText value="  "/>
                 <h:outputText value="姓名或编号"/>
                 <h:inputText value="#{attLeaveApplyBB.nameStr}" styleClass="input" size="10" onkeypress ="enterKeyDown('form1:queryPerson')"/> 
                 <h:commandButton styleClass="button01" value="人员类别" onclick="return forSel();" action="#{attLeaveApplyBB.doQuery}"/>
                 <h:commandButton id="queryPerson" styleClass="button01" value="查询"  action="#{attLeaveApplyBB.doQuery}"/> 
	      </h:panelGroup>
	    </h:panelGrid>
	    <h:panelGrid align="right" columns="1">
	       <h:panelGroup>
                 <h:outputText value="请假单类型:  正常请假"/>
	       		 <h:selectBooleanCheckbox value="#{attLeaveApplyBB.selLeave1}" onclick="submit();" valueChangeListener="#{attLeaveApplyBB.qryLeave1}"/>
                 <h:outputText value="  "/>
                 <h:outputText value="病假"/>
	       		 <h:selectBooleanCheckbox value="#{attLeaveApplyBB.selLeave2}" onclick="submit();" valueChangeListener="#{attLeaveApplyBB.qryLeave2}"/>
                 <h:outputText value="  "/>
                 <h:outputText value="婚假"/>
	       		 <h:selectBooleanCheckbox value="#{attLeaveApplyBB.selLeave3}" onclick="submit();" valueChangeListener="#{attLeaveApplyBB.qryLeave3}"/>
                 <h:outputText value="  "/>
                 <h:outputText value="丧假"/>
	       		 <h:selectBooleanCheckbox value="#{attLeaveApplyBB.selLeave4}" onclick="submit();" valueChangeListener="#{attLeaveApplyBB.qryLeave4}"/>
                 <h:outputText value="  "/>
                 <h:outputText value="产假"/>
	       		 <h:selectBooleanCheckbox value="#{attLeaveApplyBB.selLeave5}" onclick="submit();" valueChangeListener="#{attLeaveApplyBB.qryLeave5}"/>
                 <h:outputText value="  "/>
                 <h:outputText value="难产产假"/>
	       		 <h:selectBooleanCheckbox value="#{attLeaveApplyBB.selLeave6}" onclick="submit();" valueChangeListener="#{attLeaveApplyBB.qryLeave6}"/>
                 <h:outputText value="  "/>
                 <h:outputText value="带薪事假"/>
	       		 <h:selectBooleanCheckbox value="#{attLeaveApplyBB.selLeave7}" onclick="submit();" valueChangeListener="#{attLeaveApplyBB.qryLeave7}"/>
                 <h:outputText value="  "/>
                 <h:outputText value="流产产假"/>
	       		 <h:selectBooleanCheckbox value="#{attLeaveApplyBB.selLeave8}" onclick="submit();" valueChangeListener="#{attLeaveApplyBB.qryLeave8}"/>
                 <h:outputText value="  "/>
                 <h:outputText value="双胞胎产假"/>
	       		 <h:selectBooleanCheckbox value="#{attLeaveApplyBB.selLeave9}" onclick="submit();" valueChangeListener="#{attLeaveApplyBB.qryLeave9}"/>
		      </h:panelGroup>
	    </h:panelGrid>
	    <h:panelGrid align="right" columns="1">
	       <h:panelGroup>
	          <h:outputText value="记录数:#{attLeaveApplyBB.mypage.totalRecord}"/>
		       <h:outputText value="  "/>
		       <h:outputText value="页数:#{attLeaveApplyBB.mypage.totalPage}"/>
		       <h:outputText value="  "/>
		       <h:outputText value="每页有#{attLeaveApplyBB.mypage.pageSize}"/>
		       <h:outputText value="  "/>
		       <h:outputText value="当前为第#{attLeaveApplyBB.mypage.currentPage}页"/>
		     		<h:commandButton value="首页" action="#{attLeaveApplyBB.first}" styleClass="button01"/>
		       <h:commandButton value="上页" action="#{attLeaveApplyBB.pre}" styleClass="button01"/>
		       <h:commandButton value="下页" action="#{attLeaveApplyBB.next}" styleClass="button01"/>
		       <h:commandButton value="尾页" action="#{attLeaveApplyBB.last}" styleClass="button01"/>
		      </h:panelGroup>
	    </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
      
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{attLeaveApplyBB.list}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center80,td_middle_center80,td_middle_center,td_middle_center80,td_middle_center100,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="员工编号"/></c:facet>
            <h:outputText value="#{list.personCode}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="申请人姓名"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="所在部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>        
        <h:column>
            <c:facet name="header"><h:outputText value="请假类型"/></c:facet>
            <h:selectOneMenu value="#{list.leaveType}" disabled="true">
            	<c:selectItems value="#{attLeaveApplyBB.leaveTypeList}"/>
            </h:selectOneMenu>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="是否销假"/></c:facet>
            <h:outputText value="已销假" rendered="#{list.isBack=='1' }"/>
            <h:outputText value="否" rendered="#{list.isBack!='1' && list.applyDays>10 }"/>
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
            <c:facet name="header"><h:outputText value="请假时间/天"/></c:facet>
            <h:outputText value="#{list.applyDays}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="申请时间"/></c:facet>
            <h:outputText value="#{list.applyTime}"/>
        </h:column>
        <h:column>
        	<f:attribute name="width" value="500"/>
            <c:facet name="header"><h:outputText value="原因"/></c:facet>
            <h:outputText value="#{list.reason}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
             <h:commandButton value="删除"  action="#{attLeaveApplyBB.deleteLeave}" onclick="return confirm('确定要删除吗？');" styleClass="button01" 
             	rendered="#{attLeaveApplyBB.ismanager=='1' || (list.personId==attLeaveApplyBB.userId&&list.statusDes=='退回') || !list.appro}">
             	<x:updateActionListener property="#{attLeaveApplyBB.leaveId}" value="#{list.id}"/>
             </h:commandButton>
             <h:commandButton value="重新报批"  action="#{attLeaveApplyBB.applyLeave}" onclick="return confirm('确定要重新报批吗？');" styleClass="button01" rendered="#{attLeaveApplyBB.ismanager=='1'}">
             	<x:updateActionListener property="#{attLeaveApplyBB.leaveId}" value="#{list.id}"/>
             </h:commandButton>
             <h:commandButton value="查看流程" onclick="showFlow('#{list.id}')" styleClass="button01" rendered="#{list.createType=='0'}"/>
             <h:commandButton value="销假" onclick="leaveback('#{list.id}')"  styleClass="button01" rendered="#{list.status=='2' && list.applyDays>10 && list.isBack!='1' && attLeaveApplyBB.ismanager=='1'}"/>
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
