<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
    </script>

<x:saveState value="#{emp_PersonSendListBB}"/>
<h:form id="form1">
    <h:inputHidden id="fromOrg" value="#{emp_PersonSendListBB.fromOrgProcess}"/>

    <f:verbatim>
    <table height=98% width=98% align="center">
    <tr><td height=8>
    </f:verbatim>
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="3">
           <h:panelGroup>
               <h:graphicImage value="/images/tips.gif" />
               <h:outputText value="������� ->  ��������Ա����"/>
            </h:panelGroup>
        </h:panelGrid>
    <f:verbatim>
    </td></tr>


    <tr><td align="right" height=8>
    </f:verbatim>
            <h:outputText value="��¼��:#{emp_PersonSendListBB.pagevo.totalRecord}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="ҳ��:#{emp_PersonSendListBB.pagevo.totalPage}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="ÿҳ��#{emp_PersonSendListBB.pagevo.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="��ǰΪ��#{emp_PersonSendListBB.pagevo.currentPage}ҳ"></h:outputText>
            <h:commandButton value="��ҳ" action="#{emp_PersonSendListBB.first}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{emp_PersonSendListBB.pre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{emp_PersonSendListBB.next}" styleClass="button01"></h:commandButton>
            <h:commandButton value="βҳ" action="#{emp_PersonSendListBB.last}" styleClass="button01"></h:commandButton>
    <f:verbatim>
    </td></tr>

    <tr><td >
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </f:verbatim>
            <h:dataTable value="#{emp_PersonSendListBB.fromOrgPerson}" var="list" align="center"  id="dateList"
                         headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                         styleClass="table03">
                <h:column>
                    <c:facet name="header"><h:outputText value="��������" style="width:80px"/></c:facet>
                    <h:outputText value="#{list.applyDate}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="Ա�����" style="width:80px"/></c:facet>
                    <h:outputText value="#{list.personCode}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����" style="width:80px"/></c:facet>
                    <h:outputText value="#{list.name}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="���" style="width:120px"/></c:facet>
                    <h:outputText value="#{list.degree}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="ԭ��λ" style="width:120px"/></c:facet>
                    <h:outputText value="#{list.fromOrgName}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="������λ" style="width:120px"/></c:facet>
                    <h:outputText value="#{list.toOrgName}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="�����������" style="width:120px"/></c:facet>
                    <h:outputText value="#{list.oldOrgWageSet}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText style="width:100px"  value="ԭ��λ��ͬ���" /></c:facet>
                    <h:outputText value="#{list.cont_old_end}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText style="width:100px" value="���뵥λ���" /></c:facet>
                    <h:outputText value="#{list.toOpinionDes}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����״̬" style="width:130px"/></c:facet>
                    <h:outputText value="#{list.applyStatusDes}" />
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
