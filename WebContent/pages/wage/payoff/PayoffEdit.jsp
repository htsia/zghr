<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function SelectCreateBankFile(){
        if (document.all("form1:bankSet").value=="" || document.all("form1:bankSet").value=="-1"){
            alert("请选择银行格式!");
            return false;
        }
        var url="/wage/payoff/SelectCreateBankFile.jsf?setId="+document.all("form1:setId").value+"&dateId="+document.all("form1:dateId").value+"&bankId="+document.all("form1:bankSet").value;
        window.open(url, "_blank", "top="+(screen.height/2-80)+",height=160, left="+(screen.width/2-150)+",width=300,toolbar=no,scrollbars=no,menubar=no");
        return false;
    }
    
    function OpenRptByControl(){
        if (document.all("form1:ReportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }
        var url="/pages/report/ClientReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID=&ORGUID="+document.all("form1:unitId").value+"&Parameter="+document.all("form1:setId").value
                 +"&Title="+document.all("form1:setId").value+"_"+document.all("form1:dateId").value+"_"+document.all("form1:ReportID").value;
        window.open(url);
        return false;
    }
    function CreateBankFile(){
        if (document.all("form1:bankSet").value=="" || document.all("form1:bankSet").value=="-1"){
            alert("请选择银行格式!");
            return false;
        }
        var url="/wage/payoff/CreateBankFile.jsf?setId="+document.all("form1:setId").value+"&dateId="+document.all("form1:dateId").value+"&bankId="+document.all("form1:bankSet").value;
        window.open(url, "_blank", "top="+(screen.height/2-80)+",height=160, left="+(screen.width/2-150)+",width=300,toolbar=no,scrollbars=no,menubar=no");
        return false;
    }
    function OpenRpt(){
        if (document.all("form1:ReportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }
        var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID=&ORGUID="+document.all("form1:unitId").value+"&Parameter="+document.all("form1:setId").value
                 +"&Title="+document.all("form1:setId").value+"_"+document.all("form1:dateId").value+"_"+document.all("form1:ReportID").value;
        window.open(url);
        return false;
    }

    function OpenRptByDept(){
        var url="/report/DeptReportShow.jsf?pids&unitId="+document.all("form1:unitId").value+"&setId="+document.all("form1:setId").value
                 +"&setName="+form1.all("form1:setName").value;
        window.showModalDialog( url, null, "dialogWidth:400px; dialogHeight:350px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;// 返回true 以便涮新界面 从而得到部门权限session
    }
    function doDetailPopup() {
        var dateId = form1.all("form1:dateId").value;
        popup = window.open("/wage/payoff/WageDetailView.jsf?dateId=" + dateId, "", "height="+screen.height*0.8+",width="+screen.width*0.8+",toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
        popup.focus();
    }
    function doNotePopup() {
        var dateId = form1.all("form1:dateId").value;
        popup = window.open("/wage/payoff/WageNoteView.jsf?dateId=" + dateId, "", "height=600,width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
        popup.focus();
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
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
         <h:graphicImage value="/images/tips.gif" />
         <h:outputText value="薪酬管理 -> 薪资发放"/>
       </h:panelGroup>
    </h:panelGrid>

    <c:verbatim><br></c:verbatim>
    <h:panelGrid columns="2" align="center" width="60%">
        <h:outputText value="发薪单位：#{wage_flowBB.unitName}"/>
        <h:outputText value="账套：#{wage_flowBB.setName}"/>
    </h:panelGrid>
    <h:inputHidden id="unitId" value="#{wage_flowBB.unitId}"/>
    <h:inputHidden id="setId" value="#{wage_flowBB.date.setId}"/>
    <h:inputHidden id="setName" value="#{wage_flowBB.setName}"/>
    <h:inputHidden id="dateId" value="#{wage_flowBB.date.dateId}"/>
    <c:verbatim><br></c:verbatim>

    <h:panelGrid columns="2"  align="center" width="60%" columnClasses="td_form01,td_form02"   styleClass="table03">
        <h:outputText value="查看"/>
        <h:panelGroup>
            <h:commandButton value="查看发放明细" type="button" onclick="doDetailPopup()" styleClass="button01"/>
            <h:outputText value=" "/>
            <h:commandButton value="查看变动表" type="button" onclick="doNotePopup()" styleClass="button01"/>
        </h:panelGroup>

        <h:outputText value="复核意见"/>
        <h:outputText escape="false" value="已审核！#{wage_flowBB.date.checkContent}<br><div align=right> #{wage_flowBB.checkerName}</div>"/>

        <h:outputText value="审批意见"/>
        <h:outputText escape="false" value="同意。#{wage_flowBB.date.approveContent} <br><div align=right> #{wage_flowBB.approverName}</div>"/>

        <h:outputText value="工资条"/>
        <h:panelGroup>
            <h:commandButton value="打印工资条" type="button" styleClass="button01" onclick="return OpenRptByDept();"></h:commandButton>
        </h:panelGroup>

        <h:outputText value="相关表格"/>
        <h:panelGroup>
            <h:selectOneMenu id="ReportID" style="width:150px">
               <c:selectItems value="#{wage_flowBB.payoffreportList}"/>
            </h:selectOneMenu>
            <h:commandButton value="显示" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
            <h:commandButton value="直接打开" type="button" styleClass="button01" onclick="return OpenRptByControl();"></h:commandButton>
        </h:panelGroup>

        <h:outputText value="银行报盘"/>
        <h:panelGroup>
            <h:selectOneMenu id="bankSet" value="#{wage_flowBB.bankSet}">
                <c:selectItems value="#{wage_flowBB.bankSetList}"></c:selectItems>
            </h:selectOneMenu>
            <h:commandButton value="生成" styleClass="button01" rendered="#{!wage_flowBB.groupPay}" type="button" onclick="return CreateBankFile()"/>
            <h:commandButton value="选择生成" styleClass="button01" type="button" onclick="return SelectCreateBankFile();"/>
        </h:panelGroup>

        <h:outputText value="相关操作"/>
        <h:panelGroup>
            <h:commandButton value="结束本次发放" action="#{wage_flowBB.submitEnd}" styleClass="button01"
                             onclick="return confirmSubmitEnd()"/>
            <h:commandButton value="返回" action="#{wage_flowBB.list}" styleClass="button01">
                <x:updateActionListener property="#{wage_flowBB.act}" value="3"/>
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

