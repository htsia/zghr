<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{sys_wageselfItemBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{sys_wageselfItemBB.pageInit}"/>
    <c:verbatim>
    <table height=98% width=98% align="center">
      <tr><td height=8>
    </c:verbatim>
        <h:panelGrid align="center" columns="2" width="100%">
            <h:panelGroup>
                 <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1083","发薪单位：")%> 
                 </f:verbatim>
                <h:outputText value="#{sys_wageselfItemBB.unitName}"/>
                <h:outputText value="        "></h:outputText>
                <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1079","薪资账套：")%> 
                 </f:verbatim>
                <h:selectOneMenu id = "setId" value="#{sys_wageselfItemBB.setID}">
                     <c:selectItems value="#{sys_wageselfItemBB.setList}"/>
                </h:selectOneMenu>
                <h:commandButton value="开始设置" styleClass="button01" action="#{sys_wageselfItemBB.querySet}"></h:commandButton>
            </h:panelGroup>


            <h:panelGrid align="right" columns="1" width="100%">
                <h:commandButton value="保存" styleClass="button01" onclick="return forsubmit(document.forms(0));" action="#{sys_wageselfItemBB.Save}"></h:commandButton>
            </h:panelGrid>
        </h:panelGrid>
<c:verbatim>
      </td></tr>

      <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
        <h:dataTable value="#{sys_wageselfItemBB.wageitems}" var="list" width="100%" styleClass="table03"
                     headerClass="td_top"   id="dateList"
                     columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center,td_middle_center,td_middle_center">

            <h:column>
                <c:facet name="header">
                    <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1080","薪资项顺序")%>  
                 </f:verbatim>
                 </c:facet>
                <h:inputText alt="顺序|0|s|5||" value="#{list.seq}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                   <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1081","薪资项名称")%> 
                 </f:verbatim>
                 </c:facet>
                <h:outputText value="#{list.itemName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"> 
                 <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1082","是否用于自助")%> 
                 </f:verbatim>
                 </c:facet>
                <h:selectOneRadio value="#{list.canRead}">
                    <c:selectItem itemValue="1" itemLabel="是"></c:selectItem>
                    <c:selectItem itemValue="0" itemLabel="否"></c:selectItem>
                </h:selectOneRadio>
            </h:column>

        </h:dataTable>
<c:verbatim>
         </div>
      </td></tr>
      </table>
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
