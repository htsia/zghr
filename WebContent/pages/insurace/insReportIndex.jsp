<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
        function forClearZero() {
            var setName = form1.all("form1:setName").value;
            var unitId = form1.all("form1:unitId").value;
            var setId = form1.all("form1:setId").value;
            var arg = "act=selectSetInput&setName=" + setName + "&unitId=" + unitId + "&setId=" + setId;
            reval = window.showModalDialog("/wage/set/SetInputClear.jsf?" + arg, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            if (reval != null) {
                return true;
            } else {
                return false;
            }
        }
        function forShowItem() {
            var arg = "setId=" + form1.all("form1:setId").value;
            reval = window.showModalDialog("/wage/payoff/ComputeShowItemEdit.jsf?" + arg, null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
            if (reval != null) {
                form1.all('form1:str').value = reval;
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
            var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID=&ORGUID=&Parameter="+document.all("form1:setId").value;
            window.open(url);
            return false;
        }
        function forSelectInput() {
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
                    if (num > 100) {
                        alert("最多只能选择100个人员");
                        return false;
                    }
                } else
                    str = form1.chk.value;

                var setName = form1.all("form1:setName").value;
                var unitId = form1.all("form1:unitId").value;
                var setId = form1.all("form1:setId").value;
                var arg = "act=selectSetInput" + "&setName=" + setName + "&unitId=" + unitId + "&setId=" + setId + "&str=" + str;
                reval = window.showModalDialog("/wage/set/SetInputSelect.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
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

        function forOrderInput() {
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
                    if (num > 100) {
                        alert("最多只能选择100个人员");
                        return false;
                    }
                } else
                    str = form1.chk.value;
                reval = window.showModalDialog("/wage/set/OrderInput.jsf?PerStr=" + str, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
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

        function forUploadFile() {
            var setName = form1.all("form1:setName").value;
            var unitId = form1.all("form1:unitId").value;
            var setId = form1.all("form1:setId").value;
            var arg = "act=selectSetInput" + "&setName=" + setName + "&unitId=" + unitId + "&setId=" + setId;
            reval = window.showModalDialog("/wage/set/SetInputUpload.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            if (reval != null) {
                return true;
            } else {
                return false;
            }
        }
        function forCheckSelect() {
            if (checkMutilSelect(form1.chk)) {
                showProcessBar();
                return true;
            } else {
                alert("请选择人员");
                return false;
            }
        }
        function refreshList() {
             showProcessBar();
            return true;
        }
    </script>
</head>

<body>
<x:saveState value="#{insurace_ReportBB}"/>
<h:inputHidden value="#{insurace_ReportBB.pageInit}"/>
<h:form id="form1">
        <h:panelGrid columns="4" align="center"  width="100%" >
        <h:outputText value="发薪单位：#{insurace_ReportBB.unitName}"/>
        <h:selectOneMenu id="ReportID" style="width:150">
            <c:selectItems value="#{insurace_ReportBB.reportList}"/>
        </h:selectOneMenu>
        <h:commandButton value="显示" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
        <h:panelGrid columns="4" align="right" >
            <h:outputText value="姓名或员工编号:"/>
            <h:inputText value="" id="nameStr"/>
            <h:commandButton value="查询" action="#{insurace_ReportBB.queryPersonByNameStr}" styleClass="button01"/>
            <h:commandButton value="高级查询" styleClass="button01"
                             action="#{insurace_ReportBB.queryAdvance}"
                             onclick="return doAdvanceQuery('A','ORG','011','Y','','','N','152','N')"/>
        </h:panelGrid>
    </h:panelGrid>
    <jsp:include page="/pages/common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="false"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="false"/>
        <jsp:param name="keyName" value="ID"/>
        <jsp:param name="fixcol" value="4"/> 
    </jsp:include>
</h:form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
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
        </tr></table>
</marquee>
</body>
<script type="text/javascript">
     function showProcessBar() {
        x = document.body.clientWidth / 2 - 150;
        y = document.body.clientHeight / 2;
        document.all('processbar').style.top = y;
        document.all('processbar').style.left = x;
        document.all('processbar').style.display = "";
    }
</script>
</html>