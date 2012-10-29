<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
      response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head><title></title>
    <base target="_self">
    <script type="text/javascript">
        function selectAll() {
            for(var i=0;i<document.all('form1:baseinfo').length;i++){
               document.all('form1:baseinfo')[i].checked=true;
            }
            return false;
         }
         function cancelAll() {
             for(var i=0;i<document.all('form1:baseinfo').length;i++){
                document.all('form1:baseinfo')[i].checked=false;
             }
            return false;
         }
    </script>
</head>

<body>
    <x:saveState value="#{ins_managerItemBB}"/>
    <h:inputHidden value="#{ins_managerItemBB.initModiPower}"/>
    <h:form id="form1">
        <table  align=center border=0 cellpadding=0 cellspacing=0 width=95% >
            <tr><td colspan=2>
                     <h:outputLabel value="#{ins_managerItemBB.pbo.personName}"></h:outputLabel>
               </td>
            </tr>
            <tr><td colspan=2 height=10></td></tr>

            <tr>
                <td width="90" class="td_form01">
                    <h:commandButton type="button" styleClass="button01" value="全部选择" onclick="selectAll()"></h:commandButton><br><br>
                    <h:commandButton type="button" styleClass="button01" value="全不选择" onclick="cancelAll()"></h:commandButton><br>
                </td>
                <td class="td_form02">
                    <h:selectManyCheckbox id="baseinfo" value="#{ins_managerItemBB.inputList}" layout="pageDirection">
                        <c:selectItems value="#{ins_managerItemBB.allList}"></c:selectItems>
                    </h:selectManyCheckbox>
                </td>
            </tr>

            <tr><td colspan=4 height=20></td></tr>
            <tr>
                <td colspan=4 align="right">
                    <h:commandButton id="save" styleClass="button01" value="保存" onclick="return forsubmit(document.forms(0))" action="#{ins_managerItemBB.save}" /></td>
            </tr>
        </table>
    </h:form>
</body>
</html>