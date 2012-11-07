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
    	   window.showModalDialog("/custom/attence/attOvertimeLog.jsf?id="+id, null, "dialogWidth:"+screen.width+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
           return true;
       }
    </script>

<x:saveState value="#{attOvertimeApplyBB}"></x:saveState>
<h:inputHidden value="#{attOvertimeApplyBB.queryInit}"></h:inputHidden>
<h:form id="form1">
	<h:inputHidden id="personType" value="#{attOvertimeApplyBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{attOvertimeApplyBB.personTypeValue}"/>
     <c:verbatim>
       <table height=100% width=100% align="center">
       <tr><td height=1>
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
	    <h:panelGrid align="right" columns="1">
	       <h:panelGroup>
	       <h:outputText value="�ҵĵ���"></h:outputText>
                 <h:selectBooleanCheckbox value="#{attOvertimeApplyBB.selMyAtt}" onclick="submit();" valueChangeListener="#{attOvertimeApplyBB.qryMyAtt}"></h:selectBooleanCheckbox>
                 <h:outputText value="  "></h:outputText>
                 <h:outputText value="����"></h:outputText>
                 <h:selectBooleanCheckbox value="#{attOvertimeApplyBB.selAuditing}" onclick="submit();" valueChangeListener="#{attOvertimeApplyBB.qryAuditing}"></h:selectBooleanCheckbox>
                 <h:outputText value="  "></h:outputText>
                 <h:outputText value="��׼"></h:outputText>
                 <h:selectBooleanCheckbox value="#{attOvertimeApplyBB.selAudited}" onclick="submit();" valueChangeListener="#{attOvertimeApplyBB.qryAudited}"></h:selectBooleanCheckbox>
                 <h:outputText value="  "></h:outputText>
                 <h:outputText value="�˻�"></h:outputText>
                 <h:selectBooleanCheckbox value="#{attOvertimeApplyBB.selRefuse}" onclick="submit();" valueChangeListener="#{attOvertimeApplyBB.qryRefuse}"></h:selectBooleanCheckbox>
                 <h:outputText value="  "></h:outputText>
                 <h:outputText value="��ʼ���ڴ�"></h:outputText>
                 <h:inputText id="beginDate" value="#{attOvertimeApplyBB.beginDate}" styleClass="input Wdate" size="15" onclick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',el:'form1:beginDate'})"/>
                 <h:outputText value="��"></h:outputText>
                 <h:inputText id="endDate" value="#{attOvertimeApplyBB.endDate}" styleClass="input Wdate" size="15" onclick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',el:'form1:endDate'})"/>
                 <h:outputText value="  "/>
                 <h:outputText value="��������"/>
                 <h:inputText value="#{attOvertimeApplyBB.nameStr}" styleClass="input" size="10" onkeypress ="enterKeyDown('form1:queryPerson')"/> 
                 <h:commandButton styleClass="button01" value="��Ա���" onclick="return forSel();" action="#{attOvertimeApplyBB.doQuery}"/>
                 <h:commandButton id="queryPerson" styleClass="button01" value="��ѯ" action="#{attOvertimeApplyBB.doQuery}"/> 
	      </h:panelGroup>
	    </h:panelGrid>
	    <h:panelGrid align="right" columns="1">
	       <h:panelGroup>
	          <h:outputText value="��¼��:#{attOvertimeApplyBB.mypage.totalRecord}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="ҳ��:#{attOvertimeApplyBB.mypage.totalPage}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="ÿҳ��#{attOvertimeApplyBB.mypage.pageSize}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="��ǰΪ��#{attOvertimeApplyBB.mypage.currentPage}ҳ"></h:outputText>
		     		<h:commandButton value="��ҳ" action="#{attOvertimeApplyBB.first}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="��ҳ" action="#{attOvertimeApplyBB.pre}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="��ҳ" action="#{attOvertimeApplyBB.next}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="βҳ" action="#{attOvertimeApplyBB.last}" styleClass="button01"></h:commandButton>
		      </h:panelGroup>
	    </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
      
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{attOvertimeApplyBB.list}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center100,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
            <h:outputText value="#{list.personCode}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����������"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���ڲ���"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>     
        <h:column>
            <c:facet name="header"><h:outputText value="�Ӱ�����"/></c:facet>
            <h:outputText value="#{list.beginTime}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="�Ӱ�ʱ��/ʱ"/></c:facet>
            <h:outputText value="#{list.applyDays*8}"/>
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
            <c:facet name="header"><h:outputText value="״̬"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
	        <h:commandButton value="ɾ��"  action="#{attOvertimeApplyBB.delete}" onclick="return confirm('ȷ��Ҫɾ����');" styleClass="button01" 
	             	rendered="#{attOvertimeApplyBB.ismanager=='1'||(list.personId==attOvertimeApplyBB.userId&&list.statusDes=='�˻�') || !list.appro}">
	             	<x:updateActionListener property="#{attOvertimeApplyBB.id}" value="#{list.id}"/>
	             </h:commandButton>
	        <h:commandButton value="�鿴����" onclick="showFlow('#{list.id}')" styleClass="button01" rendered="#{list.createType=='0'}"></h:commandButton>
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
