<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

     
      <x:saveState value="#{wage_setItemBB}"></x:saveState>
      <h:form id="form1">
       <c:verbatim>
         <table height=96% width=98% cellspacing="0" align="center">
          <tr>
              <td height=8 class="td_title"> <img src="/images/tips.gif" alt="">帐套项目变化日志
              </td>
              <td height=8 class=td_title >
         </c:verbatim>
                <h:commandButton value="关闭" styleClass="button01" onclick="window.close();"></h:commandButton>
<c:verbatim>
              </td>
         </tr>
          <tr><td height=8 colspan=2></td></tr>
          <tr>
              <td colspan=2>
                  <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
                      <x:dataTable value="#{wage_setItemBB.changebos}" var="list"  rowIndexVar="index" id="data"
                                           headerClass="td_top tr_fixrow"
                                           columnClasses="td_middle" styleClass="table03" width="95%" border="0">

                          <h:column>
                              <c:facet name="header"><h:outputText value="序号"/></c:facet>
                              <h:graphicImage alt="新变化" value="/images/common/new.gif" rendered="#{list.popup!='1'}"/>
                              <h:outputText value="#{index+1}"/>
                          </h:column>

                          <h:column>
                              <c:facet name="header"><h:outputText value="变化时间"/></c:facet>
                              <h:outputText value="#{list.operateDate}"/>
                          </h:column>

                          <h:column>
                              <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                              <h:outputText value="#{list.operateName}"/>
                          </h:column>

                        <h:column>
                          <c:facet name="header"><h:outputText value="操作"/></c:facet>
                          <h:outputText value="#{list.actionDes}"/>
                        </h:column>


                        <h:column>
                          <c:facet name="header"><h:outputText value="项目名称"/></c:facet>
                          <h:outputText value="#{list.fieldName}"/>
                        </h:column>

                  </x:dataTable>
<c:verbatim>
                  </div>
              </td>
          </tr>
        </table>
</c:verbatim>
    </h:form>
    <form id="form2">
        <input type="hidden" name="perids"/>
    </form>

<script type="text/javascript">
    interpret(document.forms(0));
    setDataTableOver("form1:data");
</script>
