<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function CreateBankFile(){
        if (document.all("form1:bankSet").value=="" || document.all("form1:bankSet").value=="-1"){
            alert("请选择银行格式!");
            return false;
        }
        var url="/wage/payoff/CreateBankFile.jsf?setId="+document.all("form1:setId").value+"&dateId="+document.all("form1:dateId").value+"&bankId="+document.all("form1:bankSet").value;
        window.open(url, "_blank", "top="+(screen.height/2-80)+",height=160, left="+(screen.width/2-150)+",width=300,toolbar=no,scrollbars=no,menubar=no");
        return false;
    }
    function confirmSubmitEnd() {
        if (confirm("确认保存发放结果吗？")) {
            showProcessBar();
            return true;
        } else {
            return false;
        }
    }
</script>

<x:saveState value="#{wage_flowBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_flowBB.initPayoffDialog}"></h:inputHidden>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
         <h:graphicImage value="/images/tips.gif" />
         <h:outputText value="薪酬管理 -> 薪资发放"/>
       </h:panelGroup>
    </h:panelGrid>

    <c:verbatim><br></c:verbatim>
    <h:panelGrid columns="2" align="center" width="90%">
        <h:outputText value="发薪单位：#{wage_flowBB.unitName}"/>
        <h:outputText value="账套：#{wage_flowBB.setName}"/>
    </h:panelGrid>
    <h:inputHidden id="unitId" value="#{wage_flowBB.unitId}"/>
    <h:inputHidden id="setId" value="#{wage_flowBB.date.setId}"/>
    <h:inputHidden id="setName" value="#{wage_flowBB.setName}"/>
    <h:inputHidden id="dateId" value="#{wage_flowBB.date.dateId}"/>
    <c:verbatim><br></c:verbatim>

    <h:panelGrid columns="2"  align="center" width="90%" columnClasses="td_form01,td_form02"   styleClass="table03">
        <h:outputText value="银行报盘"/>
        <h:panelGroup>
            <h:selectOneMenu id="bankSet" value="#{wage_flowBB.bankSet}">
                <c:selectItems value="#{wage_flowBB.bankSetList}"></c:selectItems>
            </h:selectOneMenu>
            <h:commandButton value="生成报盘文件" styleClass="button01" rendered="#{!wage_flowBB.groupPay}" type="button" onclick="return CreateBankFile()"/>
        </h:panelGroup>

        <h:outputText value="相关操作"/>
        <h:panelGroup>
            <h:commandButton value="结束本次发放" action="#{wage_flowBB.submitEndDialog}" styleClass="button01"
                             onclick="return confirmSubmitEnd()"/>
            <h:commandButton value="返回"  styleClass="button01" type="button" onclick="window.close();">
            </h:commandButton>
        </h:panelGroup>
    </h:panelGrid>
    <c:verbatim><br></c:verbatim>
</h:form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
        </tr>
   </table>
</marquee>

<script type="text/javascript">
    function showProcessBar() {
        x = document.body.clientWidth / 2 - 150;
        y = document.body.clientHeight / 2;
        document.all('processbar').style.top = y;
        document.all('processbar').style.left = x;
        document.all('processbar').style.display = "";
    }
</script>

