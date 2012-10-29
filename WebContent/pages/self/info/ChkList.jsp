<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<x:saveState value="#{emp_selfauditBB}"/>
<h:form id="form1">
   <h:inputHidden value="#{emp_selfauditBB.beginSelfUpdate}"/>
  <f:verbatim>
   <%
       String fk = CommonFuns.filterNull((String)session.getAttribute("selffk"));
   %>
   <table height=98% width=98% align="center">
    <tr><td height=8>
        <table width="50%" align="left">
            <tr>
                <td align="center" width="50%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="/self/info/ChkList.jsf?fk=<%=fk%>">�޸���Ϣ</a></td>
                <td align="center" width="50%" class=tab>&nbsp;<a href="/self/info/ChkInsertList.jsf?fk=<%=fk%>">������Ϣ</a></td>
            </tr>
        </table>
    </td></tr>


       <tr><td >
         <div style='width:100%;height:100%;overflow:auto' id=datatable>
  </f:verbatim>
          <h:dataTable align="center" width="98%"  value="#{emp_selfauditBB.updateList}" var="list"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle"   id="dateList"
                     styleClass="table03">
            <h:column>
                <f:facet name="header"><h:outputText value="�����"/></f:facet>
                <h:outputText value="#{list.persName}"/>
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="�޸���Ŀ"/></f:facet>
                <h:outputText value="#{list.fieldDes}"/>
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="ԭֵ"/></f:facet>
                <h:outputText value="#{list.oldValueDes}"/>
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="��ֵ"/></f:facet>
                <h:outputText value="#{list.newValueDes}"/>
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="�޸�ԭ��"/></f:facet>
                <h:outputText value="#{list.reason}"/>
            </h:column>

            <h:column>
                <f:facet name="header"><h:outputText value="״̬"/></f:facet>
                <h:outputText value="#{list.statusDes}"/>
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
