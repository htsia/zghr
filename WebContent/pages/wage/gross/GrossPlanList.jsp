<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<script language="javascript">
    function addPlan() {
        window.showModalDialog("/wage/gross/AddGrossPlan.jsf", null, "dialogWidth:450px; dialogHeight:180px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }

    function AuditApplySum() {
        window.showModalDialog("/wage/gross/AuditApplySum.jsf", null, "dialogWidth:580px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
    function forView(form, id, right) {
        var arg = "orgID="+id;
        window.showModalDialog("/wage/gross/ShowSumChange.jsf?"+arg, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
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
            window.showModalDialog("/wage/gross/GrossInput.jsf?Year="+document.all('form1:year').value+"&OrgIDs="+str, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
         }
         else{
            alert("请选择机构!");
            return false;
         }
    }
     function viewFinish(){
        window.showModalDialog("/wage/gross/GrossPlanStauts.jsf?Year="+document.all('form1:year').value, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
        return false;
    }
</script>
<x:saveState value="#{wage_grossBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_grossBB.pageInit}"/>

    <f:verbatim>
    <table height=98% width=98%>
     <tr><td height=8>
        <table width=100% cellspacing="0" cellpadding="0" class="td_title">
            <tr>
             <td>
    </f:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                    <h:outputText value=" 集团薪酬管控 -> 总量控制"/>
    <f:verbatim>
             </td>
             <td align="right">
    </f:verbatim>
                  <h:outputText value="有追加额度申请" rendered="#{wage_grossBB.haveApply}"></h:outputText>
                  <h:commandButton value="审批" onclick="return AuditApplySum();" styleClass="button01" rendered="#{wage_grossBB.haveApply}" action="#{wage_grossBB.findUnitPlan}"></h:commandButton>
    <f:verbatim>
             </td>
            </tr>
        </table>
     </td></tr>

     <tr><td height=8>
    </f:verbatim>
        <h:panelGrid columns="3" width="95%" align="center">
            <h:panelGroup>
                <h:outputText escape="false" value="<strong>当前年度:</strong>"></h:outputText>
                <h:selectOneMenu id="year" value="#{wage_grossBB.curYear}" >
                    <c:selectItems value="#{wage_grossBB.grossList}"></c:selectItems>
                </h:selectOneMenu>
                <h:commandButton value="查询" styleClass="button01" action="#{wage_grossBB.findUnitPlan}"></h:commandButton>
            </h:panelGroup>

            <h:panelGroup>
                  <h:commandButton value="录入数据" styleClass="button01" action="#{wage_grossBB.findUnitPlan}" onclick="inputData();"  />
                  <h:commandButton value="查询完成情况" styleClass="button01" type="button" onclick="viewFinish();"  />
                  <h:commandButton value="计算" styleClass="button01" action="#{wage_grossBB.findUnitPlan}" onclick="addPlan();"  rendered="false"/>
            </h:panelGroup>

            <h:panelGrid cellspacing="2" columns="2" align="right">
                <h:commandButton value="开始新年度" styleClass="button01" onclick="addPlan();"  action="#{wage_grossBB.initList}"/>
            </h:panelGrid>
        </h:panelGrid>
    <f:verbatim>
     </td></tr>

     <tr><td >
        <jsp:include page="/pages/common/activepage/ActiveList.jsp">
            <jsp:param name="hasOperSign" value="true"/>
            <jsp:param name="operSignType" value="checkbox"/>
            <jsp:param name="hasEdit" value="true"/>
            <jsp:param name="editName" value="变更情况"/>
            <jsp:param name="editFuncName" value="forView"/>
            <jsp:param name="isForward" value="false"/>
            <jsp:param name="isEditList" value="false"/>
            <jsp:param name="isCheckRight" value="false"/>
            <jsp:param name="keyName" value="ORGUID"/>
            <jsp:param name="fixcol" value="4"/>
        </jsp:include>
     </td></tr>
    </table>
    </f:verbatim>
</h:form>
