<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
        function selectBaseSet(){
            var reval = window.showModalDialog("/insurace/SelectType.jsf", null, "dialogWidth:200px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
            if (reval!=null && reval!=""){
                document.all("form1:calcSetString").value=reval;
                return true;
            }
            else{
                return false;
            }
        }
        function openYear() {
            var setId = form1.all("form1:setId").value;
            window.open("/insurace/openYearBaseInfoList.jsf?setId=" + setId, null, "width=300,height=300,resizable=yes,left=300,top=100");
            return true;
        }

        function forEdit(form, id, right) {
            var arg = "id=" + id;
            window.open("/pages/insurace/base/PersonInfoFrame.jsf?" + arg, null, "left=100,top=50,height=600,width=900,status=yes,toolbar=no,menubar=no,location=no,status=no,scroll=yes,resizable=yes");
            window.status = "";
        }
 
        function doCountBase(){
            var setName = form1.all("form1:setName").value;
            var unitId = form1.all("form1:unitId").value;
            var setId = form1.all("form1:setId").value;
            var arg = "setName=" + setName + "&unitId=" + unitId + "&setId=" + setId;
            reval = window.showModalDialog("/insurace/CountBase.jsf?" + arg, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
            if (reval != null) {
                return true;
            } else {
                return false;
            }
        }
        
        function forExport() {
          window.open('/pages/common/ExportToExcel.jsp');
        }
                
        function OpenRpt(){
            if (document.all("form1:ReportID").value=="-1"){
                alert("请先选择表格样式！");
                return false;
            }
            var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID=&ORGUID="+document.all("form1:unitId").value+"&Parameter="+document.all("form1:setId").value;

            window.open(url);
            return false;
        }
        function importBaseRate(){
            reval =window.showModalDialog("/insurace/import/PerDataUpload.jsf", null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
            if (reval != null) {
                return true;
            } else {
                return false;
            }
        }
        function inputBaseRate() {
            if (checkMutilSelect(form1.chk)) {
                count = form1.chk.length;
                var str = "";
                if (count != null) {
                    var num = 0;
                    for (i = 0; i < count; i++)
                        if (form1.chk[i].checked) {
                            str += form1.chk[i].value + ",";
                            num++;
                        }
                    if (num > 150) {
                        alert("最多只能选择150个人员");
                        return false;
                    }
                } else
                    str = form1.chk.value;
            
                var arg = "PerStr=" + str+"&inputField="+document.all('form1:inputField').value;
                reval = window.showModalDialog("/insurace/BaseRateInput.jsf?setId="+form1.all("form1:setId").value+"&"+arg, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
                if (reval != null) {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert("请选择人员");
                return false;
            }
        }

        function doCalc() {
            reval = window.showModalDialog("/insurace/calc.jsf?unitId="+document.all("form1:unitId").value+"&setId="+document.all("form1:setId").value, null, "dialogWidth:800px; dialogHeight:420px;center:center;resizable:yes;status:no;scroll:yes;");
            if (reval != null) {
                return true;
            } else {
                return false;
            }
        }

        function refreshList() {
             disPlayProcessBar();
            return true;
        }

        function doSelectInfoInput() {
            var allCount=120;
            if (checkMutilSelect(form1.chk)) {
                count = form1.chk.length;
                var str = "";
                if (count != null) {
                    var num = 0;
                    for (i = 0; i < count; i++)
                        if (form1.chk[i].checked) {
                            str += form1.chk[i].value.replace("#","~") + ",";
                            num++;
                        }
                    if (num > allCount) {
                        alert("最多只能选择"+allCount+"个人员");
                        return false;
                    }
                } else
                    str = form1.chk.value.replace("#","~");
                var reval = window.showModalDialog("/insurace/BaseRateInputEdit.jsf?SetID="+document.all('form1:setId').value+"&PerStr="+str, null, "dialogWidth:"+screen.width*0.85+"px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            } else {
                alert("请选择人员");
                return false;
            }
            return true;
        }
    </script>

<x:saveState value="#{ins_BaseInfoBB}" />

<h:form id="form1">
	<h:inputHidden value="#{ins_BaseInfoBB.pageInit}" />
	<h:inputHidden id="unitId" value="#{ins_BaseInfoBB.unitId}" />
	<h:inputHidden id="setName" value="#{ins_BaseInfoBB.setName}" />
	<h:inputHidden id="str" value="" />
	<h:inputHidden id="deptpower" value="#{ins_BaseInfoBB.deptpower}" />
	<f:verbatim>
		<table width=98% height=100% border=0 align="center">
			<tr>
				<td height=8px></f:verbatim> <h:panelGrid styleClass="td_title" width="100%"
					border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF"
					columns="2">
					<h:panelGroup>
						<h:graphicImage value="/images/tips.gif" />
						<h:outputText value=" 保险管理 ->  缴费基数设定" />
					</h:panelGroup>
				</h:panelGrid> <h:panelGrid columns="5" align="center" width="98%">
					<h:panelGroup>
						<h:outputText escape="false"
							value="<strong>发薪单位：</strong>#{ins_BaseInfoBB.unitName}" />
						<h:outputText value="   "></h:outputText>

						<h:panelGroup>
							<h:outputText escape="false" value="<strong>薪资账套：</strong>"></h:outputText>
							<h:selectOneMenu id="setId" value="#{ins_BaseInfoBB.setId}"
								onchange="disPlayProcessBar();submit()"
								valueChangeListener="#{ins_BaseInfoBB.changeSetId}">
								<c:selectItems value="#{ins_BaseInfoBB.setList}" />
							</h:selectOneMenu>
						</h:panelGroup>
					</h:panelGroup>

					<h:panelGroup>
						<h:selectOneMenu id="groupLevel"
							value="#{ins_BaseInfoBB.groupLevel}">
							<c:selectItem itemValue="DEPT_NAME" itemLabel="最细层次"></c:selectItem>
							<c:selectItem itemValue="HIGH_NAME" itemLabel="汇总1"></c:selectItem>
							<c:selectItem itemValue="HIGH_NAME2" itemLabel="汇总2"></c:selectItem>
							<c:selectItem itemValue="HIGH_NAME3" itemLabel="汇总3"></c:selectItem>
							<c:selectItem itemValue="HIGH_NAME4" itemLabel="汇总4"></c:selectItem>
						</h:selectOneMenu>
						<h:commandButton value="选择" styleClass="button01"
							action="#{ins_BaseInfoBB.changeLevel}"></h:commandButton>
						<h:selectOneMenu id="WageDept" value="#{ins_BaseInfoBB.dept}">
							<c:selectItems value="#{ins_BaseInfoBB.deptList}"></c:selectItems>
						</h:selectOneMenu>
						<h:commandButton styleClass="button01" value="过滤"
							action="#{ins_BaseInfoBB.queryInsuranceBySetId}"></h:commandButton>
					</h:panelGroup>

					<h:panelGrid align="right">
						<h:panelGroup>
                            <h:inputHidden id="calcSetString" value="#{ins_BaseInfoBB.calcSetString}"></h:inputHidden>
                            <h:commandButton value="通过基数计算缴费金额" onclick="return selectBaseSet();"
								action="#{ins_BaseInfoBB.calc}" styleClass="button01" />
							<h:commandButton value="导出Excel" type="button"
								onclick="forExport();" styleClass="button01" />
						</h:panelGroup>
					</h:panelGrid>
				</h:panelGrid> <h:panelGrid columns="6" align="center" width="98%">
					<h:panelGroup>
						<h:selectOneMenu id="ReportID" style="width:150px">
							<c:selectItems value="#{ins_BaseInfoBB.reportList}" />
						</h:selectOneMenu>
						<h:commandButton value="显示" styleClass="button01" type="button"
							onclick="return OpenRpt();"></h:commandButton>
					</h:panelGroup>

					<h:panelGrid columns="5" align="right">
						<h:outputText value="姓名或编号:" />
						<h:inputText value="" id="nameStr" />
						<h:commandButton id="query" value="查询"
							action="#{ins_BaseInfoBB.queryPersonByNameStr}"
							styleClass="button01" />
						<h:commandButton value="高级查询" styleClass="button01"
							action="#{ins_BaseInfoBB.queryAdvance}"
							onclick="return doAdvanceQuery('A','ORG','011','Y','','','N','152','N')" />
					</h:panelGrid>

					<h:panelGroup>
						<h:commandButton value="基数测算"
							action="#{ins_BaseInfoBB.queryInsuranceBySetId}"
							onclick="doCountBase();" rendered="#{ins_BaseInfoBB.operApply}" styleClass="button01" />
						<h:commandButton value="导入基数" rendered="false"
							onclick="return importBaseRate();" styleClass="button01"></h:commandButton>
						<h:outputText value="   "></h:outputText>

						<h:selectOneMenu id="inputField"
							value="#{ins_BaseInfoBB.inputField}">
							<c:selectItems value="#{ins_BaseInfoBB.inputList}"></c:selectItems>
						</h:selectOneMenu>
						<h:commandButton value="修改"
							action="#{ins_BaseInfoBB.queryInsuranceBySetId}"
							styleClass="button01" onclick="return inputBaseRate();"></h:commandButton>
						<h:commandButton value="录入新基数" onclick="return doSelectInfoInput();"  styleClass="button01" action="#{ins_BaseInfoBB.queryPersonByNameStr}"/>
						<h:commandButton value="开始新年度"
							action="#{ins_BaseInfoBB.queryInsuranceBySetId}"
							styleClass="button01" onclick="return openYear();"></h:commandButton>
					</h:panelGroup>

				</h:panelGrid> <f:verbatim></td>
			</tr>

			<tr>
				<td><jsp:include page="/pages/common/activepage/ActiveList.jsp">
					<jsp:param name="hasOperSign" value="true" />
					<jsp:param name="operSignType" value="checkbox" />
					<jsp:param name="hasEdit" value="true" />
					<jsp:param name="isEditList" value="false" />
					<jsp:param name="isCheckRight" value="true" />
					<jsp:param name="isForward" value="true" />
					<jsp:param name="isRow" value="true" />
					<jsp:param name="rowFuncName" value="forEdit" />
					<jsp:param name="isPage" value="true" />
					<jsp:param name="fixcol" value="4" />
				</jsp:include></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
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

