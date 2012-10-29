<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{cont_contPersonBB}"/>
<h:form id="form1">
    <h:inputHidden id="initAdjust" value="#{cont_contPersonBB.initAdjust}"/>
    <c:verbatim>
    <table height=98% width=98%>
    <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 合同管理 ->  集团内调入未签合同员工列表"/>
        </h:panelGroup>
    </h:panelGrid>
    <c:verbatim>
     </td></tr>

    <tr><td height=8>
    </c:verbatim>
    <h:panelGrid  border="0"  align="center" columns="1" width="95%">
         <h:panelGrid  border="0"  cellspacing="0" align="left" columns="3" >
             <h:outputText value="姓名或员工编号："/>
             <h:inputText styleClass="input" size="20" id="personNameQry" value="#{cont_contPersonBB.personNameQry}"/>
             <h:commandButton styleClass="button01" value=" 查询 " />
         </h:panelGrid>

        <h:panelGrid align="right" styleClass="locked_top">
            <h:panelGroup>
                <h:outputText value="记录数:#{cont_contPersonBB.pagevo.totalRecord}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="页数:#{cont_contPersonBB.pagevo.totalPage}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="每页有#{cont_contPersonBB.pagevo.pageSize}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="当前为第#{cont_contPersonBB.pagevo.currentPage}页"></h:outputText>
                <h:commandButton value="首页" action="#{cont_contPersonBB.adjustfirst}" styleClass="button01"></h:commandButton>
                <h:commandButton value="上页" action="#{cont_contPersonBB.adjustpre}" styleClass="button01"></h:commandButton>
                <h:commandButton value="下页" action="#{cont_contPersonBB.adjustnext}" styleClass="button01"></h:commandButton>
                <h:commandButton value="尾页" action="#{cont_contPersonBB.adjustlast}" styleClass="button01"></h:commandButton>
                <h:commandButton styleClass="button01" value="返回合同新签" action="cont_NewSignList_jsf"/>
            </h:panelGroup>
        </h:panelGrid>
     </h:panelGrid>
    <c:verbatim>
    </td></tr>

    <tr><td>
     <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </c:verbatim>
        <x:dataTable value="#{cont_contPersonBB.adjustList}" var="list"  rowIndexVar="index"
                         headerClass="td_top tr_fixrow"   align="center" id="dateList"
                         columnClasses="td_middle" styleClass="table03" width="95%" border="0">
                 <h:column>
                      <c:facet name="header">
                          <c:verbatim escape="false">
                          <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)"/>
                          </c:verbatim>
                          </c:facet>
                      <c:verbatim escape="false"><input type="checkbox" name="selected_ids" value="</c:verbatim>
                      <h:outputText value="#{list.personId}"/>
                      <c:verbatim>"></c:verbatim>
                  </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="序号"/></c:facet>
                    <h:outputText value="#{index+1}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="人员编号"/></c:facet>
                    <h:outputText value="#{list.personCode}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                    <h:outputText value="#{list.name}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="调出单位"/></c:facet>
                    <h:outputText value="#{list.fromOrgName}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="原单位合同情况"/></c:facet>
                    <h:outputText value="#{list.cont_old_end}"/>
                </h:column>
           </x:dataTable>
    <c:verbatim>
    </div>
    </td></tr>
    </table>
    </c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
