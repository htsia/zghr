<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

    <script type="text/javascript">
    </script>

      <x:saveState value="#{recruit_innerBB}"></x:saveState>
      <h:form id="form1">
          <h:inputHidden value="#{recruit_innerBB.initView}"></h:inputHidden>
<c:verbatim>
          <table height=96% width=98% align="center">
          <tr><td height=8>
</c:verbatim>
          <h:panelGrid styleClass="td_title" width="98%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1">
             <h:panelGroup>
                  <h:graphicImage value="/images/tips.gif" />
                  <h:outputText value=" ��Ƹ���� ->  �ڲ���Ƹ����"/>
              </h:panelGroup>
          </h:panelGrid>
<c:verbatim>
         </td></tr>

          <tr>
              <td>
                  <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
                      <x:dataTable value="#{recruit_innerBB.personlist}" var="list"  rowIndexVar="index" id="data"
                                           headerClass="td_top tr_fixrow"
                                           columnClasses="td_middle" styleClass="table03" width="95%" border="0">

                          <h:column>
                              <c:facet name="header"><h:outputText value="���"/></c:facet>
                              <h:outputText value="#{index+1}"/>
                          </h:column>

                          <h:column>
                              <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
                              <h:outputText value="#{list.applyDate}"/>
                          </h:column>

                          <h:column>
                              <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
                              <h:outputText value="#{list.pcode}"/>
                          </h:column>

                          <h:column>
                              <c:facet name="header"><h:outputText value="���ڲ���"/></c:facet>
                              <h:outputText value="#{list.dept}"/>
                          </h:column>

                          <h:column>
                              <c:facet name="header"><h:outputText value="����"/></c:facet>
                              <h:outputText value="#{list.pname}"/>
                          </h:column>

                  </x:dataTable>
<c:verbatim>
                  </div>
              </td>
          </tr>
        </table>
</c:verbatim>
    </h:form>

<c:verbatim>
<script type="text/javascript">
    setDataTableOver("form1:data");
</script>
</c:verbatim>
