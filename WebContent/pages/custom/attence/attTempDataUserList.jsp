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
		   alert("�����뿪ʼ����");
		   return false;
	   }
	   if(tempEndDate==null||""==tempEndDate){
		   alert("�������������");
		   return false;
	   }
	   process();
	   return true;
   }
   function forSend(){
	   if(confirm('ȷ��ȫ��������?')){
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
       	alert("��ѡ����Ա");
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
	       	   <h:outputText value="��������"/>
               <h:inputText value="#{attPutoffMgrBB.nameStr}" styleClass="input" size="10" onkeypress ="enterKeyDown('form1:queryPerson')"/> 
               <h:commandButton styleClass="button01" value="��Ա���" onclick="return forSel();" action="#{attPutoffMgrBB.doQuery}"/>
               <h:commandButton id="queryPerson" styleClass="button01" value="��ѯ" action="#{attPutoffMgrBB.attYearDoQuery}"/>
	       	   <h:outputText value="  "/>                
	           <h:outputText value="ͳ�����ڴ�"/>
               <h:inputText id="tempBeginDate" readonly="true" styleClass="input Wdate" size="20" onclick="WdatePicker({alwaysUseStartDate:true,dateFmt:'yyyy-MM-dd'})" value="#{attPutoffMgrBB.tempBeginDate}" />
	       	   <h:outputText value="��"/>
               <h:inputText id="tempEndDate" readonly="true" styleClass="input Wdate" size="20" onclick="WdatePicker({alwaysUseStartDate:true,dateFmt:'yyyy-MM-dd'})" value="#{attPutoffMgrBB.tempEndDate}" />
	       	   <h:commandButton value="ͳ�ƿ���" onclick="return checkDate();" action="#{attPutoffMgrBB.updateCalcAttTempData }" />
	       	   <h:outputText value="  "/>
	       	   <h:commandButton value="ѡ�����ʼ�" onclick="return selUser();" action="#{attPutoffMgrBB.sendEmail}" />
	       	   <h:commandButton value="ȫ�������ʼ�" onclick="return forSend();" action="#{attPutoffMgrBB.sendEmail}" />
	       	 </h:panelGroup>
	     </h:panelGrid>
	     <h:panelGrid align="right" columns="1">
	       <h:panelGroup>
	           <h:outputText value="��¼��:#{attPutoffMgrBB.mypage.totalRecord}"/>
		       <h:outputText value="  "/>
		       <h:outputText value="ҳ��:#{attPutoffMgrBB.mypage.totalPage}"/>
		       <h:outputText value="  "/>
		       <h:outputText value="ÿҳ��#{attPutoffMgrBB.mypage.pageSize}"/>
		       <h:outputText value="  "/>
		       <h:outputText value="��ǰΪ��#{attPutoffMgrBB.mypage.currentPage}ҳ"/>
	     	   <h:commandButton value="��ҳ" action="#{attPutoffMgrBB.first}" styleClass="button01"/>
		       <h:commandButton value="��ҳ" action="#{attPutoffMgrBB.pre}" styleClass="button01"/>
		       <h:commandButton value="��ҳ" action="#{attPutoffMgrBB.next}" styleClass="button01"/>
		       <h:commandButton value="βҳ" action="#{attPutoffMgrBB.last}" styleClass="button01"/>
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
            <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
            <h:outputText value="#{list.id}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.name}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.secDeptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���ڲ���"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>             
        <h:column>
            <c:facet name="header"><h:outputText value="��ʼ����"/></c:facet>
            <h:outputText value="#{list.tempBeginDate}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.tempEndDate}"/>
        </h:column>
        <h:column >
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
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
