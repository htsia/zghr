<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

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
    function beginApplySum(){
        window.showModalDialog("/wage/gross/ApplySum.jsf?fieldID="+document.all('form1:grossField').value+"&Year="+document.all('form1:year').value+"&OrgID="+document.all('form1:orgID').value, null, "dialogWidth:320px; dialogHeight:260px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
</script>
<x:saveState value="#{wage_grossBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_grossBB.initStauts}"/>
    <h:inputHidden id="orgID" value="#{wage_grossBB.orgID}"/>
    <h:inputHidden id="year" value="#{wage_grossBB.curYear}"/>
    <c:verbatim>
    <table height=98% width=100%>
     <tr><td height=8>
        <table width=100% cellspacing="0" cellpadding="0" class="td_title">
            <tr>
             <td>
    </c:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                    <h:outputText value=" 集团薪酬管控 -> 总量控制"/>
    <c:verbatim>
             </td>
             <td>
                  <h:outputText value="有追加额度申请" rendered="#{wage_grossBB.haveApply}"></h:outputText>
                  <h:commandButton value="审批" styleClass="button01" rendered="#{wage_grossBB.haveApply}"></h:commandButton>
             </td>
            </tr>
        </table>
     </td></tr>

     <tr><td height=8 align="left">
</c:verbatim>
         <h:outputText escape="false" value="<strong>当前年度:</strong>#{wage_grossBB.curYear}"></h:outputText>
         <h:outputText value="    "></h:outputText>

         <h:outputText escape="false" value="<strong>选择控制指标:</strong>"></h:outputText>
         <h:selectOneMenu id="grossField" value="#{wage_grossBB.grossField}">
             <c:selectItems value="#{wage_grossBB.grossFieldList}"></c:selectItems>
         </h:selectOneMenu>

         <h:commandButton id="count" value="统计" styleClass="button01"  action="#{wage_grossBB.beginCalc}" ></h:commandButton>
         <h:commandButton id="applySum" value="申请追加" styleClass="button01"  onclick="return beginApplySum();" rendered="#{wage_grossBB.showApply}"></h:commandButton>
         <h:commandButton id="export" value="导出" styleClass="button01" onclick="ExportShowTable();" type="button"></h:commandButton>
         <h:commandButton value="关闭" styleClass="button01" onclick="window.close()"></h:commandButton>
<c:verbatim>
    </td></tr>
     <tr><td height=8 align="left"></td></tr>

     <tr><td >
         <jsp:include page="/pages/common/activepage/ShowTable.jsp">
             <jsp:param name="para" value="true"/>
         </jsp:include>
     </td></tr>
    </table>
</c:verbatim>    
</h:form>
