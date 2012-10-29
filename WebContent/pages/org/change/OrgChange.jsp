<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
	String flag = (String) request.getAttribute("flag");
%>

<script type="text/javascript">
    function selectNewSuper(){
        if (document.all('form1:changeOrg').value==""){
            alert("还没有选择要变更的机构！");
            return false;
        }
        PopUpOrgDlgShowGroup('form1:superOrg',2,'');
        document.all('form1:superOrgtext').value=document.all('form1:superOrg').value;
        document.all('form1:superOrg').value=document.all('form1:superOrg').code;
        document.all('form1:B705720').value="主管机构由"+document.all('form1:oldSuper').value+"变为"+document.all('form1:superOrgtext').value;
    }
    function selOrg(obj) {
        var obj1 = document.all(obj);
        PopUpOrgDlg(obj, 2, '');
        obj1.value = obj1.code;
        document.all("form1:getChange").click();
    }
    function forSelect(form1, rootId) {
        if (rootId == null) {
            rootId = "";
        }
        showx = event.screenX - event.offsetX - 150;
        showy = event.screenY - event.offsetY + 18;
        if(checkAll(form1)){
            retval = window.showModalDialog("/common/SelBackTreePerson.jsf?rootId=" + rootId+"&rightFlag=2", "", "dialogWidth:800px; dialogHeight:700px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
            pageCodeExchange(form1);
            document.all("form1:selPerson").click();
            return true;
        } else {
            return false;
        }
    }

    function selOldSuper() {
        PopUpOrgDlgShowGroup('form1:changeOrg', 2, "");
        document.all("form1:changeOrgtext").value = document.all("form1:changeOrg").value;
        document.all("form1:changeOrg").value = document.all("form1:changeOrg").code;
        document.all("form1:superOrg").value = "";
        document.all("form1:superOrg").code = "";
        document.all("form1:queryOldSuper").click();
    }
    function forsave(){
        // 全选人员
        document.form1.chkAll.checked=true;
        selectAll(document.form1.chkAll,document.form1.chk)
        return forsubmit(document.forms(0));
    }
</script>
<x:saveState value="#{org_orgChangeBB}"></x:saveState>
<h:form id="form1">
	<h:commandButton id="selPerson" action="#{org_orgChangeBB.selPerson}"
		style="display:none" />
	<h:commandButton style="display:none" id="queryOldSuper"
		action="#{org_orgChangeBB.queryOldSuper}" />
	<c:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF" align="center">
			<tr>
				<td class="td_title"><img src="/images/tips.gif" alt="">
					<%=LanguageSupport.getResource("JGGL-0106",
							" 主管机构变更")%></td>
				<td class="td_title" align="right"></c:verbatim> <h:commandButton
						value="保存" styleClass="button01" onclick="return forsave();"
						action="#{org_orgChangeBB.saveChange}" /> <c:verbatim>
				</td>
			</tr>
		</table>
		<br>
		<table width="95%" border="0" align="center" cellpadding="0"
			cellspacing="0" class="table03">
			<tr>
				<td width="90" class="td_form01 td_form_required"><%=LanguageSupport.getResource("JGGL-1045", "原机构")%>
				</td>
				<td class="td_form02"></c:verbatim> <h:inputHidden id="changeOrg"
						value="#{org_orgChangeBB.changeOrg}"></h:inputHidden> <h:inputText
						styleClass="input" id="changeOrgtext" readonly="true"
						alt="原机构|0|s|50||" /> <c:verbatim>
						<input type="button" class="button_select" onclick="selOldSuper()">
				</td>
				<td width="90" class="td_form01 td_form_required"><%=LanguageSupport.getResource("JGGL-1047", "原主管机构")%>
				</td>
				<td class="td_form02"></c:verbatim> <h:inputText styleClass="input"
						readonly="true" id="oldSuper" value="#{org_orgChangeBB.oldSuper}"
						alt="原主管机构|0|s|50||" /> <c:verbatim>
				</td>
				<td width="90" class="td_form01 td_form_required"><%=LanguageSupport.getResource("JGGL-1048",
							"新的主管机构")%>
				</td>
				<td class="td_form02"></c:verbatim> <h:inputHidden
						value="#{org_orgChangeBB.superOrg}" id="superOrg"></h:inputHidden>
					<h:inputText styleClass="input" id="superOrgtext" readonly="true"
						alt="主管机构|0|s|50||" /> <c:verbatim>
						<input type="button" class="button_select"
							onclick="selectNewSuper();">
				</td>
			</tr>
		</table>
		<br>
		<table width="95%" align=center border=0 cellpadding=0 cellspacing=0>
			<tr nowrap>
				<td class="f04"><%=LanguageSupport.getResource("JGGL-1046",	"机构变动信息")%>
				</td>
			</tr>
		</table>
		<table width="95%" align=center border=0 cellpadding=0 cellspacing=0
			class="table03">
			<tr nowrap>
				<td width="90" class="td_form01 td_form_required"><%=LanguageSupport.getResource("JGGL-1014", "变动类别")%>
				</td>
				<td class=td_form02></c:verbatim> <h:inputHidden id="B705701"
						value="#{org_orgChangeBB.orgchangevo.changeType}">
					</h:inputHidden> <h:inputText styleClass="input" id="B705701text" readonly="true"
						alt="变动类别|0|s|50||" /> <c:verbatim>
						<input type="button" class="button_select"
							onclick="PopUpCodeDlgTwoControl(document.all('form1:B705701'),document.all('form1:B705701text'),'0890')">
				</td>
				<td class="td_form01 td_form_required"><%=LanguageSupport.getResource("JGGL-1015", "变动时间")%>
				</td>
				<td class=td_form02></c:verbatim> <h:inputText styleClass="input"
						id="B705725" value="#{org_orgChangeBB.orgchangevo.changeTime}"
						readonly="true" alt="变动时间|0|s|50||" /> <c:verbatim>
						<input type="button" class="button_date"
							onclick="PopUpCalendarDlg_OnlyMonth('form1:B705725')">
				</td>
			</tr>
			<tr nowrap>
				<td class="td_form01 td_form_required"><%=LanguageSupport.getResource("JGGL-1016",
							"变动事项及原因")%>
				</td>
				<td class=td_form02 colspan="3"></c:verbatim> <h:inputText
						styleClass="input" id="B705720" size="80"
						value="#{org_orgChangeBB.orgchangevo.changeResult}"
						alt="变动原因|0|s|60||" /> <c:verbatim>
				</td>
			</tr>
			<tr nowrap>
				<td class="td_form01 "><%=LanguageSupport.getResource("JGGL-1017", "批准文号")%>
				</td>
				<td class=td_form02></c:verbatim> <h:inputText styleClass="input"
						id="B705730" value="#{org_orgChangeBB.orgchangevo.changeNo}"
						alt="批准文号|1|s|50||" /> <c:verbatim>
				</td>
				<td class="td_form01"><%=LanguageSupport.getResource("JGGL-1018", "批准单位")%>
				</td>
				<td class=td_form02></c:verbatim> <h:inputText styleClass="input"
						id="B705733" value="#{org_orgChangeBB.orgchangevo.agreeUnit}"
						alt="批准单位|1|s|50||" />
				</td>
				<c:verbatim>
			</tr>
		</table>
		<br>
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			align="center" id="per">
			<tr>
				<td align="left"><strong> <%=LanguageSupport.getResource("JGGL-1050",
							" 变更上级主管后,系统将为以下人员简历子集增加工作变动情况.")%>
				</strong></td>
				<td aling="right"><input name="mod1" type="button"
					class="button01"
					value="<%=LanguageSupport.getResource("JGGL-1049", " 增加人员")%> "
					onclick="forSelect(form1,document.all('form1:changeOrg').value)">
					</c:verbatim> <h:commandButton value="删除人员" styleClass="button01"
						action="#{org_orgChangeBB.delPerson}"></h:commandButton> <c:verbatim>
				</td>
			</tr>
			<tr>
				<td colspan=2 align="center"><br> </c:verbatim> <h:dataTable
						width="100%" value="#{org_orgChangeBB.personlist}" var="list"
						border="1" id="data" align="center" headerClass="td_top"
						rowClasses="td_middle" styleClass="table03">
						<h:column>
							<c:facet name="header">
								<c:verbatim escape="false">
									<input type="checkbox" name="chkAll"
										onclick="selectAll(document.form1.chkAll,document.form1.chk)" />
								</c:verbatim>
							</c:facet>
							<c:verbatim escape="false">
								<div align=center>
									<input type="checkbox" name="chk"
										value="</c:verbatim>
                    <h:outputText value="#{list.personId}"/><c:verbatim>">
								</div>
							</c:verbatim>
							<c:verbatim escape="false">
								<input type="hidden" name="perName"
									value="</c:verbatim><h:outputText value="#{list.name}"/><c:verbatim
                        escape="false">">
							</c:verbatim>
						</h:column>
						<h:column>
							<c:facet name="header">
							   <f:verbatim>
							     <%=LanguageSupport.getResource("MSG-0010","姓名")%>
							   </f:verbatim>
							</c:facet>
							<h:outputText value="#{list.name}" />
						</h:column>
						<h:column>
							<c:facet name="header">
							   <f:verbatim>
							      <%=LanguageSupport.getResource("MSG-0012","性别")%>
							   </f:verbatim>
							</c:facet>
							<h:outputText value="#{list.sex}" />
						</h:column>
						<h:column>
							<c:facet name="header">
							<f:verbatim>
							     <%=LanguageSupport.getResource("MSG-0013","出生日期")%>
							   </f:verbatim>
							</c:facet>
							<h:outputText value="#{list.birth}" />
						</h:column>
						<h:column>
							<c:facet name="header">
								<f:verbatim>
							     <%=LanguageSupport.getResource("JGGL-1024","所属机构")%>
							   </f:verbatim>
							</c:facet>
							<h:outputText value="#{list.orgId}" />
						</h:column>
						<h:column>
							<c:facet name="header">
							<f:verbatim>
							     <%=LanguageSupport.getResource("JGGL-1025","所属部门")%>
							   </f:verbatim>
							</c:facet>
							<h:outputText value="#{list.deptId}" />
						</h:column>
					</h:dataTable> <c:verbatim>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
    setDataTableOver("form1:data");
    if (document.all('form1:changeOrg').value=="") document.all('form1:changeOrgtext').value="";
    if (document.all('form1:superOrg').value=="") document.all('form1:superOrgtext').value="";
    if (document.all('form1:B705701').value=="") document.all('form1:B705701text').value="";
</script>
