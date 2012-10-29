<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<h:form>
    <f:verbatim>
    <table width="180" border="0" cellspacing="0" cellpadding="0">
          <tr><td>
          </f:verbatim>
                      <x:dataTable style="height:200px" headerClass="td_top" styleClass="table03"  width="98%"
                                   columnClasses="td_middle_left,td_middle_left" id="addressList"  align="center" border="0"  value="#{emp_AddressBB.selfdeptAddress}"    var="list">
                      <h:column>
                          <c:facet name="header"><h:outputText style="width:30px;color:#333333;" value="#{emp_AddressBB.nameTile}"/></c:facet>
                          <h:outputText value="#{list.name}"/>
                      </h:column>

                      <h:column>
                          <c:facet name="header"><h:outputText style="color:#333333;" value="#{emp_AddressBB.telTile}"/></c:facet>
                          <h:outputText value="#{list.officeTel}"/>
                      </h:column>

                  </x:dataTable>
        <f:verbatim>

          </td></tr>
        </table>
        </f:verbatim>
</h:form>


