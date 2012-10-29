<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
   function showDetail(linkID){
       window.showModalDialog("/wage/gross/ShowApplyDetail.jsf?LinkID="+linkID, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
   }
</script>

<x:saveState value="#{wage_grossauditBB}"/>
<h:form id="form1">
<c:verbatim>
    <table  width=100%>
     <tr><td height=8>
</c:verbatim>
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF">
           <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value=" 集团薪酬管控 -> 变更过程"/>
            </h:panelGroup>
        </h:panelGrid>
    <c:verbatim>
     </td></tr>


      <tr><td height=8 align="right">
</c:verbatim>
    <h:dataTable value="#{wage_grossauditBB.changeList}" var="list" align="center"  id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >
            <h:column>
                <c:facet name="header"><h:outputText value="变更日期"/></c:facet>
                <h:outputText value="#{list.applyDate}"/>
            </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="变更人"/></c:facet>
            <h:outputText value="#{list.applyName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="变更项目"/></c:facet>
            <h:outputText value="#{list.fieldName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="原额度"/></c:facet>
            <h:outputText value="#{list.oldsum}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="新额度"/></c:facet>
            <h:outputText value="#{list.newsum}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="变更过程"/></c:facet>
            <h:commandButton value="查看" styleClass="button01" type="button" rendered="#{list.linkID!=null && list.linkID!=''}" onclick='showDetail("#{list.linkID}");'></h:commandButton>
        </h:column>

        </h:dataTable>
<c:verbatim>
      </td></tr>
     </table>
    </c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>

