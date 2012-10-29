<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<html>
<head>
    <title>ס���������μ���</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
</head>

<body>
<script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
<script language=javascript src="<%=request.getContextPath()%>/js/check.js"></script>
<script language=javascript src="<%=request.getContextPath()%>/js/checkAll.js"></script>
<SCRIPT language=JavaScript type=text/JavaScript>
    function checkForm() {
        if (document.getElementById("form1:planName").value == null || document.getElementById("form1:planName").value == "") {
            alert("������ƻ�����")
            return false;
        } else
            return true;
    }
    function checkIds(deptId) {
        if (checkMutilSelect(deptId)) {
            if (confirm('ȷ��Ҫ�Ƴ�������'))
            {
                return true;
            } else {
                return false;
            }
        } else {
            alert("��ѡ���ţ�")
            return false;
        }
    }
    function forSave(){
        document.forms(0).flag.value="save";
        return forsubmit(document.forms(0));
    }
</SCRIPT>
<br>
<h:form id="form1">
    <x:saveState value="#{wage_fbcomputeBB}"/>
    <h:inputHidden value="#{wage_fbcomputeBB.pageInit}"/>
    <input type="hidden" name="flag" value="<%=request.getParameter("flag")%>"/>
    <h:panelGrid border="0" align="center" width="95%">
        <h:panelGrid border="0" align="left" cellspacing="2" columns="2">
            <h:outputText value="�������ƣ�#{wage_fbcomputeBB.unitName}"/>
            <%--<h:outputText value="��¼����#{wage_fbcomputeBB.recNum}"/>--%>
        </h:panelGrid>

        <h:panelGrid border="0" align="right" cellspacing="2" columns="7">
            <h:commandButton styleClass="button01" value="���ݳ�ȡ" action="#{wage_fbcomputeBB.importData}"/>
            <h:commandButton styleClass="button01" value="������ʱ��" onclick="return checkBatchDo('chk');" action="#{wage_fbcomputeBB.computeDate}"/>
            <h:commandButton styleClass="button01" value="��������"
                             onclick="javascript:return forSave();"
                             action="#{wage_fbcomputeBB.saveData}">
            </h:commandButton>
            <h:commandButton styleClass="button01" value="���������" onclick="if(checkBatchDo('chk')){return confirm('�����ֶ��������������ȱ���\nȷ��Ҫ�����������?');}else{return false;}" action="#{wage_fbcomputeBB.setResultData}"/>
            <h:commandButton styleClass="button01" value="������Excel"
                             onclick="return true;"
                             action="#{wage_fbcomputeBB.importToExcel}"/>
            <h:commandButton styleClass="button01" value=" ɾ�� " action="#{wage_fbcomputeBB.deleteBatch}" onclick="return checkBatchDelete('chk');" />
            <h:commandButton  styleClass="button01" id="qry" value=" ��ѯ " action="#{wage_fbcomputeBB.queryPers}"  onclick="submit();"/>
        </h:panelGrid>
    </h:panelGrid>
    <center>
    <hrdc:pageTag submitMethod="form1.all(\"form1:qry\").onclick()"/>
    </center>
    <h:panelGrid align="center" width="95%">
        <h:dataTable styleClass="table03" headerClass="td_top"
                     columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                     align="center" width="100%"
                     value="#{wage_fbcomputeBB.computeBOs}" var="list" >
            <h:column>
                <f:facet name="header">
                       <f:verbatim escape="false">
                        <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.chk)"/>
                        </f:verbatim>
                </f:facet>
                <f:verbatim escape="false">
                    <input type="checkbox" name="chk" value="</f:verbatim>
                    <h:outputText value="#{list.persId}"/>
                    <f:verbatim>"></f:verbatim>
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="����" /></f:facet>
                <h:outputText value="#{list.persName}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="���ڲ���" /></f:facet>
                <h:outputText value="#{list.deptName}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="��׼����" /></f:facet>
                <h:outputText value="#{list.standardId}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="�����������ʱ��" /></f:facet>
                <h:inputText value="#{list.workYear}" alt="�����������ʱ��|0|d6" size="16"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="����ס������ְ��" /></f:facet>
                <h:outputText value="#{list.startPostName}" />
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="ְ��" /></f:facet>
                <h:outputText value="#{list.dutyName}" />
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="ְ��" /></f:facet>
                <h:outputText value="#{list.postLevelName}" />
            </h:column>
            <%--<h:column>--%>
                <%--<f:facet name="header"><h:outputText value="רҵ����" /></f:facet>--%>
                <%--<h:inputText value="#{list.technology}"/>--%>
            <%--</h:column>--%>
            <h:column>
                <f:facet name="header"><h:outputText value="��ʱ��" /></f:facet>
                <h:inputText value="#{list.startDate}" alt="��ʱ��|1|d6" size="16"/>
            </h:column>
           <%-- <h:column>
                <f:facet name="header"><h:outputText value="����" /></f:facet>
                <h:commandButton id="del" styleClass="button01" value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?')" action="#{wage_fbcomputeBB.deleteData}">
                    <x:updateActionListener property="#{wage_fbcomputeBB.persId}" value="#{list.persId}"/>
                </h:commandButton>
            </h:column>--%>
        </h:dataTable>
    </h:panelGrid>
</h:form>
</body>
</html>
