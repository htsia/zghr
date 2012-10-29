<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
</script>

<x:saveState value="#{emp_introFeeBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{emp_introFeeBB.initPayoff}"></h:inputHidden>
    <f:verbatim>
    <table height=96% width=100% cellpadding="0" cellspacing="0">
     <tr><td height=8 class=td_title>
    </f:verbatim>
           <h:graphicImage value="/images/tips.gif" />
           <h:outputText value="介绍费管理"/>
     <f:verbatim>
      </tr>

         <tr><td height=8 align="right">
        </f:verbatim>
              <h:commandButton value="计算" styleClass="button01" rendered="#{!emp_introFeeBB.readonly}"></h:commandButton>
              <h:commandButton value="结束" styleClass="button01" rendered="#{!emp_introFeeBB.readonly}"></h:commandButton>
         <f:verbatim>
          </tr>

     <tr><td colspan="2">
            <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </f:verbatim>
            <h:dataTable value="#{emp_introFeeBB.detailList}" var="list" align="center"  id="dateList"
                         headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                         styleClass="table03" width="100%" >
                <h:column>
                    <c:facet name="header"><h:outputText value="学员"/></c:facet>
                    <h:outputText value="#{list.personName}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="发放金额"/></c:facet>
                    <h:outputText value="#{list.sum}"/>
                </h:column>
                <h:column>
                    <c:facet name="header"><h:outputText value="操作"/></c:facet>
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
