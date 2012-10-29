<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script language="javascript">
     var allCount=<%=Constants.ACTIVE_PAGE_SIZE%>;
     function EditFlowRpt(){
         window.showModalDialog("/report/EditFlowReport.jsf?Title="+document.all('form1:dateId').value, null, "dialogWidth:550px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
         return false;
     }
     function doQueryManyPerson(){
        var reval = window.showModalDialog("/common/ManyPersonCon.jsf", null, "dialogWidth:550px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
        if (reval != null && reval !="") {
            document.all('form1:ManyPerson').value = reval;
            showProcessBar();
            return true;
        } else {
            return false;
        }
    }
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

    function showProcessBar() {
       x = document.body.clientWidth / 2 - 150;
       y = document.body.clientHeight / 2;
       document.all('processbar').style.top = y;
       document.all('processbar').style.left = x;
       document.all('processbar').style.display = "";
    }

    function beginClass(){
        if (document.all("form1:sortList").value=="-1") {
            alert("û��ѡ�������Ϣ��");
        }
        else{
           window.showModalDialog("/wage/payoff/AuditShowClass.jsf?dateId="+form1.all("form1:dateId").value+"&SetId=" + form1.all("form1:setId").value+"&GroupField="+form1.all("form1:sortList").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        }
        return false;
    }

    function beginGroup(){
        if (document.all("form1:sortList").value=="-1") {
            alert("û��ѡ�������Ϣ��");
        }
        else{
           window.showModalDialog("/wage/payoff/AuditShowGroup.jsf?dateId="+form1.all("form1:dateId").value+"&SetId=" + form1.all("form1:setId").value+"&GroupField="+form1.all("form1:sortList").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        }
        return false;
    }

    function OpenRptByDept(){
        var str = "";
        if (checkMutilSelect(form1.chk)) {
            count = form1.chk.length;
            if (count != null) {
                var num = 0;
                for (i = 0; i < count; i++)
                    if (form1.chk[i].checked) {
                        str += form1.chk[i].value.replace("#","~") + ",";
                        num++;
                    }
                if (num > allCount) {
                    alert("���ֻ��ѡ��"+allCount+"����Ա");
                    return false;
                }
            } else
                str = form1.chk.value.replace("#","~");
        }
        if (document.all('form1:status').value=='5'){
            return OpenRptByDeptHis(str);
        }
        else{
            return OpenRptByDeptCur(str);
        }
    }
    function OpenRptByDeptCur(pid){
        var url="/report/DeptReportShow.jsf?unitId="+document.all("form1:unitId").value+"&setId="+document.all("form1:setId").value
                 +"&setName="+form1.all("form1:setName").value+"&pids="+pid;
        window.showModalDialog( url, null, "dialogWidth:450px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;// ����true �Ա����½��� �Ӷ��õ�����Ȩ��session
    }

    function OpenRptByDeptHis(pid){
        var url="/report/DeptReportShow.jsf?unitId="+document.all("form1:unitId").value+"&setId=DATE_"+document.all("form1:dateId").value
                 +"&setName="+form1.all("form1:setName").value+"&pids="+pid;
        window.showModalDialog( url, null, "dialogWidth:450px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;// ����true �Ա����½��� �Ӷ��õ�����Ȩ��session
    }

    function forViewPerson(form, id, type){
        window.showModalDialog("/wage/payoff/wagePersonquery.jsf?setID="+document.all('form1:setId').value+"&pID="+id, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
    }
    function forExport() {
        windowOpen("/pages/common/ExportToExcel.jsf", "", "status=yes,toolbar=no,location=no", "700", "600");
    }
    var lastRow;
    var currRow;
    function forSelectStyle(obj) {
        if (lastRow != null) {
            for (i = 0; i < lastRow.length; i++) {
                lastRow[i].style.backgroundColor = "#FFFFFF";
            }
        }
        currRow = obj.parentElement.cells;
        if (currRow != null) {
            for (i = 0; i < currRow.length; i++) {
                currRow[i].style.backgroundColor = "#7D9FC0";
                currRow[i].title=currRow[3].innerText;
            }
        }

        lastRow = currRow;
    }
    function forView(setId,payoffId,status,dt,approver,checker,creator){
        windowOpen("/pages/wage/payoff/DeptWageDetailView.jsp?setId="+setId+"&dateId="+payoffId+"&status="+status+"&date="+dt+"&approver="+approver+"&checker="+checker+"&creator="+creator, '', '', '800', '400', 'yes', '100', '100', 'yes') ;
    }
    function OpenRpt(){
        if (document.all("form1:ReportID").value=="-1"){
            alert("����ѡ������ʽ��");
            return false;
        }
        var url="/pages/report/FlowReportShow.jsp?Title="+document.all("form1:ReportID").value;
        window.open(url);
        return false;
    }
</script>


<x:saveState value="#{wage_flowBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{wage_flowBB.viewDetail}"/>
    <h:inputHidden value="#{wage_flowBB.inputItem}"/>
    <h:inputHidden id="status" value="#{wage_flowBB.date.status}"/>
    <h:inputHidden id="setId" value="#{wage_flowBB.date.setId}"/>
    <h:inputHidden id="dateId" value="#{wage_flowBB.date.dateId}"/>
    <h:inputHidden id="setName" value="#{wage_flowBB.date.setName}"/>
    <h:inputHidden id="unitId" value="#{wage_flowBB.date.unitID}"/>
    <h:inputHidden id="ManyPerson" value="#{wage_flowBB.manyPerson}"></h:inputHidden>

    <f:verbatim>
    <table width=100% height=97% border=0 >
    <tr><td height=8px>
</f:verbatim>
    <h:panelGrid width="98%" align="center">
        <h:panelGrid columns="3" width="100%" align="center" >
            <h:outputText escape="false" value="<strong>��н����:</strong>#{wage_flowBB.date.date}"/>
            <h:outputText escape="false" value="<strong>��λ��</strong>Ԫ"/>

            <h:panelGroup>
                <h:commandButton value="��ʾ��Ƭ" type="button" styleClass="button01" onclick="return doViewCard();"></h:commandButton>
                <h:commandButton value="�����Ų鿴" styleClass="button01" onclick="forView('#{wage_flowBB.date.setId}','#{wage_flowBB.date.dateId}','#{wage_flowBB.date.status}','#{wage_flowBB.date.date}','#{wage_flowBB.date.approver}','#{wage_flowBB.date.checker}','#{wage_flowBB.date.creator}');return false;"/>
                <h:commandButton value="������Excel" styleClass="button01" onclick="forExport();return false;"/>
            </h:panelGroup>
        </h:panelGrid>

        <h:panelGrid width="100%" columns="4" align="center"  columnClasses="f04">
            <h:panelGroup>
                <h:inputText id="name" value="#{wage_flowBB.nameStr}"   size="10" styleClass="input"  />
                <h:commandButton value="��ѯ" id="queryPerson"    styleClass="button01"   onclick="showProcessBar();" action="#{wage_flowBB.searchByPerson}"/>
                <h:commandButton value="���˲�ѯ" action="#{wage_flowBB.queryMultiPerson}" onclick="doQueryManyPerson();" styleClass="button01"/>
            </h:panelGroup>

             <h:panelGroup>
                 <h:selectOneMenu value="#{wage_flowBB.itemType}" rendered="#{wage_flowBB.inputItem!='1'}">
                     <c:selectItems value="#{wage_flowBB.itemTypeList}"></c:selectItems>
                 </h:selectOneMenu>
                 <h:commandButton value="ȷ��" styleClass="button01" rendered="#{wage_flowBB.inputItem!='1'}" action="#{wage_flowBB.searchByPerson}"></h:commandButton>
             </h:panelGroup>

            <h:panelGroup>
                <h:selectOneMenu id="ReportID" style="width:150px">
                     <c:selectItems value="#{wage_flowBB.reportList}"/>
                </h:selectOneMenu>
                <h:commandButton value="��ʾ������" type="button" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
                <h:commandButton value="���ά��" type="button" styleClass="button01" rendered="#{wage_flowBB.canEditFlowRpt}" onclick="return EditFlowRpt();"></h:commandButton>
                <h:commandButton value="��ӡ��ϸ��" type="button" styleClass="button01" onclick="return OpenRptByDept();"></h:commandButton>
                <h:outputText value="    "></h:outputText> 
                <h:selectOneMenu id="sortList" value="#{wage_flowBB.sortField}">
                   <c:selectItems value="#{wage_flowBB.sortList}"></c:selectItems>
                </h:selectOneMenu>
                <h:commandButton value="����" type="button" styleClass="button01" onclick="return beginGroup();"/>
                <h:commandButton value="����" type="button" styleClass="button01" onclick="return beginClass();"/>

            </h:panelGroup>

        </h:panelGrid>
    </h:panelGrid>

    <h:panelGrid columns="3" align="center" width="95%" >
        <h:outputText escape="false" value="<strong>�����ˣ�</strong>#{wage_flowBB.date.approver}"/>
        <h:outputText escape="false" value="<strong>�����ˣ�</strong>#{wage_flowBB.date.checker}"/>
        <h:outputText escape="false" value="<strong>�Ʊ��ˣ�</strong>#{wage_flowBB.date.creator}"/>
    </h:panelGrid>
<f:verbatim>
    </td>
</tr>
<tr><td>
    <jsp:include page="/pages/common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="true"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="true"/>
        <jsp:param name="isForward" value="true"/>
        <jsp:param name="isRow" value="true"/>
        <jsp:param name="rowFuncName" value="forViewPerson"/>
        <jsp:param name="isPage" value="true"/>
        <jsp:param name="fixcol" value="4"/>
        <jsp:param name="maskWarn" value="true"/>
    </jsp:include>
</td></tr>
</table>
</f:verbatim>
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