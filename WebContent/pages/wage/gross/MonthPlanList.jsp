<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<script language="javascript">
    function addPlan() {
        window.showModalDialog("/wage/gross/AddGrossPlan.jsf", null, "dialogWidth:450px; dialogHeight:180px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
    function inputData() {
        if (checkMutilSelect(form1.chk)) {
            count = form1.chk.length;
            var str = "";
            if (count != null) {
                for (i = 0; i < count; i++)
                    if (form1.chk[i].checked) {
                        str += form1.chk[i].value + ",";
                    }
            } else
                str = form1.chk.value;
            var url="/wage/gross/GrossMonthInput.jsf?curYearMonth="+document.all('form1:curYearMonth').value+"&OrgIDs="+str;
            //alert(url);
            window.showModalDialog(url, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
         }
         else{
            alert("请选择机构!");
            return false;
         }
    }
</script>
<x:saveState value="#{wage_grossBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_grossBB.monthList}"/>

   <f:verbatim>
    <table height=98% width=100%>
      <tr><td class="td_title" height=18>
    </f:verbatim>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value=" 集团薪酬管控 -> 月计划管理"/>
    <f:verbatim>
      </td></tr>

     <tr><td height=1>
      </f:verbatim>
            <h:outputText  value="当前月份:"></h:outputText>
            <h:inputText id="curYearMonth" readonly="true" value="#{wage_grossBB.curYearMonth}"></h:inputText>
            <c:verbatim>
                <input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:curYearMonth')">
            </c:verbatim>
            <h:commandButton value="查询" styleClass="button01" action="#{wage_grossBB.findUnitMonthPlan}"></h:commandButton>
            <h:commandButton value="录入数据" styleClass="button01" action="#{wage_grossBB.findUnitMonthPlan}" onclick="inputData();"  />
            <h:commandButton value="计算" styleClass="button01" action="#{wage_grossBB.findUnitMonthPlan}" onclick="addPlan();"  rendered="false"/>
<f:verbatim>
    </td></tr>
    <tr><td>
    <jsp:include page="/pages/common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="false"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="false"/>
        <jsp:param name="keyName" value="ORGUID"/>
        <jsp:param name="fixcol" value="4"/>
    </jsp:include>
    </td></tr>
    </table>
</f:verbatim>
</h:form>
