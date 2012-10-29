<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function CreateBankFile(){
            if (document.all("form1:bankSet").value=="" || document.all("form1:bankSet").value=="-1"){
                alert("请选择报盘格式!");
                return false;
            }
            var url="/wage/payoff/CreateBankFile.jsf?setId="+document.all("form1:setId").value+"&dateId="+document.all("form1:dateId").value+"&bankId="+document.all("form1:bankSet").value;
            window.open(url, "_blank", "top="+(screen.height/2-80)+",height=160, left="+(screen.width/2-150)+",width=300,toolbar=no,scrollbars=no,menubar=no");
            return false;
        }
    </script>


<x:saveState value="#{wage_flowBB}"/>
<h:form id="form1">
    <h:inputHidden  value="#{wage_flowBB.insurceDisk}"/>
    <h:inputHidden id="setId" value="#{wage_flowBB.date.setId}"/>
    <h:inputHidden id="dateId" value="#{wage_flowBB.date.dateId}"/>

    <h:panelGrid styleClass="td_title" width="98%" border="0" align="center" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
         <h:graphicImage value="/images/tips.gif" />
         <h:outputText value="保险管理 -> 报盘"/>
       </h:panelGroup>
    </h:panelGrid>
    <c:verbatim><br></c:verbatim>
    <h:panelGrid columns="2"  align="center" width="90%" columnClasses="td_form01,td_form02"   styleClass="table03">
        <h:outputText value="生成报盘"/>
        <h:panelGroup>
            <h:selectOneMenu id="bankSet" value="#{wage_flowBB.bankSet}">
                <c:selectItems value="#{wage_flowBB.insurceList}"></c:selectItems>
            </h:selectOneMenu>
            <h:commandButton value="生成报盘文件" styleClass="button01" type="button" onclick="return CreateBankFile()"/>
        </h:panelGroup>
    </h:panelGrid>

</h:form>
