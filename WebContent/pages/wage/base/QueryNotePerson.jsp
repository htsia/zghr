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
</head>

<script type="text/javascript">
    function sel() {
        try {
            if (checkMutilSelect(document.form1.chk)) {
                var obj = document.all("list");
                var tr = obj.rows;
                var id = "";
                var name = "";
                if (document.form1.all("chk").length == null) {
                    if (document.form1.chk.checked == true) {
                            id = document.form1.chk.value+",";
                            var tds = tr[1].cells;
                            var td = tds[1];
                            name += td.innerText + ",";
                        }

                } else {
                    for (i = 0; i < document.form1.all("chk").length; i++) {
                        if (document.form1.chk(i).checked == true) {
                            id += document.form1.chk(i).value + ",";
                            var tds = tr[i + 1].cells;
                            var td = tds[1];
                            name += td.innerText + ",";
                        }
                    }
                }

                if (id != "") {
                    id = id.substr(0, id.length - 1);
                } else
                    id = document.all("chk").value;
                if (name != "")
                    name = name.substr(0, name.length - 1);
                window.returnValue = id + "||" + name;
                window.close();

                //                }

            } else {
                alert("请选择人员！")
                return false;
            }
        } catch(err) {
            return false;
        } finally {

        }
    }
</script>

<body>
<x:saveState value="#{wage_personQueryBB}"/>
<h:inputHidden id="pageInit" value="#{wage_personQueryBB.pageInit}"/>
<h:form id="form1">
    <h:panelGrid columns="1" width="95%" styleClass="table03" align="center" columnClasses="td_middle">
        <h:panelGrid align="center" columns="7" cellspacing="2">
            <h:outputText value="姓名："/>
            <f:verbatim><input type="text" alt="姓名|0" size="12" name="form1:nameStr"
                               onkeypress="enterKeyDown('form1:btnSearch')"></f:verbatim>
            <h:commandButton id="btnSearch" styleClass="button01" value="查询"
                             action="#{wage_personQueryBB.queryPersonByName}"
                             onclick="return forsubmit(form1);"/>
            <h:commandButton styleClass="button01" value="高级查询"
                             onclick="return doAdvanceQuery('A','ORG','011','Y','TABLEOBJECT','','N','','Y')"
                             action="#{wage_personQueryBB.queryAdvance}"/>
            <h:commandButton styleClass="button01" value="查询代发工资人员"
                             action="#{wage_personQueryBB.queryAgentWagePerson}"/>
            <h:commandButton styleClass="button01" value="查询代缴保险福利人员"
                             action="#{wage_personQueryBB.queryAgentBenefitPerson}"/>
            <h:commandButton styleClass="button01" value="选择" onclick="sel();return false;"/>
        </h:panelGrid>
    </h:panelGrid>
    <f:verbatim><br>
        <jsp:include page="/pages/common/activepage/ActiveList.jsp">
            <jsp:param name="hasOperSign" value="true"/>
            <jsp:param name="operSignType" value="checkbox"/>
            <jsp:param name="hasEdit" value="false"/>
            <jsp:param name="isForward" value="true"/>
            <jsp:param name="editName" value="&#32500;&#25252;"/>
            <jsp:param name="editFuncName" value="forEdit"/>
            <jsp:param name="isEditList" value="false"/>
            <jsp:param name="isCheckRight" value="false"/>
        </jsp:include>
    </f:verbatim>
</h:form>
</body>
</html>