<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function forAddDate() {
        reval = window.showModalDialog("/common/DateEdit.jsf", null, "dialogWidth:450px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:no;");
        if (reval != null && reval != "") {
            var arg = reval.split("|");
            form1.all('form1:date').value = arg[0];
            return true;
        } else {
            return false;
        }
    }
    function showDetail(id){
        window.showModalDialog("/employee/introFee/FeePayOffDetail.jsf?payoffID="+id+"&ReadOnly=true", null, "dialogWidth:450px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:auto;");
        return false;
    }
    function editDetail(id){
        window.showModalDialog("/employee/introFee/FeePayOffDetail.jsf?payoffID="+id, null, "dialogWidth:450px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:auto;");
        return true;
    }

</script>

<x:saveState value="#{emp_introFeeBB}"></x:saveState>
<h:form id="form1">
    <f:verbatim>
    <table height=96% width=100% cellpadding="0" cellspacing="0">
     <tr><td height=8 class=td_title>
    </f:verbatim>
           <h:graphicImage value="/images/tips.gif" />
           <h:outputText value="介绍费管理"/>
     <f:verbatim>
      </td>
      <td align="right" class=td_title >
    </f:verbatim>
        <h:inputHidden id="date" value="#{emp_introFeeBB.date}"></h:inputHidden>
        <h:commandButton value="新建发放" styleClass="button01" onclick="return forAddDate();" action="#{emp_introFeeBB.addDate}"></h:commandButton>
    <f:verbatim>
      </td>
      </tr>

     <tr><td colspan="2">
            <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </f:verbatim>
            <h:dataTable value="#{emp_introFeeBB.payoffList}" var="list" align="center"  id="dateList"
                         headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                         styleClass="table03" width="100%" >
                <h:column>
                    <c:facet name="header"><h:outputText value="发放日期"/></c:facet>
                    <h:outputText value="#{list.operDate}"/>
                </h:column>
                <h:column>
                    <c:facet name="header"><h:outputText value="发放人数"/></c:facet>
                    <h:outputText value="#{list.count}"/>
                </h:column>
                <h:column>
                    <c:facet name="header"><h:outputText value="发放金额"/></c:facet>
                    <h:outputText value="#{list.sum}"/>
                </h:column>
                <h:column>
                    <c:facet name="header"><h:outputText value="操作"/></c:facet>
                    <h:commandButton value="查看明细" type="button" styleClass="button01" rendered="#{list.status=='1'}" onclick="showDetail('#{list.itemID}');"></h:commandButton>
                    <h:commandButton value="修改明细" styleClass="button01" rendered="#{list.status=='0'}" onclick="editDetail('#{list.itemID}');"></h:commandButton>
                </h:column>
            </h:dataTable>
    <f:verbatim>
        </div>
    </td></tr>
    </table>
    </f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
