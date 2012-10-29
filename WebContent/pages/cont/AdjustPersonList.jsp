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
        <h:outputText value=" ��ͬ���� ->  �����ڵ���δǩ��ͬԱ���б�"/>
        </h:panelGroup>
    </h:panelGrid>
    <c:verbatim>
     </td></tr>

    <tr><td height=8>
    </c:verbatim>
    <h:panelGrid  border="0"  align="center" columns="1" width="95%">
         <h:panelGrid  border="0"  cellspacing="0" align="left" columns="3" >
             <h:outputText value="������Ա����ţ�"/>
             <h:inputText styleClass="input" size="20" id="personNameQry" value="#{cont_contPersonBB.personNameQry}"/>
             <h:commandButton styleClass="button01" value=" ��ѯ " />
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
                <h:commandButton value="��ҳ" action="#{cont_contPersonBB.adjustfirst}" styleClass="button01"></h:commandButton>
                <h:commandButton value="��ҳ" action="#{cont_contPersonBB.adjustpre}" styleClass="button01"></h:commandButton>
                <h:commandButton value="��ҳ" action="#{cont_contPersonBB.adjustnext}" styleClass="button01"></h:commandButton>
                <h:commandButton value="βҳ" action="#{cont_contPersonBB.adjustlast}" styleClass="button01"></h:commandButton>
                <h:commandButton styleClass="button01" value="���غ�ͬ��ǩ" action="cont_NewSignList_jsf"/>
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
                    <c:facet name="header"><h:outputText value="������λ"/></c:facet>
                    <h:outputText value="#{list.fromOrgName}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="ԭ��λ��ͬ���"/></c:facet>
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
