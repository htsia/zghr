<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
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
        function forSelectInput() {
            if (checkMutilSelect(form1.chk)) {
                count = form1.chk.length;
                var str = "";
                if (count != null) {
                    var num=0;
                    for (i = 0; i < count; i++)
                        if (form1.chk[i].checked) {
                            str += form1.chk[i].value + ",";
                            num++;
                        }
                    if(num>100){
                        alert("最多只能选择100个人员");
                        return false;
                    }
                } else
                    str = form1.chk.value;

                var setName = form1.all("form1:setName").value;
                var unitId = form1.all("form1:unitId").value;
                var setId = form1.all("form1:setId").value;
                var arg = "act=selectFinanceInput" + "&setName=" + setName + "&unitId=" + unitId + "&setId=" + setId + "&str=" + str;
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
        function forUploadFile() {
            var setName = form1.all("form1:setName").value;
            var unitId = form1.all("form1:unitId").value;
            var setId = form1.all("form1:setId").value;
            var arg = "act=selectFinanceInput" + "&setName=" + setName + "&unitId=" + unitId + "&setId=" + setId;
            reval = window.showModalDialog("/wage/set/SetInputUpload.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            if (reval != null) {
                return true;
            } else {
                return false;
            }
        }
        function forCheckSelect() {
            if (checkMutilSelect(form1.chk)) {
                return true;
            } else {
                alert("请选择人员");
                return false;
            }
        }
        function forExport() {
            window.open('/pages/common/ExportToExcel.jsp');
        }

    </script>
</head>

<body>
<x:saveState value="#{wage_computeBB}"/>
<x:saveState value="#{wage_flowBB}"/>
<h:inputHidden value="#{wage_computeBB.pageInit}"/>
<h:panelGrid align="center" width="98%"  columnClasses="td_title" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">
    <h:outputText value=" 薪资发放"/>
</h:panelGrid>
<h:form id="form1">
    <h:inputHidden id="setId" value="#{wage_computeBB.setId}"/>
    <h:inputHidden id="unitId" value="#{wage_computeBB.unitId}"/>
    <c:verbatim escape="false">
        <input type="hidden" id="form1:setName" value="</c:verbatim><h:outputText value="#{wage_computeBB.setName}"/><c:verbatim>">
    </c:verbatim>
    <h:inputHidden id="str" value=""/>
    <h:panelGrid columns="1" align="center" width="95%" columnClasses="td_middle" styleClass="table03">
        <h:panelGrid columns="3" align="center" width="100%">
            <h:outputText value="发薪单位：#{wage_computeBB.unitName}"/>
            <h:outputText value="账套：#{wage_computeBB.setName}"/>
             <h:panelGrid columns="4" align="right" >
            <h:outputText value="姓名:"/>
            <h:inputText value="" id="nameStr"/>
            <h:commandButton value="查询" action="#{wage_computeBB.queryPersonByNameStr}" styleClass="button01"/>
            <%--<h:commandButton value="高级查询" styleClass="button01" action="#{wage_computeBB.queryAdvance}"--%>
                             <!--onclick="return doAdvanceQuery('A','ORG','011','Y','','','N','152','N')"/>-->
                 <!--2006-10-12,zhangxf deleted-->
             </h:panelGrid>
        </h:panelGrid>
        <h:panelGrid columns="6" align="center" cellspacing="2" >
            <h:commandButton value="选择录入数据" styleClass="button01"
                             action="#{wage_computeBB.turnPageQuery}"
                             onclick="return forSelectInput()"/>
            <h:commandButton value="文件导入数据" styleClass="button01"
                             action="#{wage_computeBB.turnPageQuery}"
                             onclick="return forUploadFile()"/>
            <h:commandButton value="选择人员计算" action="#{wage_computeBB.computePart}"
                             onclick="return forCheckSelect()" styleClass="button01"/>
            <h:commandButton value="全部人员计算" action="#{wage_computeBB.computeAll}" styleClass="button01"/>
            <h:commandButton value="导出Excel" type="button" onclick="forExport();" styleClass="button01"/>
            <h:commandButton value="返回" action="#{wage_flowBB.findDate}" styleClass="button01">
                <x:updateActionListener property="#{wage_flowBB.date.dateId}" value="#{wage_computeBB.dateId}"/>
            </h:commandButton>
        </h:panelGrid>
    </h:panelGrid>
    <c:verbatim><br></c:verbatim>
    <jsp:include page="/pages/common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="false"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="false"/>
        <jsp:param name="keyName" value="ID"/>
    </jsp:include>
</h:form>

</body>
</html>