<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{cont_contPersonBB}"/>
<h:form id="form1">
    <h:inputHidden id="init_a" value="#{cont_contPersonBB.init_a}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 合同管理 ->  未签合同员工列表"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid  border="0"  align="center" columns="1" width="95%">
         <h:panelGrid  border="0"  cellspacing="0" align="left" columns="3" >
             <h:outputText value="姓名或员工编号："/>
             <h:inputText styleClass="input" size="20" id="personNameQry" value="#{cont_contPersonBB.personNameQry}"/>
             <h:commandButton styleClass="button01" value=" 查询 " action="#{cont_contPersonBB.doQueryNew}"/>
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
                <h:commandButton value="首页" action="#{cont_contPersonBB.first}" styleClass="button01"></h:commandButton>
                <h:commandButton value="上页" action="#{cont_contPersonBB.pre}" styleClass="button01"></h:commandButton>
                <h:commandButton value="下页" action="#{cont_contPersonBB.next}" styleClass="button01"></h:commandButton>
                <h:commandButton value="尾页" action="#{cont_contPersonBB.last}" styleClass="button01"></h:commandButton>
                <h:commandButton styleClass="button01" value="返回合同新签" action="cont_NewSignList_jsf"/>
            </h:panelGroup>
        </h:panelGrid>
        
     </h:panelGrid>

    <x:dataTable value="#{cont_contPersonBB.newps}" var="list"  rowIndexVar="index" align="center"
                     headerClass="td_top" id="dateList"
                     rowClasses="td_middle" styleClass="table03" width="95%" border="1">
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
                <c:facet name="header"><h:outputText value="人员类别"/></c:facet>
                <h:outputText value="#{list.personType}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="性别"/></c:facet>
                <h:outputText value="#{list.sex}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="身份证"/></c:facet>
                <h:outputText value="#{list.idCard}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="来公司时间"/></c:facet>
                <h:outputText value="#{list.unitTime}"/>
            </h:column>
</x:dataTable>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>