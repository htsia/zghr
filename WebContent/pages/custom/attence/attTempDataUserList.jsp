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
   function checkDate(){
	 
	   var tempBeginDate=document.all('form1:tempBeginDate').value;
	   var tempEndDate=document.all('form1:tempEndDate').value;
	   if(tempBeginDate==null||""==tempBeginDate){
		   alert("请输入开始日期");
		   return false;
	   }
	   if(tempEndDate==null||""==tempEndDate){
		   alert("请输入结束日期");
		   return false;
	   }
	   process();
	   return true;
   }
   function forSend(){
	   if(confirm('确定全部发送吗?')){
		   process();
		   return true;
	   }
	   return false;
   }
   function selUser(){
	   var item = document.getElementsByName("selectItem");
       var selIds="";
       if(item.length>0){
           for(var i=0;i<item.length;i++){
               if(item[i].checked)
               {
               	selIds+=item[i].value+",";    
               }
           }
       }
       if(selIds==""){
       	alert("请选择人员");
       	return false;
       }
       document.all("form1:selectedUserIDs").value=selIds;
       return true;
	}
   function process() {
		x = document.body.clientWidth / 2 - 150;
		y = document.body.clientHeight / 2;
		document.all('processbar').style.top = y;
		document.all('processbar').style.left = x;
		document.all('processbar').style.display = "";
	}
</script>

<x:saveState value="#{attPutoffMgrBB}"></x:saveState>
<h:inputHidden value="#{attPutoffMgrBB.attTempDataInit}"></h:inputHidden>
<h:form id="form1">
	<h:inputHidden id="putoffsum" value="#{attPutoffMgrBB.putoffsum}"/>
	<h:inputHidden id="personType" value="#{attPutoffMgrBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{attPutoffMgrBB.personTypeValue}"/>
    <h:inputHidden id="selectedUserIDs" value="#{attPutoffMgrBB.selectedUserIDs}"/>
     <c:verbatim>
       <table height=100% width=100% align="center">
       <tr><td height=1>
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
	    <h:panelGrid align="left" columns="1">
	       <h:panelGroup>
	       	   <h:outputText value="姓名或编号"/>
               <h:inputText value="#{attPutoffMgrBB.nameStr}" styleClass="input" size="10" onkeypress ="enterKeyDown('form1:queryPerson')"/> 
               <h:commandButton styleClass="button01" value="人员类别" onclick="return forSel();" action="#{attPutoffMgrBB.doQuery}"/>
               <h:commandButton id="queryPerson" styleClass="button01" value="查询" action="#{attPutoffMgrBB.attYearDoQuery}"/>
	       	   <h:outputText value="  "/>                
	           <h:outputText value="统计日期从"/>
               <h:inputText id="tempBeginDate" readonly="true" styleClass="input Wdate" size="20" onclick="WdatePicker({alwaysUseStartDate:true,dateFmt:'yyyy-MM-dd'})" value="#{attPutoffMgrBB.tempBeginDate}" />
	       	   <h:outputText value="至"/>
               <h:inputText id="tempEndDate" readonly="true" styleClass="input Wdate" size="20" onclick="WdatePicker({alwaysUseStartDate:true,dateFmt:'yyyy-MM-dd'})" value="#{attPutoffMgrBB.tempEndDate}" />
	       	   <h:commandButton value="统计考勤" onclick="return checkDate();" action="#{attPutoffMgrBB.updateCalcAttTempData }" />
	       	   <h:outputText value="  "/>
	       	   <h:commandButton value="选择发送邮件" onclick="return selUser();" action="#{attPutoffMgrBB.sendEmail}" />
	       	   <h:commandButton value="全部发送邮件" onclick="return forSend();" action="#{attPutoffMgrBB.sendEmail}" />
	       	 </h:panelGroup>
	     </h:panelGrid>
	     <h:panelGrid align="right" columns="1">
	       <h:panelGroup>
	           <h:outputText value="记录数:#{attPutoffMgrBB.mypage.totalRecord}"/>
		       <h:outputText value="  "/>
		       <h:outputText value="页数:#{attPutoffMgrBB.mypage.totalPage}"/>
		       <h:outputText value="  "/>
		       <h:outputText value="每页有#{attPutoffMgrBB.mypage.pageSize}"/>
		       <h:outputText value="  "/>
		       <h:outputText value="当前为第#{attPutoffMgrBB.mypage.currentPage}页"/>
	     	   <h:commandButton value="首页" action="#{attPutoffMgrBB.first}" styleClass="button01"/>
		       <h:commandButton value="上页" action="#{attPutoffMgrBB.pre}" styleClass="button01"/>
		       <h:commandButton value="下页" action="#{attPutoffMgrBB.next}" styleClass="button01"/>
		       <h:commandButton value="尾页" action="#{attPutoffMgrBB.last}" styleClass="button01"/>
		      </h:panelGroup>
	    </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
      
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{attPutoffMgrBB.attTempDataList}" var="list" align="center" id="dateList"
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
            <c:facet name="header"><h:outputText value="开始日期"/></c:facet>
            <h:outputText value="#{list.tempBeginDate}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="结束日期"/></c:facet>
            <h:outputText value="#{list.tempEndDate}"/>
        </h:column>
        <h:column >
            <c:facet name="header"><h:outputText value="考勤详情"/></c:facet>
            <h:outputText value="#{list.attDetail}"/>
        </h:column>
    </h:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>

</h:form>
<marquee id="processbar"
	style="position: absolute; display: none; border: 1px solid #000000"
	direction="right" width="300" scrollamount="5" scrolldelay="10"
	bgcolor="#ECF2FF">
	<table cellspacing="1" cellpadding="0">
		<tr height=8>
			<td bgcolor=#3388FF width=9></td>
			<td></td>
			<td bgcolor=#3388FF width=9></td>
			<td></td>
			<td bgcolor=#3388FF width=9></td>
			<td></td>
		</tr>
	</table>
</marquee>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
