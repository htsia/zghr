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
        <h:outputText value=" ��ͬ���� ->  δǩ��ͬԱ���б�"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid  border="0"  align="center" columns="1" width="95%">
         <h:panelGrid  border="0"  cellspacing="0" align="left" columns="3" >
             <h:outputText value="������Ա����ţ�"/>
             <h:inputText styleClass="input" size="20" id="personNameQry" value="#{cont_contPersonBB.personNameQry}"/>
             <h:commandButton styleClass="button01" value=" ��ѯ " action="#{cont_contPersonBB.doQueryNew}"/>
         </h:panelGrid>

        <h:panelGrid align="right" styleClass="locked_top">
            <h:panelGroup>
                <h:outputText value="��¼��:#{cont_contPersonBB.pagevo.totalRecord}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="ҳ��:#{cont_contPersonBB.pagevo.totalPage}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="ÿҳ��#{cont_contPersonBB.pagevo.pageSize}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="��ǰΪ��#{cont_contPersonBB.pagevo.currentPage}ҳ"></h:outputText>
                <h:commandButton value="��ҳ" action="#{cont_contPersonBB.first}" styleClass="button01"></h:commandButton>
                <h:commandButton value="��ҳ" action="#{cont_contPersonBB.pre}" styleClass="button01"></h:commandButton>
                <h:commandButton value="��ҳ" action="#{cont_contPersonBB.next}" styleClass="button01"></h:commandButton>
                <h:commandButton value="βҳ" action="#{cont_contPersonBB.last}" styleClass="button01"></h:commandButton>
                <h:commandButton styleClass="button01" value="���غ�ͬ��ǩ" action="cont_NewSignList_jsf"/>
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
                <c:facet name="header"><h:outputText value="���"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��Ա���"/></c:facet>
                <h:outputText value="#{list.personCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:outputText value="#{list.name}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��Ա���"/></c:facet>
                <h:outputText value="#{list.personType}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�Ա�"/></c:facet>
                <h:outputText value="#{list.sex}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="���֤"/></c:facet>
                <h:outputText value="#{list.idCard}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="����˾ʱ��"/></c:facet>
                <h:outputText value="#{list.unitTime}"/>
            </h:column>
</x:dataTable>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>