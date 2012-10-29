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
    <title>������ʾ��Ŀ</title>
    <script language="javascript" src="<%=request.getContextPath()%>/js/selectItem.js"></script>
    <script type="text/javascript">
        function moveUP(){
            if (!isNature(document.all('form1:step').value)){
                alert("�ƶ�λ���Ƿ���");
            }
            for(var i=0;i<parseInt(document.all('form1:step').value);i++){
               forUpItem(form1.all('form1:showItem'));
            }
        }
        function moveDown(){
            if (!isNature(document.all('form1:step').value)){
                alert("�ƶ�λ���Ƿ���");
            }
            for(var i=0;i<parseInt(document.all('form1:step').value);i++){
              forDownItem(form1.all('form1:showItem'));
            }
        }

        function forSaveItem() {
            var showfield = form1.all('form1:showItem');
            count = showfield.length;
            if (count > 0) {
                revalue = "";
                for (i = 0; i < count; i++) {
                    if (revalue==""){
                       revalue=showfield.options[i].value;  
                    }
                    else{
                       revalue += ","+showfield.options[i].value;
                    }
                }                
                window.returnValue = revalue;
                window.close();
            } else {
                alert("��ѡ����ʾ��Ŀ��");
                return false
            }
        }
    </script>
</head>

<body>
<h:form id="form1">
    <c:verbatim><br></c:verbatim>
    <h:panelGrid columns="3" align="center" width="80%"      styleClass="table03" columnClasses="td_middle,td_middle,td_middle">
        <h:panelGrid columns="1">
            <h:panelGroup>
                <h:outputText value="ȫ����Ŀ" styleClass="td05"/>
                <h:selectBooleanCheckbox value="#{wage_orggroupBB.orderByName}" onclick="submit()" valueChangeListener="#{wage_orggroupBB.changeOrder}"></h:selectBooleanCheckbox>
                <h:outputText value="����������"></h:outputText>
            </h:panelGroup>
            <h:selectManyListbox id="allItem" style="width:15em" size="30" >
                <c:selectItems value="#{wage_orggroupBB.allList}"/>
            </h:selectManyListbox>
        </h:panelGrid>

        <h:panelGrid columns="1" align="center">
            <h:commandButton type="button" value="���" onclick="forAddItem(form1.all('form1:showItem'),form1.all('form1:allItem'))" styleClass="button01"/>
            <h:commandButton type="button" value="ɾ��" onclick="removeItem(form1.all('form1:showItem'))" styleClass="button01"/>
            <c:verbatim><br></c:verbatim>
            <h:commandButton type="button" value="����" onclick="moveUP();" styleClass="button01"/>
            <h:commandButton type="button" value="����" onclick="moveDown();" styleClass="button01"/>
        </h:panelGrid>
        
        <h:panelGrid columns="1">
            <h:outputText value="��ѡ��Ŀ" styleClass="td05"/>
            <h:selectManyListbox id="showItem" style="width:15em" size="30" >
                <c:selectItems value="#{wage_orggroupBB.showList}"/>
            </h:selectManyListbox>
        </h:panelGrid>    
    </h:panelGrid>

    <c:verbatim><br></c:verbatim>
    <h:panelGrid columns="2" align="right" border="0">
        <h:panelGroup>
            <h:outputText value="ÿ���ƶ�λ��:"></h:outputText>
            <h:inputText id="step" value="" />
        </h:panelGroup>

        <h:panelGroup>
            <h:commandButton value="����" type="button" onclick="forSaveItem()" styleClass="button01"/>
            <h:commandButton value="�ر�" type="button" onclick="window.close()" styleClass="button01"/>
        </h:panelGroup>
    </h:panelGrid>
</h:form>
</body>
</html>