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
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
        function checkSubmit() {
            if (form1.all('form1:field').value == "") {
                alert("ָ�����Ϊ�գ�")
                return false;
            } else {
                if (form1.all('form1:field').value == 'A815226') {//����ע�ֶ�
                    pageCodeExchange(form1);
                    return true;
                } else {
                    // element, discript, type, length, nullflag, maxs, mins
                    if (checkValidate(form1.all('form1:defaultValue'), 'Ĭ������ֵ', 'f')) {
                        pageCodeExchange(form1);
                        return true;
                    } else {
                        return false;
                    }
                }
            }
        }
        function forcostchage() {
            var oldvalue = form1.all('form1:cost').value;
            PopUpCodeDlgOneControl('form1:cost', '028002,028003,028004,028005', '0');
            if (form1.all('form1:cost').value != oldvalue) {
                form1.all('form1:cost').value = form1.all('form1:cost').code;
                return true;
            }
            return false;
        }
    </script>
</head>

<body>
<x:saveState value="#{wage_setItemBB}"/>
<h:form id="form1">
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid align="center" width="95%">
        <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" width="100%" styleClass="table03">
            <h:outputText value="н�������"/>
            <h:selectOneMenu id="type" value="#{wage_setItemBB.item.type}" style="width:150">
                <c:selectItem itemValue="2" itemLabel="������"/>
            </h:selectOneMenu>

            <h:outputText value="�����ɱ����"/>
            <h:panelGroup>
                <h:inputText id="cost" value="#{wage_setItemBB.item.cost}"
                             code="" dict="yes" dict_num="0280" readonly="true" alt="�����ɱ����|1"/>
                <h:outputText value=" "/>
                <h:commandButton styleClass="button_select" onclick="return forcostchage();" value=" "
                                 id="codebnt" actionListener="#{wage_setItemBB.changeCost}"/>
            </h:panelGroup>

            <h:outputText value="ѡ��ָ����"/>
            <h:selectOneMenu id="field" value="#{wage_setItemBB.item.field}" style="width:150px">
                <c:selectItems value="#{wage_setItemBB.rsInfoItemList}"/>
            </h:selectOneMenu>

            <h:outputText value="Ĭ������ֵ"/>
            <h:panelGroup>
                <h:inputText id="defaultValue" value="#{wage_setItemBB.item.defaultValue}"/>
                <h:outputText value=" "/>
                <h:outputText value="Ԫ"/>
            </h:panelGroup>
        </h:panelGrid>

        <h:panelGrid columns="2" align="center" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{wage_setItemBB.save}"
                             onclick="if(checkSubmit()){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="ȡ������" action="#{wage_setItemBB.list}"/>

        </h:panelGrid>
    </h:panelGrid>
</h:form>
<c:verbatim escape="false">
    <script type="text/javascript" language="javascript">
        interpret(document.forms(0));
    </script>
</c:verbatim>
</body>
</html>