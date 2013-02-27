<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript" contenteditable="inherit">
    	function add() {
            window.showModalDialog("/custom/attence/attOvertimeInputEdit.jsf?act=init", null, "dialogWidth:"+screen.width*0.5+"px;dialogHeight:"+screen.height*0.5+"px;center:center;resizable:no;status:no;scroll:yes;");
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
       function forUplod() {
    	   window.showModalDialog("/custom/attence/fileInfoIndex.jsf",null,"dialogWidth:1150px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
   		   return true;
       }

    </script>

<x:saveState value="#{attOvertimeApplyBB}"></x:saveState>
<h:inputHidden value="#{attOvertimeApplyBB.inputInit}"/>
<h:form id="form1" enctype="multipart/form-data">
	<h:inputHidden id="personType" value="#{attOvertimeApplyBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{attOvertimeApplyBB.personTypeValue}"/>
     <c:verbatim>
       <table height=100% width=100% align="center">
       <tr><td height=1>
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
	    <h:panelGrid align="right" columns="1">
	       <h:panelGroup>
            <h:outputText value="开始日期："></h:outputText>
            <h:inputText id="beginDate" value="#{attOvertimeApplyBB.beginDate}" styleClass="input" size="10"/>
            <h:commandButton onclick="return setData(0);" styleClass="button_select" value=""/>
            <h:outputText value="结束日期："></h:outputText>
            <h:inputText id="endDate" value="#{attOvertimeApplyBB.endDate}" styleClass="input" size="10"/>
            <h:commandButton onclick="return setData(1);" styleClass="button_select" value=""/>
            <h:outputText value="  "/>
            <h:outputText value="姓名或编号"/>
            <h:inputText value="#{attOvertimeApplyBB.nameStr}" styleClass="input" size="10"/> 
            <h:commandButton styleClass="button01" value="人员类别" onclick="return forSel();" action="#{attOvertimeApplyBB.doQuery}"/>
            <h:commandButton styleClass="button01" value="查询" action="#{attOvertimeApplyBB.doQuery}"/> 
            <h:outputText value="  "/>
            <h:commandButton value="添加加班"  styleClass="button01" onclick="add()"/>
            <h:commandButton styleClass="button01" value="加班导入" onclick="return forUplod();"/>
	      </h:panelGroup>
	    </h:panelGrid>
	    <h:panelGrid align="right" columns="1">
	       <h:panelGroup>
	          <h:outputText value="记录数:#{attOvertimeApplyBB.mypage.totalRecord}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="页数:#{attOvertimeApplyBB.mypage.totalPage}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="每页有#{attOvertimeApplyBB.mypage.pageSize}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="当前为第#{attOvertimeApplyBB.mypage.currentPage}页"></h:outputText>
		     		<h:commandButton value="首页" action="#{attOvertimeApplyBB.first}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="上页" action="#{attOvertimeApplyBB.pre}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="下页" action="#{attOvertimeApplyBB.next}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="尾页" action="#{attOvertimeApplyBB.last}" styleClass="button01"></h:commandButton>
		      </h:panelGroup>
	    </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
      
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{attOvertimeApplyBB.list}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="员工编号"/></c:facet>
            <h:outputText value="#{list.personCode}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
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
            <c:facet name="header"><h:outputText value="加班时间/时"/></c:facet>
            <h:outputText value="#{list.applyDays*8}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="创建时间"/></c:facet>
            <h:outputText value="#{list.applyTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="原因"/></c:facet>
            <h:outputText value="#{list.reason}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="删除"  styleClass="button01" onclick="return confirm('确定删除吗');" action="#{attOvertimeApplyBB.deleteInput}">
            	<x:updateActionListener value="#{list.id}" property="#{attOvertimeApplyBB.operItemID}"></x:updateActionListener>
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