<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
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
    	   window.showModalDialog("/custom/attence/attRestLog.jsf?id="+id, null, "dialogWidth:"+screen.width+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
           return true;
       }
    </script>

<x:saveState value="#{attRestApplyBB}"></x:saveState>
<h:inputHidden value="#{attRestApplyBB.queryInit}"></h:inputHidden>
<h:form id="form1">
	<h:inputHidden id="personType" value="#{attRestApplyBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{attRestApplyBB.personTypeValue}"/>
     <c:verbatim>
       <table height=100% width=100% align="center">
       <tr><td height=1>
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
	    <h:panelGrid align="right" columns="1">
	       <h:panelGroup>
                 <h:outputText value="报批"></h:outputText>
                 <h:selectBooleanCheckbox value="#{attRestApplyBB.selAuditing}" onclick="submit();" valueChangeListener="#{attRestApplyBB.qryAuditing}"></h:selectBooleanCheckbox>
                 <h:outputText value="  "></h:outputText>
                 <h:outputText value="批准"></h:outputText>
                 <h:selectBooleanCheckbox value="#{attRestApplyBB.selAudited}" onclick="submit();" valueChangeListener="#{attRestApplyBB.qryAudited}"></h:selectBooleanCheckbox>
                 <h:outputText value="  "></h:outputText>
                 <h:outputText value="退回"></h:outputText>
                 <h:selectBooleanCheckbox value="#{attRestApplyBB.selRefuse}" onclick="submit();" valueChangeListener="#{attRestApplyBB.qryRefuse}"></h:selectBooleanCheckbox>
                 <h:outputText value="  "></h:outputText>
                 <h:outputText value="开始日期从"></h:outputText>
                 <h:inputText id="beginDate" value="#{attRestApplyBB.beginDate}" styleClass="input Wdate" size="15" onclick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',el:'form1:beginDate'})"/>
                 <h:outputText value="至"></h:outputText>
                 <h:inputText id="endDate" value="#{attRestApplyBB.endDate}" styleClass="input Wdate" size="15" onclick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',el:'form1:endDate'})"/>
                 <h:outputText value="  "/>
                 <h:outputText value="姓名或编号"/>
                 <h:inputText value="#{attRestApplyBB.nameStr}" styleClass="input" size="10" onkeypress ="enterKeyDown('form1:queryPerson')"/> 
                 <h:commandButton styleClass="button01" value="人员类别" onclick="return forSel();" action="#{attRestApplyBB.doQuery}"/>
                 <h:commandButton id="queryPerson" styleClass="button01" value="查询" action="#{attRestApplyBB.doQuery}"/> 
	      </h:panelGroup>
	    </h:panelGrid>
	    <h:panelGrid align="right" columns="1">
	       <h:panelGroup>
	          <h:outputText value="记录数:#{attRestApplyBB.mypage.totalRecord}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="页数:#{attRestApplyBB.mypage.totalPage}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="每页有#{attRestApplyBB.mypage.pageSize}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="当前为第#{attRestApplyBB.mypage.currentPage}页"></h:outputText>
		     		<h:commandButton value="首页" action="#{attRestApplyBB.first}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="上页" action="#{attRestApplyBB.pre}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="下页" action="#{attRestApplyBB.next}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="尾页" action="#{attRestApplyBB.last}" styleClass="button01"></h:commandButton>
		      </h:panelGroup>
	    </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
      
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{attRestApplyBB.list}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center100,td_middle_center,td_middle_center"
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
            <c:facet name="header"><h:outputText value="开始时间"/></c:facet>
            <h:outputText value="#{list.beginTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="结束时间"/></c:facet>
            <h:outputText value="#{list.endTime}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="调休时间/天"/></c:facet>
            <h:outputText value="#{list.applyDays}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="申请时间"/></c:facet>
            <h:outputText value="#{list.applyTime}"/>
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
        	<h:commandButton value="删除"  action="#{attRestApplyBB.delete}" onclick="return confirm('确定要删除吗？');" styleClass="button01" 
             	rendered="#{attRestApplyBB.ismanager=='1'||(list.personId==attRestApplyBB.userId&&list.statusDes=='退回') || !list.appro}">
             	<x:updateActionListener property="#{attRestApplyBB.id}" value="#{list.id}"/>
            </h:commandButton>
            <h:commandButton value="查看流程" onclick="showFlow('#{list.id}')" styleClass="button01" rendered="#{list.createType=='0'}"></h:commandButton>
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
