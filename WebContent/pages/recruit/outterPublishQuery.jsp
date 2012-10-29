<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

    <script type="text/javascript">
       
    </script>

      <x:saveState value="#{recruit_outterPostBB}"></x:saveState>
      <h:form id="form1">
      <h:inputHidden id="initPublish" value="#{recruit_outterPostBB.initPublish}"></h:inputHidden>
      <h:inputHidden id="planID" value="#{recruit_outterPostBB.planId}"></h:inputHidden>
<c:verbatim>
          <table height=96% width=98% align="center">
          <tr><td height=8>
</c:verbatim>
          <h:panelGrid styleClass="td_title" width="98%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
             <h:panelGroup>
                  <h:graphicImage value="/images/tips.gif" />
                  <h:outputText value=" 招聘管理 ->  外部招聘"/>
              </h:panelGroup>
              <h:panelGrid align="right">
              </h:panelGrid>
          </h:panelGrid>
<c:verbatim>
         </td></tr>

          <tr>
              <td>
                  <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
                      <x:dataTable value="#{recruit_outterPostBB.postlist}" var="list"  rowIndexVar="index" id="data"
                                           headerClass="td_top tr_fixrow"
                                           columnClasses="td_middle" styleClass="table03" width="95%" border="0">

                         <h:column>
                              <c:facet name="header"><h:outputText value="序号"/></c:facet>
                              <h:outputText value="#{index+1}"/>
                          </h:column>

                          <h:column>
                              <c:facet name="header"><h:outputText value="公布时间"/></c:facet>
                              <h:outputText value="#{list.publishDate}"/>
                          </h:column>
                          <h:column rendered="#{recruit_outterPostBB.modeType=='0'}">
                              <c:facet name="header"><h:outputText value="所在部门"/></c:facet>
                              <h:outputText value="#{list.deptname}"/>
                          </h:column>

                          <h:column rendered="#{recruit_outterPostBB.modeType=='0'}">
                              <c:facet name="header"><h:outputText value="岗位名称"/></c:facet>
                              <h:commandLink value="#{list.postName}" onclick="forViewPost('#{list.postId}')"></h:commandLink>
                          </h:column>
                          <h:column rendered="#{recruit_outterPostBB.modeType=='1'}">
                              <c:facet name="header"><h:outputText value="岗位类型"/></c:facet>
                              <h:outputText value="#{list.postType}"/>
                          </h:column>
                          <h:column rendered="#{recruit_outterPostBB.modeType=='1'}">
                              <c:facet name="header"><h:outputText value="专业名称"/></c:facet>
                              <h:outputText value="#{list.majorType}"/>
                          </h:column>
						 <h:column>
                              <c:facet name="header"><h:outputText value="需求人数"/></c:facet>
                              <h:outputText value="#{list.needCount}"/>
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
