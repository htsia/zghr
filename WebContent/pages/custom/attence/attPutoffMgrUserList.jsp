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
	   if(confirm("ȷ��Ҫ���빤�����⽫��ձ���ȵ����д��ݼ�¼")){
			var month = window.showModalDialog("/pages/common/CalendarMonthOnly.jsp","ѡ������","dialogWidth:250px; dialogHeight:100px;center:center;resizable:yes;status:no;scroll:yes;");
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
    	if(confirm('���ݽ���գ���תΪ���ʣ���ȷ��')){
    		window.location.href = ("/custom/attence/attPutoffMgrUserList.jsf?subID="+id+"&set='1'");
            return true;
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
	       	   <h:commandButton value="ͳ���������" 
							onclick="return yearAttenceDay()"
							styleClass="button01"></h:commandButton>
	       	   <h:commandButton value="���ô�н������"
							onclick="return modify1()"
							styleClass="button01"></h:commandButton>
	       	   <h:outputText value="  "/>
	       	   <h:outputText value="��������"/>
               <h:inputText value="#{attPutoffMgrBB.nameStr}" styleClass="input" size="10"/> 
               <h:commandButton styleClass="button01" value="��Ա���" onclick="return forSel();" action="#{attPutoffMgrBB.doQuery}"/>
               <h:commandButton styleClass="button01" value="��ѯ" action="#{attPutoffMgrBB.doQuery}"/> 
               <h:outputText value="  "/>
	           <h:outputText value="��¼��:#{attPutoffMgrBB.mypage.totalRecord}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="ҳ��:#{attPutoffMgrBB.mypage.totalPage}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="ÿҳ��#{attPutoffMgrBB.mypage.pageSize}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="��ǰΪ��#{attPutoffMgrBB.mypage.currentPage}ҳ"></h:outputText>
		     		<h:commandButton value="��ҳ" action="#{attPutoffMgrBB.first}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="��ҳ" action="#{attPutoffMgrBB.pre}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="��ҳ" action="#{attPutoffMgrBB.next}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="βҳ" action="#{attPutoffMgrBB.last}" styleClass="button01"></h:commandButton>
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
            <c:facet name="header"><h:outputText value="�ܴ���ʱ��/ʱ"/></c:facet>
            <h:outputText value="#{list.putoffDays}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�������"/></c:facet>
            <h:outputText value="#{list.leaveDays}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.bingjia}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{list.hunjia}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ɥ��"/></c:facet>
            <h:outputText value="#{list.sangjia}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.chanjia}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�Ѳ�����"/></c:facet>
            <h:outputText value="#{list.nanchanjia}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��н�¼�"/></c:facet>
            <h:outputText value="#{list.daixinjia}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��Ӧ��������"/></c:facet>
            <h:outputText value="#{list.yearAttence}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ʵ�ʳ�������"/></c:facet>
            <h:outputText value="#{list.yearRealAttence}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="������"/></c:facet>
            <h:outputText value="#{list.attenceRate}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�Ӱ�Сʱ��"/></c:facet>
            <h:outputText value="#{list.overtimeHours}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>            
            <h:commandButton value="�޸�" styleClass="button01" onclick="modify('#{list.id}');"></h:commandButton>
        </h:column> 
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>            
            <h:commandButton value="����ת����" styleClass="button01" onclick="reset1('#{list.id}');"></h:commandButton>
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
