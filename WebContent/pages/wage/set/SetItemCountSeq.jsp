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
    <script language="javascript" src="<%=request.getContextPath()%>/js/selectItem.js"></script>
    <script type="text/javascript">
        function moveUP(){
            if (!isNature(document.all('form1:step').value)){
                alert("�ƶ�λ���Ƿ���");
            }
            for(var i=0;i<parseInt(document.all('form1:step').value);i++){
              forUpItem(form1.all('form1:itemList'));
            }
        }
        function moveDown(){
            if (!isNature(document.all('form1:step').value)){
                alert("�ƶ�λ���Ƿ���");
            }
            for(var i=0;i<parseInt(document.all('form1:step').value);i++){
              forDownItem(form1.all('form1:itemList'));
            }
        }
     </script>
</head>

<body>
<x:saveState value="#{wage_setItemBB}"/>
<x:saveState value="#{wage_setBB}"/>
<h:form id="form1">
    <br>
    <h:inputHidden id="setId" value="#{wage_setItemBB.item.setId}"/>
    <h:panelGrid align="center" columns="1"   styleClass="table03">
        <h:selectManyListbox id="itemList" value="#{wage_setItemBB.countSeq}" size="50" style="height:400px">
            <c:selectItems value="#{wage_setItemBB.formulaList}"/>
        </h:selectManyListbox>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid columns="5" align="right" cellspacing="2">
        <h:panelGroup>
            <h:outputText value="ÿ���ƶ�λ��:"></h:outputText>
            <h:inputText id="step" value="" />
        </h:panelGroup>
        <c:verbatim>
            <input type=button class=button01 value="����" onclick="moveUP();">
            <input type=button class=button01 value="����" onclick="moveDown();">
        </c:verbatim>
        <h:commandButton styleClass="button01" value="����"
                         action="#{wage_setItemBB.saveFormulaItemSequence}"
                         onclick="selectTotal(form1.all('form1:itemList'));"/>
        <h:commandButton styleClass="button01" value="ȡ������" action="#{wage_setItemBB.list}"/>
    </h:panelGrid>
</h:form>
</body>
</html>