<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page import="com.hr319wg.common.Constants" %>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function SetProbation() {
    window.showModalDialog("/employee/AppORDismiss/orgApporDisEdit.jsf", null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function selPerson(){
	window.showModalDialog("/employee/AppORDismiss/selApporDisPerson.jsf", null, "dialogWidth:400px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function selectPerson(){
	  var str=" |";
    chk=document.forms(0).selectItem;
    if (checkMutilSelect(chk)){
        var size = chk.length;
        if (size == null) {
            if (chk.checked) {
                str+=chk.value;
            }
        } else {
            for (var i = 0; i < size; i++) {
                if (chk[i].checked) {
                    if (i==0){
                        str+=chk[i].value;
                    }
                    else{
                        str+=","+chk[i].value;
                    }
                }
            }
        }
       if(str != null && str!=""){
      	 var vars=str.split("|");
      	 document.all("form1:personStr").value = vars[1];
      }
    }
}
function shengxiao(){
	 var str=" |";
	    chk=document.forms(0).selectItem;
	    if (checkMutilSelect(chk)){
	        var size = chk.length;
	        if (size == null) {
	            if (chk.checked) {
	                str+=chk.value;
	            }
	        } else {
	            for (var i = 0; i < size; i++) {
	                if (chk[i].checked) {
	                    if (i==0){
	                        str+=chk[i].value;
	                    }
	                    else{
	                        str+=","+chk[i].value;
	                    }
	                }
	            }
	        }
	       if(str != null && str!=""){
	      	 var vars=str.split("|");
	      	 window.showModalDialog("/employee/AppORDismiss/ValidApporDisPerson.jsf?pids="+vars[1], null, "dialogWidth:400px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
	         return true;
	       }
	 }else{
		 alert("选择人员生效！");
		 return false;
	 }
	    
}
function selectPerson2(id){
    window.showModalDialog("/employee/AppORDismiss/apporDisWageEdit.jsf?changeId="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function selectPerson3(id){
    window.showModalDialog("/employee/AppORDismiss/apporDisWageEdit2.jsf?changeId="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function showTable(changId){
	url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+changId+"&ORGUID=&Parameter=&Title=";
	window.open(url);
}
</script>

<x:saveState value="#{empApporDisMgrBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{empApporDisMgrBB.pageInit}" />
	<h:inputHidden id="personStr" value="" />
	<f:verbatim>
		<table height=96% width=100%>
			<tr>
				<td height=8>
					<table align="center" border="0" cellpadding="0" cellspacing="0"
						width=100% bgcolor="#FFFFFF">
						<tr>
							<td class=td_title>
                                <img src="/images/tips.gif" alt="">
                                <%=LanguageSupport.getResource("RYGL-0300", "人员管理")%>->
								<%=LanguageSupport.getResource("RYGL-2031", "任免管理")%>
							</td>
							<td align="right" class=td_title>
       </f:verbatim>
                                <h:commandButton	value="薪酬变动项目设置" styleClass="button01"
									onclick="return SetProbation()" />
                                <h:outputText value="  "></h:outputText>
								<h:commandButton value="报批" styleClass="button01"
									onclick="selectPerson();" action="#{empApporDisMgrBB.approvid}"
									rendered="#{empApporDisMgrBB.mustApprov=='0'}" /> 
                                <h:outputText		value="  "></h:outputText>
                                <h:commandButton value="人事信息生效"	styleClass="button01" onclick="shengxiao()" />
                            <f:verbatim>
							</td>
							<td align="right" class=td_title>
									<%=LanguageSupport.getResource("RYGL-2032", "拟定")%>
							</f:verbatim>
                                  <h:selectBooleanCheckbox value="#{empApporDisMgrBB.apply}"
									onclick="submit();"
									valueChangeListener="#{empApporDisMgrBB.queryApply}" /> <h:outputText
									value=" " rendered="#{empApporDisMgrBB.mustApprov=='0'}" />
                             <f:verbatim>
									<% if ("0".equals(Constants.EMP_DIRECT_POSITION_CHANGE))  out.print(LanguageSupport.getResource("RYGL-2033", "审批"));%>
							 </f:verbatim>
                                    <h:selectBooleanCheckbox value="#{empApporDisMgrBB.apprving}"
									onclick="submit();"
									valueChangeListener="#{empApporDisMgrBB.queryApprving}"
									rendered="#{empApporDisMgrBB.mustApprov=='0'}" /> <h:outputText
									value=" " rendered="#{empApporDisMgrBB.mustApprov=='0'}" />
                              <f:verbatim>
									<% if ("0".equals(Constants.EMP_DIRECT_POSITION_CHANGE)) out.print(LanguageSupport.getResource("RYGL-2034", "批准"));%>
								</f:verbatim> <h:selectBooleanCheckbox value="#{empApporDisMgrBB.apprived}"
									onclick="submit();"
									valueChangeListener="#{empApporDisMgrBB.queryApprived}"
									rendered="#{empApporDisMgrBB.mustApprov=='0'}" /> <h:outputText
									value=" " /> <f:verbatim>
									<%=LanguageSupport
							.getResource("RYGL-2035", "人事信息生效")%>
								</f:verbatim> <h:selectBooleanCheckbox value="#{empApporDisMgrBB.efficent}"
									onclick="submit();"
									valueChangeListener="#{empApporDisMgrBB.queryEfficent}" /> <h:outputText
									value=" " /> <f:verbatim>
									<%=LanguageSupport.getResource("RYGL-2036", "工资调整")%>
								</f:verbatim> <h:selectBooleanCheckbox value="#{empApporDisMgrBB.wageChange}"
									onclick="submit();"
									valueChangeListener="#{empApporDisMgrBB.queryWageChange}" /> <h:outputText
									value=" " rendered="#{empApporDisMgrBB.mustApprov=='0'}" /> <h:outputText
									value="退回" rendered="#{empApporDisMgrBB.mustApprov=='0'}" /> <h:selectBooleanCheckbox
									value="#{empApporDisMgrBB.refuse}" onclick="submit();"
									valueChangeListener="#{empApporDisMgrBB.queryRsfuse}"
									rendered="#{empApporDisMgrBB.mustApprov=='0'}" /> <f:verbatim>
							</td>
						</tr>
					</table></td>
			</tr>

			<tr>
				<td height=8>
					<table width="95%">
						<tr>
							<td align="right"></f:verbatim> <f:verbatim>
									<%=LanguageSupport.getResource("XTGL-1243", "时间")%>:
    	     </f:verbatim> <h:inputText value="#{empApporDisMgrBB.time}" id="time"
									readonly="true" alt="日期|1|d|50||"></h:inputText> <f:verbatim>
									<input type="button" class="button_select"
										onclick="PopUpCalendarDialog('form1:time')">
								</f:verbatim> <f:verbatim>
									<%=LanguageSupport.getResource("XTGL-1242", "至")%>:
    	     </f:verbatim> <h:inputText value="#{empApporDisMgrBB.time2}" id="time2"
									readonly="true" alt="日期|1|d|50||"></h:inputText> <f:verbatim>
									<input type="button" class="button_select"
										onclick="PopUpCalendarDialog('form1:time2')">
								</f:verbatim> <h:commandButton value="查询" styleClass="button01"
									action="#{empApporDisMgrBB.queryEmpPostChangeList}"></h:commandButton>
								<f:verbatim>
							</td>
							<td align="right"></f:verbatim> <h:panelGroup>
									<h:selectOneMenu id="ReportID" style="width:190px">
										<c:selectItems value="#{empApporDisMgrBB.regTableList}" />
									</h:selectOneMenu>
									<h:outputText value=" "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1043","记录数")%>:
    	         </f:verbatim>
									<h:outputText value="#{empApporDisMgrBB.mypage.totalRecord}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1044", "页数")%>:
    	        </f:verbatim>
									<h:outputText value="#{empApporDisMgrBB.mypage.totalPage}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1045",
								"每页有")%>:
    	        </f:verbatim>
									<h:outputText value="#{empApporDisMgrBB.mypage.pageSize}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1046",
								"当前为第")%>:
    	        </f:verbatim>
									<h:outputText value="#{empApporDisMgrBB.mypage.currentPage}页"></h:outputText>
									<h:commandButton value="首页" action="#{empApporDisMgrBB.first}"
										styleClass="button01"></h:commandButton>
									<h:commandButton value="上页" action="#{empApporDisMgrBB.pre}"
										styleClass="button01"></h:commandButton>
									<h:commandButton value="下页" action="#{empApporDisMgrBB.next}"
										styleClass="button01"></h:commandButton>
									<h:commandButton value="尾页" action="#{empApporDisMgrBB.last}"
										styleClass="button01"></h:commandButton>
									<h:outputText value="  "></h:outputText>
									<h:commandButton value="选择人员" styleClass="button01"
										onclick="return selPerson()" />
								</h:panelGroup> <f:verbatim>
							</td>
						</tr>
					</table></td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</f:verbatim>
						<h:dataTable value="#{empApporDisMgrBB.empAppordissList}"
							var="list" align="center" id="dateList"
							headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="95%">
							<h:column>
								<f:facet name="header">
									<f:verbatim escape="false">
										<input type="checkbox" name="all"
											onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)" />
									</f:verbatim>
								</f:facet>
								<f:verbatim escape="false">
									<div align="center">
										<input type="checkbox" name="selectItem"
											value="</f:verbatim>
                    <h:outputText value="#{list.changeId}"/>
                    <f:verbatim escape="false">" />
									</div>
								</f:verbatim>
							</h:column>

							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										<%=LanguageSupport.getResource("RYGL-1016", "姓名")%>
    	    					  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.personName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
							     <f:verbatim>
										<%=LanguageSupport.getResource("RYGL-20255", "原职务")%>
    	    					  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.oldJob}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								 <f:verbatim>
										<%=LanguageSupport.getResource("RYGL-2026", "新职务")%>
    	    					  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.newJob}" />
							</h:column>
							<h:column>
								<c:facet name="header">
							    <f:verbatim>
										<%=LanguageSupport.getResource("RYGL-2040", "是否初任")%>
    	    					  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.firstApp}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								    <f:verbatim>
										<%=LanguageSupport.getResource("RYGL-2039", "任职方式")%>
    	    					  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.appMod}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								     <f:verbatim>
										<%=LanguageSupport.getResource("RYGL-2038", "拟定时间")%>
    	    					  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.applyDate}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								 <f:verbatim>
										<%=LanguageSupport.getResource("XTGL-1297", "生效时间")%>
    	    					  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.hrValidDate}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								    <f:verbatim>
										<%=LanguageSupport.getResource("RYGL-2037", "薪资调整时间")%>
    	    					  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.wageValidDate}" />
							</h:column>
							<h:column rendered="#{empApporDisMgrBB.mustApprov=='0'}">
								<c:facet name="header">
								 <f:verbatim>
										<%=LanguageSupport.getResource("RYGL-2028", "初审意见")%>
    	    					  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.auditResultDes}" />
							</h:column>
							<h:column rendered="#{empApporDisMgrBB.mustApprov=='0'}">
								<c:facet name="header">
								  <f:verbatim>
										<%=LanguageSupport.getResource("RYGL-2029", "复审意见")%>
    	    					  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.auditResultDes1}" />
							</h:column>
							<h:column rendered="#{empApporDisMgrBB.mustApprov=='0'}">
								<c:facet name="header">
								    <f:verbatim>
										<%=LanguageSupport.getResource("RYGL-2030", "终审意见")%>
    	    					  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.auditResultDes2}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								  <f:verbatim>
										<%=LanguageSupport.getResource("XTGL-1051", "状态")%>
    	    					  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.statusDes}" />
							</h:column>
							<h:column>
								<c:facet name="header">
							        <f:verbatim>
										<%=LanguageSupport.getResource("YXGL-1026", "操作")%>
    	    					    </f:verbatim>
								</c:facet>
								<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
									action="#{empApporDisMgrBB.delete}" styleClass="button01"
									rendered="#{list.status=='0'}">
									<x:updateActionListener value="#{list.changeId}"
										property="#{empApporDisMgrBB.changeId}"></x:updateActionListener>
								</h:commandButton>
								<h:commandButton value="查看流程"
									onclick="return showWorkFlowLogByLinkID('#{list.changeId}')"
									styleClass="button01"
									rendered="#{empApporDisMgrBB.mustApprov=='0'}"></h:commandButton>
								<h:commandButton value="拟定薪资" styleClass="button01"
									onclick="return selectPerson2('#{list.changeId}');"
									rendered="#{list.status=='0'}" />
								<h:commandButton value="查看薪资" styleClass="button01"
									onclick="return selectPerson3('#{list.changeId}');"
									rendered="#{list.status!='0'}" />
								<h:commandButton value="显示表格" styleClass="button01"
									onclick="return showTable('#{list.changeId}');" />
							</h:column>
						</h:dataTable>
						<f:verbatim>
					</div></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>