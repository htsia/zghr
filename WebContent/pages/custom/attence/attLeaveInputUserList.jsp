<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
	<script src="<%=request.getContextPath()%>/js/jquery.js"
	type="text/javascript"></script>
    <script type="text/javascript" contenteditable="inherit">
    	function add() {
            window.showModalDialog("/custom/attence/attLeaveInputEdit.jsf?act=init", null, "dialogWidth:"+screen.width*0.5+"px;dialogHeight:"+screen.height*0.5+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
       function setData(v){
			if(v==0){
				PopUpCalendarDialog('form1:beginDate');
			}else{
				PopUpCalendarDialog('form1:endDate');
			}
			return false;
	   }
       function forSel() {
	    	PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'');
	    	var type = document.all("form1:personType").value;
	    	if(type==null || type==""){
	    		return false;
	    	}
	    	return true;
	    }
      
    </script>

<x:saveState value="#{attLeaveApplyBB}"></x:saveState>
<h:inputHidden value="#{attLeaveApplyBB.inputInit}"/>
<h:form id="form1">
	<h:inputHidden id="personType" value="#{attLeaveApplyBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{attLeaveApplyBB.personTypeValue}"/>
	<h:inputHidden id="selectedUserIds" value="#{attLeaveApplyBB.selectedUserIds}"/>
     <c:verbatim>
       <table height=100% width=100% align="center">
       <tr><td height=1>
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
	    <h:panelGrid align="right" columns="1">
	       <h:panelGroup>
            <h:outputText value="��ʼ���ڣ�"></h:outputText>
            <h:inputText id="beginDate" value="#{attLeaveApplyBB.beginDate}" styleClass="input" size="10"/>
            <h:commandButton onclick="return setData(0);" styleClass="button_select" value=""/>
            <h:outputText value="�������ڣ�"></h:outputText>
            <h:inputText id="endDate" value="#{attLeaveApplyBB.endDate}" styleClass="input" size="10"/>
            <h:commandButton onclick="return setData(1);" styleClass="button_select" value=""/>
            <h:outputText value="  "/>
            <h:outputText value="��������"/>
            <h:inputText value="#{attLeaveApplyBB.nameStr}" styleClass="input" size="10" /> 
            <h:commandButton styleClass="button01" value="��Ա���" onclick="return forSel();" action="#{attLeaveApplyBB.doQuery}"/>
            <h:commandButton styleClass="button01" value="��ѯ" action="#{attLeaveApplyBB.doQuery}"/> 
            <h:outputText value="  "/>
            <h:commandButton value="����"  styleClass="button01" onclick="add()"/>
	      </h:panelGroup>
	    </h:panelGrid>
	    <h:panelGrid align="right" columns="1">
	       <h:panelGroup>
	          <h:outputText value="��¼��:#{attLeaveApplyBB.mypage.totalRecord}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="ҳ��:#{attLeaveApplyBB.mypage.totalPage}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="ÿҳ��#{attLeaveApplyBB.mypage.pageSize}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="��ǰΪ��#{attLeaveApplyBB.mypage.currentPage}ҳ"></h:outputText>
		     		<h:commandButton value="��ҳ" action="#{attLeaveApplyBB.first}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="��ҳ" action="#{attLeaveApplyBB.pre}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="��ҳ" action="#{attLeaveApplyBB.next}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="βҳ" action="#{attLeaveApplyBB.last}" styleClass="button01"></h:commandButton>
		      </h:panelGroup>
	    </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
      
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{attLeaveApplyBB.list}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
            <h:outputText value="#{list.personCode}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���ڲ���"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column> 
        <h:column>
            <c:facet name="header"><h:outputText value="�������"/></c:facet>
            <h:selectOneMenu value="#{list.leaveType}" disabled="true">
            	<c:selectItems value="#{attLeaveApplyBB.leaveTypeList}"/>
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
            <c:facet name="header"><h:outputText value="���ʱ��/��"/></c:facet>
            <h:outputText value="#{list.applyDays}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
            <h:outputText value="#{list.applyTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ԭ��"/></c:facet>
            <h:outputText value="#{list.reason}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="ɾ��"  styleClass="button01" onclick="return confirm('ȷ��ɾ����');" action="#{attLeaveApplyBB.deleteInput}">
            	<x:updateActionListener value="#{list.id}" property="#{attLeaveApplyBB.operItemID}"></x:updateActionListener>
            </h:commandButton>
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
