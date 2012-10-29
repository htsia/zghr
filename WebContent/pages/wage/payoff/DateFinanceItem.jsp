<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <title>设置财务处理项目</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
        function forSave() {
            var field = form1.all('form1:financeItem');
            if (checkMutilSelect(field)) {
                revalue = "";
                count = field.length;
                if (count != null) {
                    for (i = 0; i < count; i++)
                        if (field[i].checked) {
                            revalue += field[i].value + ",";
                        }
                } else {
                    revalue = field.value;
                }
                window.returnValue = revalue;
                window.close();
            } else {  //允许不选择
               /* alert("请选择财务处理项目！");
                return false*/
                 window.returnValue = "clear";
                 window.close();
            }
        }
        function forCancel(){
             window.returnValue = null;
              window.close();
        }
    </script>
</head>

<body>

<h:form id="form1">
    <c:verbatim><br></c:verbatim>
    <h:inputHidden value="#{wage_dateBB.setId}"/>
    <h:panelGrid width="90%" align="center"  styleClass="table03" columnClasses="td_middle">
        <h:outputText value="设置财务处理项目" styleClass="td05"/>
        <h:selectManyCheckbox value="#{wage_dateBB.financeItem}" layout="pageDirection" id="financeItem">
            <c:selectItems value="#{wage_dateBB.inputItem}"/>
        </h:selectManyCheckbox>
    </h:panelGrid>
    <c:verbatim><br></c:verbatim>
    <h:panelGrid columns="2" cellspacing="2" align="center">
        <h:commandButton type="button" styleClass="button01" value="保存" onclick="forSave()" rendered="#{wage_dateBB.operRight}"/>
        <h:commandButton type="button" styleClass="button01" value="取消" onclick="forCancel()" />
    </h:panelGrid>
</h:form>
</body>
</html>