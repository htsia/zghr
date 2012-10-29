<%@page import="com.hr319wg.sys.configuration.LanguageSupport"%>
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

        function forEdit(form, id, right) {
            var arg = "id=" + id;
            window.open("/pages/insurace/base/PersonInfoFrame.jsf?" + arg, null, "left=100,top=50,height=600,width=900,status=yes,toolbar=no,menubar=no,location=no,status=no,scroll=yes,resizable=yes");
            window.status = "";
        }
        
        function forExport() {
          window.open('/pages/common/ExportToExcel.jsp');
        }
                
        function OpenRpt(){
            if (document.all("form1:ReportID").value=="-1"){
                alert("请先选择表格样式！");
                return false;
            }
            var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value;

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
                var reval = window.showModalDialog("/insurace/BaseRateInputEdit.jsf?PerStr="+str, null, "dialogWidth:"+screen.width*0.85+"px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            } else {
                alert("请选择人员");
                return false;
            }
            return true;
        }
        function forSel() {
    	    PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'');
    	}
        function chkpersontype(){
        	var personType=document.all("form1:personType").value;
    	    if(personType==null || personType==""){
    	    	alert("请选择人员类别");
    	    	return false;
    	    }
    	    return true;
        }
        function forUploadFile() {
	        var arg = "moduleid=BXGL"
	        reval = window.showModalDialog("/employee/import/PerDataUpload.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
	        if (reval != null) {
	            return true;
	        } else {
	            return false;
	        }
	    }
    </script>

<x:saveState value="#{ins_BaseInfoBB}" />

<h:form id="form1">
	<h:inputHidden value="#{ins_BaseInfoBB.pageInit}" />
	<h:inputHidden id="str" value="" />
	<f:verbatim>
		<table width=98% height=100% border=0 align="center">
			<tr>
				<td height=8px>
				</f:verbatim>
				<h:panelGrid columns="5" align="center" width="98%">
						<h:panelGroup>
						<h:inputHidden id="personType" value="#{ins_BaseInfoBB.personType}"/>
	                    <h:inputHidden id="personTypeValue" value="#{ins_BaseInfoBB.personTypeValue}"/>
	                	<h:commandButton value="选择人员类别" onclick="forSel();"
							action="#{ins_BaseInfoBB.queryPersonByNameStr}" styleClass="button01" />   
<%-- 						<h:selectOneMenu id="ReportID" style="width:120px"> --%>
<%-- 							<c:selectItems value="#{ins_BaseInfoBB.reportList}" /> --%>
<%-- 						</h:selectOneMenu> --%>
<%-- 						<h:commandButton value="显示" styleClass="button01" type="button" --%>
<%-- 							onclick="return OpenRpt();"></h:commandButton> --%>
						<h:outputText value=" "></h:outputText>
<%-- 						<h:selectOneMenu id="yearStr"> --%>
<%-- 							<c:selectItems value="#{ins_BaseInfoBB.yearList}"></c:selectItems> --%>
<%-- 						</h:selectOneMenu> --%>
<%-- 						<h:commandButton id="filter" value="过滤" --%>
<%-- 							action="#{ins_BaseInfoBB.queryPersonByYearStr}" --%>
<!-- 							styleClass="button01" /> -->
						<h:outputText value=" "></h:outputText>
						<h:outputText value="姓名或编号:" />
						<h:inputText value="#{ins_BaseInfoBB.searchStr}" id="searchStr" styleClass="input" size="10"/>
						<h:commandButton id="query" value="查询" onclick="return chkpersontype();"
							action="#{ins_BaseInfoBB.queryPersonByNameStr}"
							styleClass="button01" />
						<h:outputText value=" "></h:outputText>
						<h:commandButton value="高级查询" styleClass="button01"
							action="#{ins_BaseInfoBB.queryAdvance}"
							onclick="return doAdvanceQuery('A','ORG','011','Y','','','N','152','N')" />
						<h:outputText value=" "></h:outputText>
						<h:commandButton value="导出Excel" type="button" onclick="forExport();" styleClass="button01" />
						<h:outputText value="  "/>	
						<h:commandButton value="录入新基数" onclick="return doSelectInfoInput();"  styleClass="button01" action="#{ins_BaseInfoBB.queryPersonByNameStr}"/>
						<h:commandButton styleClass="button01" value="数据导入" type="button" onclick="return forUploadFile()"/>
						<h:outputText value=" "></h:outputText>
                        <h:inputHidden id="calcSetString" value="#{ins_BaseInfoBB.calcSetString}"></h:inputHidden>
                        <h:commandButton value="计算缴费金额" onclick="return selectBaseSet();"
							action="#{ins_BaseInfoBB.calc}" styleClass="button01" />
					</h:panelGroup>
				</h:panelGrid> 
			<f:verbatim></td>
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

