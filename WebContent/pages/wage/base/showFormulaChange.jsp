<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <c:verbatim>
    <script type="text/javascript">
        function showContent(id){
            window.showModalDialog("/wage/base/FormulaChangeView.jsf?changeid="+id, null, "dialogWidth:600px; dialogHeight:540px;center:center;resizable:no;status:no;scroll:yes;");
            return false;
         }
    </script>
    </c:verbatim>

      <x:saveState value="#{wage_formulaBB}"></x:saveState>
      <h:form id="form1">
         <c:verbatim>
         <table height=96% width=98% cellspacing="0" align="center">
          <tr>
              <td height=8 class="td_title"><img src="/images/tips.gif" alt="">公式变化日志
              </td>
              <td height=8 class=td_title >
            </c:verbatim>
                <h:commandButton value="关闭" styleClass="button01" onclick="window.close();"></h:commandButton>
<c:verbatim>
              </td>
         </tr>

          <tr><td colspan=2 height=8></td></tr>
          <tr>
              <td colspan=2>
                  <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
                      <x:dataTable value="#{wage_formulaBB.changebos}" var="list"  rowIndexVar="index" id="dateList"
                                           headerClass="td_top tr_fixrow"
                                           columnClasses="td_middle" styleClass="table03" width="95%" border="0">

                          <h:column>
                              <c:facet name="header"><h:outputText value="序号"/></c:facet>
                              <h:graphicImage alt="新变化" value="/images/common/new.gif" rendered="#{list.popup!='1'}"/>
                              <h:outputText value="#{index+1}"/>
                          </h:column>

                          <h:column>
                              <c:facet name="header"><h:outputText value="变化时间"/></c:facet>
                              <h:outputText value="#{list.createDate}"/>
                          </h:column>

                          <h:column>
                              <c:facet name="header"><h:outputText value="变化项目"/></c:facet>
                              <h:outputText value="#{list.rsFieldname}"/>
                          </h:column>

                          <h:column>
                              <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                              <h:outputText value="#{list.creatorName}"/>
                          </h:column>

                          <h:column>
                              <c:facet name="header"><h:outputText value="操作"/></c:facet>
                              <h:commandButton value="查看内容" type="button" styleClass="button01" onclick="showContent('#{list.chgId}');"></h:commandButton>
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
    setDataTableOver("form1:dateList");
</script>
