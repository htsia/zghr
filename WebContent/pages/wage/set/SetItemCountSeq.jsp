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
                alert("移动位数非法！");
            }
            for(var i=0;i<parseInt(document.all('form1:step').value);i++){
              forUpItem(form1.all('form1:itemList'));
            }
        }
        function moveDown(){
            if (!isNature(document.all('form1:step').value)){
                alert("移动位数非法！");
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
            <h:outputText value="每次移动位数:"></h:outputText>
            <h:inputText id="step" value="" />
        </h:panelGroup>
        <c:verbatim>
            <input type=button class=button01 value="上移" onclick="moveUP();">
            <input type=button class=button01 value="下移" onclick="moveDown();">
        </c:verbatim>
        <h:commandButton styleClass="button01" value="保存"
                         action="#{wage_setItemBB.saveFormulaItemSequence}"
                         onclick="selectTotal(form1.all('form1:itemList'));"/>
        <h:commandButton styleClass="button01" value="取消返回" action="#{wage_setItemBB.list}"/>
    </h:panelGrid>
</h:form>
</body>
</html>