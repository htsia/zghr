<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function doWork() {
		var perIds = "";
		if (checkMutilSelect(document.forms(0).chk)) {
			var obj = document.forms(0).chk;
			var size = obj.length;
			if (size == null) {
				if (obj.checked) {
					perIds += obj.value + ",";
				}
			} else {
				for ( var i = 0; i < size; i++) {
					if (obj[i].checked) {
						perIds += obj[i].value + ",";
					}
				}

			}
			if (perIds != "") {
				perIds = perIds.substr(0, perIds.length - 1);
			}
		}
		if (perIds.length <= 0) {
			alert("请选择人员。");
			return false;
		} else {
			var duraID = document.all('form1:duraID').value;
			window.showModalDialog(
					"/attence/PeriodSetDayCollection.jsf?personId=" + perIds
							+ "&attenceDate=" + perIds + "&duraID=" + duraID,
					"", "dialogWidth:" + screen.width * 1.0
							+ "px; dialogHeight:" + screen.height * 1.0
							+ "px; status:0;resizable:yes");
		}
		return true;
	}

	function doWork1() {
		var perIds = "";
		if (checkMutilSelect(document.forms(0).chk)) {
			var obj = document.forms(0).chk;
			var size = obj.length;
			if (size == null) {
				if (obj.checked) {
					perIds += obj.value + ",";
				}
			} else {
				for ( var i = 0; i < size; i++) {
					if (obj[i].checked) {
						perIds += obj[i].value + ",";
					}
				}
			}
			if (perIds != "") {
				perIds = perIds.substr(0, perIds.length - 1);
			}
		}
		if (perIds.length <= 0) {
			alert("请选择人员。");
			return false;
		} else {
			var duraID = document.all('form1:duraID').value;
			window.showModalDialog(
					"/attence/PeriodSetMonthCollection.jsf?personId=" + perIds
							+ "&attenceDate=" + perIds + "&duraID=" + duraID,
					"", "dialogWidth:" + screen.width * 1.0
							+ "px; dialogHeight:" + screen.height * 1.0
							+ "px; status:0;resizable:yes");
		}
		return true;
	}

	function refreshload() {
		setTimeout('myrefresh()', 1000);
	}

	function doAddItem() {
		var duraID = form1.all("form1:duraID").value;
		var beginTime = form1.all("form1:beginTime").value;
		var endTime = form1.all("form1:endTime").value;
		window
				.showModalDialog("/attence/PeriodSetAttCaclInfo.jsf?duraID="
						+ duraID + "&beginTime=" + beginTime + "&endTime="
						+ endTime, "",
						"dialogWidth:"+screen.width*1.0+"px; dialogHeight:"+screen.height*1.0+"px; status:0;resizable:yes");
	}
	function doAddItem1() {
		var perIds = "";
		var field=form1.chk;
		if(field==null){
	        alert("先进行全部汇总！");
	        return false;
		}
	    size = field.length;
	    var flag = 0;
	    if (size != null) {
	        for (i = 0; i < size; i++) {
	            if (field[i].checked == true) {
	                flag = flag + 1;
	                if (flag == 1)
	                	perIds = field[i].value;
	                if (flag > 1)
	                    break;
	            }
	        }
	    }
	    else{
	        if (field.checked){
	        	perIds = field.value;
	            flag = flag + 1;
	         }
	         else {
	             alert("没有任何选择！");
	             return false;
	         }
	    }
	    if (flag==0){
	        alert("没有任何选择！");
	        return false;
	    }
	    else if (flag > 1) {
	        alert("只能选择一个！");
	        return false;
	    }
				var duraID = form1.all("form1:duraID").value;
				var beginTime = form1.all("form1:beginTime").value;
				var endTime = form1.all("form1:endTime").value;
				window
						.showModalDialog("/attence/PeriodSetAttCaclInfo.jsf?duraID="
								+ duraID + "&beginTime=" + beginTime + "&endTime="
								+ endTime+"&perIdsValue="+perIds, "",
								"dialogWidth:"+screen.width*1.0+"px; dialogHeight:"+screen.height*1.0+"px; status:0;resizable:yes");
		return true;
	}
</script>
<x:saveState value="#{periodsetopenBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{periodsetopenBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="personList" value="#{periodsetopenBB.personList}" />
	<f:verbatim>
		<input type="hidden" name="sessionFlag" value="2">
		<table id=t1 height=98% width="100%" border="0" cellspacing="0"
			cellpadding="0">
			<tr>
				<td class="td_page" height=8></f:verbatim> <h:panelGrid columns="4"
					align="left">
					<h:panelGroup>
						<h:outputText value="当前所在机构:" />
						<h:outputText value="【#{periodsetopenBB.superName}】"></h:outputText>
					</h:panelGroup>

					<h:panelGroup>
						<h:commandButton value="全部汇总" styleClass="button01" onclick="showProcessBar();" action="#{periodsetopenBB.calc}"/>
						<h:commandButton value="单人汇总" styleClass="button01"
							rendered="#{periodsetopenBB.status=='0' || periodsetopenBB.status=='1'}"
							onclick="doAddItem1();"></h:commandButton>
						<h:commandButton value="结束汇总" styleClass="button01"
							onclick="return confirm('确定要结束考勤汇总吗?');"
							rendered="#{periodsetopenBB.status=='0' || periodsetopenBB.status=='1'}"
							action="#{periodsetopenBB.cacl1}">
						</h:commandButton>
					</h:panelGroup>
					<h:panelGroup>
						<h:commandButton value="查看日汇总" onclick="return doWork();"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="查看打卡" onclick="return doWork1();"
							styleClass="button01"></h:commandButton>
						<h:outputText value="姓名或员工编号："></h:outputText>
						<h:inputText id="name" value="#{periodsetopenBB.name}" size="10"
							styleClass="input" onkeypress="enterKeyDown('form1:queryPerson')" />
						<h:commandButton value="查询" id="queryPerson" styleClass="button01"
							action="#{periodsetopenBB.doQuery}" />
					</h:panelGroup>
					<h:commandButton styleClass="button01" value="返回"
						onclick="window.close();" />
				</h:panelGrid> <f:verbatim></td>

				<td class="td_page" height=8></td>
			</tr>

			<tr>
				<td colspan=2><jsp:include
					page="../common/activepage/ActiveList.jsp">
					<jsp:param name="hasOperSign" value="true" />
					<jsp:param name="operSignType" value="checkbox" />
					<jsp:param name="hasEdit" value="true" />
					<jsp:param name="isEditList" value="false" />
					<jsp:param name="isCheckRight" value="true" />
					<jsp:param name="isForward" value="true" />
					<jsp:param name="isRow" value="false" />
					<jsp:param name="isPage" value="true" />
					<jsp:param name="fixcol" value="4" />
				</jsp:include></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<form id="form2"><input type="hidden" name="perids" /></form>
<marquee id="processbar"
	style="position: absolute; display: none; border: 1px solid #000000"
	direction="right" width="300" scrollamount="5" scrolldelay="10"
	bgcolor="#ECF2FF">
<table cellspacing="1" cellpadding="0">
	<tr height=8>
		<td bgcolor=#3399FF width=8></td>
		<td></td>
		<td bgcolor=#3399FF width=8></td>
		<td></td>
		<td bgcolor=#3399FF width=8></td>
		<td></td>
		<td bgcolor=#3399FF width=8></td>
		<td></td>
	</tr>
</table>
</marquee>
<script type="text/javascript">
	interpret(document.forms(0));
	
	function showProcessBar() {
	    x = document.body.clientWidth / 2 - 150;
	    y = document.body.clientHeight / 2;
	    document.all('processbar').style.top = y;
	    document.all('processbar').style.left = x;
	    document.all('processbar').style.display = "";
	}
</script>