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
    
   <script type="text/javascript">
    function doViewCard(){
        var ID=getFirstSelectValue(form1.chk);
        //debugger;
        if (ID!=null && ID!=""){
           window.showModalDialog("/wage/payoff/ShowCard.jsf?setId="+document.all("form1:setId").value+"&ID="+ID, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
        }else{
           window.showModalDialog("/wage/payoff/ShowCard.jsf?setId="+document.all("form1:setId").value, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
        }
        return false;
    }
  </script>
</head>

<body>
<x:saveState value="#{wage_dataCheckBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_dataCheckBB.initData}"/>
    <h:inputHidden id="setId" value="#{wage_dataCheckBB.dataSet}"/>
    <h:inputHidden id="ckID" value="#{wage_dataCheckBB.ckID}"/>
    <h:inputHidden id="dateId" value = "#{wage_dataCheckBB.dateId}"></h:inputHidden>
    <table height=98% width=98%>
       <tr><td height=1>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="薪酬管理 -> 薪资审批不合法数据"/>
           </td>
           <td>
               <h:selectBooleanCheckbox value="#{wage_dataCheckBB.ckAll}"></h:selectBooleanCheckbox>
               <h:outputText value="显示所有项目"></h:outputText>
               <h:commandButton value="确定" styleClass="button01" action="#{wage_dataCheckBB.doShow}"></h:commandButton>
               <h:commandButton value="显示卡片" styleClass="button01" type="button" onclick="doViewCard()"></h:commandButton>
               <h:commandButton value="标记问题数据" styleClass="button01" action="#{wage_dataCheckBB.maskError}"></h:commandButton>
               <h:commandButton value="导出" styleClass="button01" type="button" onclick="doExport()"></h:commandButton>
           </td>
           </tr>
           <tr><td colspan=2 height=5>   </td></tr>
       <tr><td colspan=2>
           <jsp:include page="/pages/common/activepage/ActiveList.jsp">
               <jsp:param name="hasOperSign" value="true"/>
               <jsp:param name="operSignType" value="checkbox"/>
               <jsp:param name="hasEdit" value="false"/>
               <jsp:param name="isEditList" value="false"/>
               <jsp:param name="isCheckRight" value="false"/>
               <jsp:param name="keyName" value="ID"/>
               <jsp:param name="fixcol" value="4"/>
               <jsp:param name="maskError" value="true"/>
           </jsp:include>
       </td></tr>
    </table>
</h:form>
</body>
</html>