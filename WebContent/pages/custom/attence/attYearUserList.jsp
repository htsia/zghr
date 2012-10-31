<%@page import="java.util.Date"%>
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
   function selMonth(){
	   if(confirm("确定要计入工资吗？这将清空本年度的所有存休记录")){
			var month = window.showModalDialog("/pages/common/CalendarMonthOnly.jsp","选择日期","dialogWidth:250px; dialogHeight:100px;center:center;resizable:yes;status:no;scroll:yes;");
			if(month!=null){
				document.all("form1:year").value=month;
				return true;
			}
			return false;
	   }
	   return false;
	}
    
    function modify(id) {
        window.showModalDialog("/custom/attence/attPutoffMgrResultEdit.jsf?subID="+id, null, "dialogWidth:400px;dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
    
    function reset1(id) {
    	//alert(id);
    	var selectMonth=document.all("form1:selectMonth").value;
    	if(selectMonth.length<1){
    		alert("请首先选择月份，表示加班费计入哪个月份的工资");
    		return false;
    	}
    	if(confirm('存休将清空，将转为工资，请确认')){
    		window.location.href = ("/custom/attence/attPutoffMgrUserList.jsf?selectMonth="+selectMonth+"&subID="+id+"&set='1'");
            return false;
    	}
        
    }
    function modify1(){
        window.showModalDialog("/custom/attence/attPutoffMgrResetEdit.jsf", null, "dialogWidth:350px; dialogHeight:230px; status:0;resizable:yes");
        return true;
    }
    function yearAttenceDay(){
        window.showModalDialog("/custom/attence/attPutoffMgrYearAttenceEdit.jsf", null, "dialogWidth:350px; dialogHeight:230px; status:0;resizable:yes");
        return true;
    }
</script>

<x:saveState value="#{attPutoffMgrBB}"></x:saveState>
<h:inputHidden value="#{attPutoffMgrBB.pageInit}"></h:inputHidden>
<h:form id="form1">
	<h:inputHidden id="year" value="#{attPutoffMgrBB.applyYear}" />
	<h:inputHidden id="putoffsum" value="#{attPutoffMgrBB.putoffsum}"/>
	<h:inputHidden id="personType" value="#{attPutoffMgrBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{attPutoffMgrBB.personTypeValue}"/>
     <c:verbatim>
       <table height=100% width=100% align="center">
       <tr><td height=1>
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
	    <h:panelGrid align="left" columns="1">
	       <h:panelGroup>
	       	   <h:commandButton value="重置带薪假天数"
							onclick="return modify1()"
							styleClass="button01"></h:commandButton>
	       	   <h:outputText value="  "/>
	       	   <h:outputText value="姓名或编号"/>
               <h:inputText value="#{attPutoffMgrBB.nameStr}" styleClass="input" size="10"/> 
               <h:commandButton styleClass="button01" value="人员类别" onclick="return forSel();" action="#{attPutoffMgrBB.doQuery}"/>
               <h:commandButton styleClass="button01" value="查询" action="#{attPutoffMgrBB.doQuery}"/> 
               <f:verbatim>
               <span align="right">
               </f:verbatim>
               <h:outputText value="选择发放工资的月份"/>
               <h:inputText id="selectMonth" readonly="true" styleClass="input" onclick="WdatePicker({alwaysUseStartDate:true,dateFmt:'yyyy-MM'})" value="#{attPutoffMgrBB.overtimePayMonth}" />
               <h:outputText value="  "/><f:verbatim></span></f:verbatim>
               <f:verbatim>
               <br/>
               </f:verbatim>
	           <h:outputText value="记录数:#{attPutoffMgrBB.mypage.totalRecord}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="页数:#{attPutoffMgrBB.mypage.totalPage}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="每页有#{attPutoffMgrBB.mypage.pageSize}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="当前为第#{attPutoffMgrBB.mypage.currentPage}页"></h:outputText>
		     		<h:commandButton value="首页" action="#{attPutoffMgrBB.first}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="上页" action="#{attPutoffMgrBB.pre}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="下页" action="#{attPutoffMgrBB.next}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="尾页" action="#{attPutoffMgrBB.last}" styleClass="button01"></h:commandButton>
		      </h:panelGroup>
	    </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
      
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{attPutoffMgrBB.list}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="员工编号"/></c:facet>
            <h:outputText value="#{list.id}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list.name}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="二级部门"/></c:facet>
            <h:outputText value="#{list.secDeptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="所在部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>             
        <h:column>
            <c:facet name="header"><h:outputText value="总存休时间/时"/></c:facet>
            <h:outputText value="#{list.putoffDays}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="病假"/></c:facet>
            <h:outputText value="#{list.bingjia}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="婚假"/></c:facet>
            <h:outputText value="#{list.hunjia}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="丧假"/></c:facet>
            <h:outputText value="#{list.sangjia}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="产假"/></c:facet>
            <h:outputText value="#{list.chanjia}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="难产产假"/></c:facet>
            <h:outputText value="#{list.nanchanjia}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="带薪事假"/></c:facet>
            <h:outputText value="#{list.daixinjia}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>            
            <h:commandButton value="修改" styleClass="button01" onclick="modify('#{list.id}');"></h:commandButton>
        </h:column> 
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>            
            <h:commandButton value="存休转工资" styleClass="button01" onclick="return reset1('#{list.id}');"></h:commandButton>
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
