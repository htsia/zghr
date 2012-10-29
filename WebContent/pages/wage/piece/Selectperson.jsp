
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <base target="_self">
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/selectitem.js"></script>
    <script type="text/javascript">
    function forbatchInput() {
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
            var url="/wage/piece/batchAddPiece.jsf?unitId="+form1.all("form1:unitId").value+"&unitName="+form1.all("form1:unitName").value+"&setName="+form1.all("form1:setName").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value+"&PerStr="+str;
            //alert(url);
            reval = window.showModalDialog(url, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        } else {
            alert("请选择人员");
            return false;
        }
    }
    </script>
</head>

<body>
<x:saveState value="#{emp_pieceBatchEditBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{emp_pieceBatchEditBB.pageInit}"/>
    <h:inputHidden id="setId" value="#{emp_pieceBatchEditBB.setId}"/>
    <h:inputHidden id="unitId" value="#{emp_pieceBatchEditBB.unitId}"/>
    <h:inputHidden id="unitName" value="#{emp_pieceBatchEditBB.unitName}"/>
    <h:inputHidden id="setName" value="#{emp_pieceBatchEditBB.setName}"/>
    <h:inputHidden id="dateId" value="#{emp_pieceBatchEditBB.dateId}"/>
    
    <h:panelGrid columns="5" width="95%" align="center">
        <h:outputText value="发薪单位:#{emp_pieceBatchEditBB.unitName}"/>
        <h:outputText value="账套名称:#{emp_pieceBatchEditBB.setName}"/>
        <h:selectOneMenu id="dept" onchange="submit()" valueChangeListener="#{emp_pieceBatchEditBB.changeDept}" value="#{wage_templateInputBB.inputDept}">
            <f:selectItems value="#{emp_pieceBatchEditBB.deptList}"></f:selectItems>
        </h:selectOneMenu>
        <h:panelGroup>
            <h:commandButton styleClass="button01" value="增加"   onclick="forbatchInput()"/>
            <h:commandButton styleClass="button01" type="button" value="返回" onclick="window.close()"/>
        </h:panelGroup>
    </h:panelGrid>

    <jsp:include page="/pages/common/activepage/SecondActiveList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="false"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="false"/>
        <jsp:param name="keyName" value="ID"/>
        <jsp:param name="fixcol" value="4"/>
    </jsp:include>
</h:form>
</body>
</html>