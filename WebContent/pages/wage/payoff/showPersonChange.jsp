<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{wage_setPersonChangeBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="#{wage_setPersonChangeBB.pageInit}"></h:inputHidden>
<h:inputHidden value="#{wage_setPersonChangeBB.setId}"></h:inputHidden>    
<c:verbatim>
<table height=98% width=98% align="center">
   <tr><td height=8>
</c:verbatim>
       <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1">
          <h:panelGroup>
               <h:graphicImage value="/images/tips.gif" />
               <h:outputText value=" 薪酬管理 ->  帐套人员变化"/>
           </h:panelGroup>
       </h:panelGrid>
<c:verbatim>
   </td></tr>

    <tr><td height=8>
</c:verbatim>
        <h:outputText value="记录数:#{wage_setPersonChangeBB.pagevo.totalRecord}"></h:outputText>
        <h:outputText value="  "></h:outputText>
        <h:outputText value="页数:#{wage_setPersonChangeBB.pagevo.totalPage}"></h:outputText>
        <h:outputText value="  "></h:outputText>
        <h:outputText value="每页有#{wage_setPersonChangeBB.pagevo.pageSize}"></h:outputText>
        <h:outputText value="  "></h:outputText>
        <h:outputText value="当前为第#{wage_setPersonChangeBB.pagevo.currentPage}页"></h:outputText>
        <h:commandButton value="首页" action="#{wage_setPersonChangeBB.first}" styleClass="button01"></h:commandButton>
        <h:commandButton value="上页" action="#{wage_setPersonChangeBB.pre}" styleClass="button01"></h:commandButton>
        <h:commandButton value="下页" action="#{wage_setPersonChangeBB.next}" styleClass="button01"></h:commandButton>
        <h:commandButton value="尾页" action="#{wage_setPersonChangeBB.last}" styleClass="button01"></h:commandButton>
<c:verbatim>
    </td></tr>
    
    <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
        <x:dataTable value="#{wage_setPersonChangeBB.personList}" var="list"  rowIndexVar="index" id="data"
                             headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                             rowClasses="td_middle" styleClass="table03" width="95%" border="0">
                    <h:column>
                        <c:facet name="header"><h:outputText value="序号"/></c:facet>
                        <h:outputText value="#{index+1}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="员工编号"/></c:facet>
                        <h:outputText value="#{list.personCode}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                        <h:outputText value="#{list.personName}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="薪资部门"/></c:facet>
                        <h:outputText value="#{list.wageDetp}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="变化日期"/></c:facet>
                        <h:outputText value="#{list.changeDate}"/>
                    </h:column>


            <h:column>
                <c:facet name="header"><h:outputText value="增减情况"/></c:facet>
                <h:outputText value="#{list.addorminus}"/>
            </h:column>

        </x:dataTable>
<c:verbatim>
        </div>
    </td></tr>
</c:verbatim>    
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:data");
</script>