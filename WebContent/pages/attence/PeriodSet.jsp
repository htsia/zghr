<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function PunshCardmanager(yearManager,monthManager){
    window.showModalDialog("/custom/attence/attLogMgr.jsf", "", "dialogWidth:1100px; dialogHeight:600px; status:0;resizable:yes");
    return true;
}
		function PeriodSetSee(id,id1,id2,id3){
		    window.showModalDialog("/attence/PeriodSetOpen.jsf?orgID="+id+"&duraYear="+id1+"&duraMonth="+id2+"&duraID="+id3+"&see=see", "", "dialogWidth:"+screen.width*1.0+"px; dialogHeight:"+screen.height*1.0+"px; status:0;resizable:yes");
		    return true;
		}
function PeriodSetOpen(orgID,duraID,isView){
    window.showModalDialog("/custom/attence/attCalcMgr.jsf?dID="+duraID+"&isView="+isView, "", "dialogWidth:"+screen.width*1.0+"px; dialogHeight:"+screen.height*1.0+"px; status:0;resizable:yes");
    return true;
}
         function addRecuNeed(){
             window.showModalDialog("/attence/PeriodSetEdit.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:350px; dialogHeight:230px; status:0;resizable:yes");
             return true;
         }
function modify(id,id1){
    window.showModalDialog("/attence/PeriodSetEdit.jsf?duraID="+id+"&oid="+id1, "", "dialogWidth:350px; dialogHeight:230px; status:0;resizable:yes");
    return true;
}
function caclrule(){
    window.showModalDialog("/attence/attcaclrule.jsf", "", "dialogWidth:350px; dialogHeight:230px; status:0;resizable:yes");
    return true;
}
function verify(ym){
    window.showModalDialog("/custom/attence/attCalcRestulVerify.jsf", "", "dialogWidth:1100px; dialogHeight:600px; status:0;resizable:yes");
}
</script>
<x:saveState value="#{period_setBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{period_setBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{period_setBB.superId}"></h:inputHidden>
	<c:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td class="td_title"><img src="/images/tips.gif">���ڹ��� -> ���ڼ���</td>
			</tr>
		</table>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <br />
				<h:panelGrid width="98%" columns="2">
					<h:panelGrid align="right" columns="3">
						<h:panelGroup>
							<h:outputText value="��¼��:#{period_setBB.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="ҳ��:#{period_setBB.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="ÿҳ��#{period_setBB.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText value="��ǰΪ��#{period_setBB.mypage.currentPage}ҳ"></h:outputText>

							<h:commandButton value="��ҳ" action="#{period_setBB.first}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ" action="#{period_setBB.pre}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ" action="#{period_setBB.next}"
								styleClass="button01"></h:commandButton>
							<h:commandButton value="βҳ" action="#{period_setBB.last}"
								styleClass="button01"></h:commandButton>
						</h:panelGroup>
						<h:commandButton value="����" onclick="return addRecuNeed();"
							styleClass="button01"></h:commandButton>
					</h:panelGrid>
					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{period_setBB.attenceSetList}" var="list"
					rowIndexVar="index" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="90%" border="0">

					<h:column>
						<c:facet name="header">
							<h:outputText value="���" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="�������" />
						</c:facet>
						<h:outputText value="#{list.duraYear}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="�����¶�" />
						</c:facet>
						<h:outputText value="#{list.duraMonth}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��ʼ����" />
						</c:facet>
						<h:outputText value="#{list.duraBegin}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="��ֹ����" />
						</c:facet>
						<h:outputText value="#{list.duraEnd}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="������ѯ����" />
						</c:facet>
						<h:outputText value="#{list.qryName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:commandButton value="��ȡ�򿨼�¼"
							onclick="return PunshCardmanager('#{list.duraBegin}','#{list.duraEnd}');"
							styleClass="button01" rendered="#{list.status=='0'}"
							></h:commandButton>
						<h:commandButton value="����"
							onclick="return PeriodSetOpen('#{list.orgID}','#{list.duraID}',0);"
							styleClass="button01"
							rendered="#{list.status=='0'}"></h:commandButton>
						<h:commandButton value="����" styleClass="button01" onclick="return confirm('ȷ��Ҫ������');"
							action="#{period_setBB.issue}" rendered="#{list.status=='0'}">
							<x:updateActionListener property="#{period_setBB.duraID}"
								value="#{list.duraID}" />
						</h:commandButton>
						<h:commandButton value="���" styleClass="button01" onclick="verify('#{list.duraYear}#{list.duraMonth}')"
							rendered="#{list.status=='1'}"></h:commandButton>
						<h:commandButton value="���" styleClass="button01" onclick="return confirm('ȷ��Ҫ�����:');"
							action="#{period_setBB.end}" rendered="#{list.status=='1'}">
							<x:updateActionListener property="#{period_setBB.duraID}"
								value="#{list.duraID}" />
						</h:commandButton>
						<h:commandButton value="�鿴"
							onclick="return PeriodSetOpen('#{list.orgID}','#{list.duraID}',1);"
							styleClass="button01" rendered="#{list.status=='2'}"></h:commandButton>
						<h:commandButton value="�༭"
							onclick="return modify('#{list.duraID}','#{period_setBB.superId}')"
							styleClass="button01"
							rendered="#{list.status=='0' || list.status=='1'}"></h:commandButton>
						<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?ɾ���Ժ󣬱��μ���Ľ��Ҳ��һ��ɾ��');"
							action="#{period_setBB.delete}" styleClass="button01"
							rendered="#{list.status=='0' || list.status=='1'}">
							<x:updateActionListener property="#{period_setBB.duraID}"
								value="#{list.duraID}" />
						</h:commandButton>

					</h:column>
				</x:dataTable> <c:verbatim></div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
</body>




