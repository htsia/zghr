<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function doRptWageSet(){
        window.showModalDialog("/wage/payoff/RptWageSet.jsf", null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
    function showHis(dateid){
        window.showModalDialog("/wage/payoff/showComputerHis.jsf?dateID="+dateid, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
    function showHisData(dateid){
        window.showModalDialog("/wage/payoff/showDataInfo.jsf?dateID="+dateid, null, "dialogWidth:650px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }

    function showSum(unitId,setId,dateId,payoff){
        var url="/wage/payoff/ShowSumInfo.jsf?unitId="+unitId+"&setId="+setId+"&payoff="+payoff+"&dateId="+dateId;
        window.open(url,'','toolbar=0,height='+screen.height*0.8+',width='+screen.width*0.9+',top='+screen.height*0.1+',left='+screen.width*0.05);
        return false;
    }

    function forAddDate() {
        var setId = form1.all("form1:setId").value
        if(setId==null||setId==""){
            alert("��ѡ������");
            return false;
        }
        reval = window.showModalDialog("/common/DateEdit.jsf", null, "dialogWidth:450px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:no;");
        if (reval != null && reval != "") {
            var arg = reval.split("|");
            form1.all('form1:date').value = arg[0];
            form1.all('form1:yearMonth').value = arg[1];
            form1.all('form1:desc').value = arg[2];
            return true;
        } else {
            return false;
        }
    }
    function queryConstChange(){
       window.showModalDialog("/wage/payoff/showConstChange.jsf?setId=" + form1.all("form1:setId").value, null, "dialogWidth:460px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
    }
    function queryPersonChange(){
       window.showModalDialog("/wage/payoff/showPersonChange.jsf?setId=" + form1.all("form1:setId").value, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
    }
    function queryDeptChange(){
       window.showModalDialog("/wage/payoff/showDeptChange.jsf?setId=" + form1.all("form1:setId").value, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
    }

    function forFinanceDate() {
        var setId = form1.all("form1:setId").value
        if(setId==null||setId==""){
            alert("��ѡ������");
            return false;
        }
        reval = window.showModalDialog("/wage/payoff/DateFinanceItem.jsf?setId=" + setId, null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
        if (reval != null && reval != "") {
            form1.all("form1:str").value = reval;
            return true;
        } else {
            form1.all("form1:str").value = "cancel";
            return false;
        }
    }
    function doDetailPopup(id) {
        var dateId = id;
        popup = window.open("/wage/payoff/WageDetailView.jsf?dateId=" + dateId, "Ա�����ʷ�����ϸ", "height=520,width="+0.9*screen.width+",top="+0.05*screen.height+",left="+0.05*screen.width+",toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
        popup.focus();
    }
    function   doInputDetailPopup(id) {
        var dateId = id;
        popup = window.open("/wage/payoff/WageDetailView.jsf?OnlyinputItem=1&dateId=" + dateId, "Ա�����ʷ�����ϸ", "height="+0.9*screen.height+",width="+0.9*screen.width+",top="+0.05*screen.height+",left="+0.05*screen.width+",toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
        popup.focus();
    }
    function doNotePopup(id) {
        var dateId = id;
        popup = window.open("/wage/payoff/WageNoteView.jsf?dateId=" + dateId, "", "height=600,width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
        popup.focus();
    }
</script>

<x:saveState value="#{wage_dateBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{wage_dateBB.pageInit}" />
	<h:inputHidden id="str" value="" />
	<h:inputHidden id="date" value="#{wage_dateBB.date.date}" />
	<h:inputHidden id="desc" value="#{wage_dateBB.date.desc}" />
	<h:inputHidden id="yearMonth" value="#{wage_dateBB.date.yearMonth}" />

	<f:verbatim>
		<table height=96% width=100%>
			<tr>
				<td height=8>
					<table align="center" border="0" cellpadding="0" cellspacing="0"
						width=100% bgcolor="#FFFFFF">
						<tr>
							<td class=td_title></f:verbatim> <h:graphicImage value="/images/tips.gif" />
								<h:outputText value=" н����� ->  н����Ŀ¼�������" /> <f:verbatim>
							</td>
							<td class=td_title align="right"></f:verbatim> <h:outputText
									value="��н��λ��#{wage_dateBB.unitName}" /> <h:outputText
									value="  "></h:outputText> <h:outputText value="н�����ף�"></h:outputText>
								<h:selectOneMenu id="setId" value="#{wage_dateBB.setId}"
									onchange="submit()"
									valueChangeListener="#{wage_dateBB.queryDateList}">
									<c:selectItems value="#{wage_dateBB.setList}" />
								</h:selectOneMenu> <h:inputHidden id="setName" value="#{wage_dateBB.setName}" /> <f:verbatim>
							</td>
						</tr>

						<tr>
							<td class=td_title colspan=2 valign="bottom" align="center"></f:verbatim> <h:inputTextarea
									rows="6" cols="100" value="#{wage_dateBB.wageMemo}" /> <h:commandButton
									value="�������" styleClass="button01"
									action="#{wage_dateBB.saveWageMemo}"></h:commandButton> <h:commandButton
									value="����Ӧ" styleClass="button01" type="button"
									onclick="doRptWageSet();"></h:commandButton> <f:verbatim>
									<br>
							</td>
						</tr>
					</table>
				</td>
			</tr>

			<tr>
				<td height=8>
					<table width="95%">
						<tr>
							<td align="center"></f:verbatim> <h:outputText escape="false"
									value="��ʼʱ��" /> <h:panelGroup>
									<h:inputText value="#{wage_dateBB.startDate}" id="startDate"
										alt="��ʼʱ��|0|d" style="width:80px;"/>
									<h:commandButton type="button" styleClass="button_date"
										onclick="PopUpCalendarDialog('form1:startdate')" />
								</h:panelGroup> <h:outputText escape="false" value="����ʱ��" /> <h:panelGroup>
									<h:inputText value="#{wage_dateBB.endDate}" id="endDate"
										alt="����ʱ��|0|d" style="width:80px;"/>
									<h:commandButton type="button" styleClass="button_date"
										onclick="PopUpCalendarDialog('form1:endDate')" />
								</h:panelGroup> <h:commandButton value="��ѯ" action="#{wage_dateBB.dateList}"
									styleClass="button01"
									onclick="return forsubmit(document.forms(0))" /> <f:verbatim>
							</td>
							<td align="left"></f:verbatim> <h:commandButton value="��ʼ�·���"
									action="#{wage_dateBB.save}" styleClass="button01"
									rendered="#{wage_dateBB.canOperNew}"
									onclick="return forAddDate()" /> <h:commandButton
									value="���ò�������Ŀ" action="#{wage_dateBB.saveFinanceItem}"
									styleClass="button01" onclick="return forFinanceDate()"
									rendered="false" /> <h:commandButton type="button"
									styleClass="button01" value="��Ա�����䶯"
									onclick="queryPersonChange();"></h:commandButton> <h:commandButton
									type="button" styleClass="button01" value="н�ʲ��ű䶯"
									onclick="queryDeptChange();"></h:commandButton> <h:commandButton
									type="button" styleClass="button01" value="�����仯"
									onclick="queryConstChange();"></h:commandButton> <f:verbatim>
							</td>
						</tr>
					</table>
				</td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</f:verbatim>
						<h:dataTable value="#{wage_dateBB.dateList}" var="list"
							align="center" id="dateList" headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="100%">
							<h:column>
								<c:facet name="header">
									<h:outputText value="��������" />
								</c:facet>
								<h:outputText value="#{list.date}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									<h:outputText value="����" />
								</c:facet>
								<h:outputText value="#{list.desc}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									<h:outputText value="������ʱ��" />
								</c:facet>
								<h:outputText value="#{list.calcDate}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									<h:outputText value="����¼��" />
								</c:facet>
								<h:outputText value="#{list.forbidDes}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									<h:outputText value="״̬" />
								</c:facet>
								<h:outputText escape="false"
									value="<font color=red>#{list.status}</font>" />
							</h:column>

							<h:column rendered="#{wage_dateBB.name0651!=''}">
								<c:facet name="header">
									<h:outputText value="#{wage_dateBB.name0651}" />
								</c:facet>
								<h:outputText value="#{list.checkContent}" />
							</h:column>

							<h:column rendered="#{wage_dateBB.name0659!=''}">
								<c:facet name="header">
									<h:outputText value="#{wage_dateBB.name0659}" />
								</c:facet>
								<h:outputText value="#{list.taxCheckResultDes}" />
							</h:column>

							<h:column rendered="#{wage_dateBB.name0679!=''}">
								<c:facet name="header">
									<h:outputText value="#{wage_dateBB.name0679}" />
								</c:facet>
								<h:outputText value="#{list.taxCheckResultDes}" />
							</h:column>

							<h:column rendered="#{wage_dateBB.name0678!=''}">
								<c:facet name="header">
									<h:outputText value="#{wage_dateBB.name0678}" />
								</c:facet>
								<h:outputText value="#{list.taxAuditResultDes}" />
							</h:column>

							<h:column rendered="#{wage_dateBB.groupPayoff}">
								<c:facet name="header">
									<h:outputText value="���ŷ���״̬" />
								</c:facet>
								<h:outputText value="#{list.groupPayoffStatusDes}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									<h:outputText value="#{wage_dateBB.name0654}" />
								</c:facet>
								<h:outputText value="#{list.approveContent}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									<h:outputText value="����" />
								</c:facet>
								<h:panelGrid columns="5" align="center" cellspacing="2">
									<h:commandButton value="ɾ������" styleClass="button01"
										rendered="#{list.operDel}" action="#{wage_dateBB.delete}"
										onclick="return confirm('ȷ��ɾ����')">
										<x:updateActionListener property="#{wage_dateBB.date.dateId}"
											value="#{list.dateId}" />
									</h:commandButton>
									<h:commandButton value="�򿪷���"
										action="#{wage_computeBB.queryPersonBySetId}"
										styleClass="button01" rendered="#{list.operCompute}">
										<x:updateActionListener property="#{wage_computeBB.dateId}"
											value="#{list.dateId}" />
										<x:updateActionListener
											property="#{wage_computeBB.payoffDate}" value="#{list.date}" />
										<x:updateActionListener property="#{wage_computeBB.setId}"
											value="#{wage_dateBB.setId}" />
										<x:updateActionListener property="#{wage_computeBB.unitId}"
											value="#{wage_dateBB.unitId}" />
										<x:updateActionListener property="#{wage_computeBB.setName}"
											value="#{wage_dateBB.setName}" />
										<x:updateActionListener property="#{wage_computeBB.unitName}"
											value="#{wage_dateBB.unitName}" />
										<x:updateActionListener
											property="#{wage_computeBB.operCompute}"
											value="#{list.operCompute}" />
									</h:commandButton>
									<h:commandButton value="������־" type="button"
										onclick="showHis('#{list.dateId}');" styleClass="button01"
										rendered="#{list.operCompute || list.operView}" />
									<h:commandButton value="������־" type="button"
										onclick="showHisData('#{list.dateId}');" styleClass="button01"
										rendered="#{list.operCompute || list.operView}" />
									<h:commandButton value="�鿴��ϸ" styleClass="button01"
										rendered="#{list.operView}" type="button"
										onclick="doDetailPopup('#{list.dateId}')" />
									<f:verbatim>
										<br>
									</f:verbatim>

									<h:commandButton value="����¼��" styleClass="button01"
										rendered="#{list.operCompute && list.forbid=='1'}"
										action="#{wage_dateBB.UnLock}">
										<x:updateActionListener property="#{wage_dateBB.dateId}"
											value="#{list.dateId}" />
									</h:commandButton>

									<h:commandButton value="¼������" styleClass="button01"
										rendered="#{list.operInput}"
										action="#{wage_inputManagerBB.queryPersonBySetId}">
										<x:updateActionListener
											property="#{wage_inputManagerBB.dateId}"
											value="#{list.dateId}" />
										<x:updateActionListener
											property="#{wage_inputManagerBB.payoffDate}"
											value="#{list.date}" />
										<x:updateActionListener
											property="#{wage_inputManagerBB.setId}"
											value="#{wage_dateBB.setId}" />
										<x:updateActionListener
											property="#{wage_inputManagerBB.unitId}"
											value="#{wage_dateBB.unitId}" />
										<x:updateActionListener
											property="#{wage_inputManagerBB.setName}"
											value="#{wage_dateBB.setName}" />
										<x:updateActionListener
											property="#{wage_inputManagerBB.unitName}"
											value="#{wage_dateBB.unitName}" />
										<x:updateActionListener
											property="#{wage_inputManagerBB.operCompute}"
											value="#{list.operCompute}" />
										<x:updateActionListener
											property="#{wage_inputManagerBB.operAuditInput}"
											value="false" />
									</h:commandButton>


									<h:commandButton value="¼����ϸ" styleClass="button01"
										rendered="#{list.operViewInput}" type="button"
										onclick="doInputDetailPopup('#{list.dateId}')" />
									<h:commandButton value="�鿴����" id="showFlow" type="button"
										onclick="return showWorkFlowLogByLinkID('#{list.dateId}')"
										styleClass="button01" rendered="#{wage_dateBB.workFlow=='1'}"></h:commandButton>

								</h:panelGrid>
							</h:column>
						</h:dataTable>
						<f:verbatim>
					</div>
				</td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>