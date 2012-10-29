<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
   
    <script type="text/javascript">
        function selectPost(){
            document.all('form1:postid').value="";
            fPopUpPostDlg('form1:postiddes','form1:postid');
            if (document.all('form1:postid').value==""){
                alert("请选择岗位!")
                return false;
            }
            return true;
        }
    </script>

      <x:saveState value="#{recruit_selfinnerBB}"></x:saveState>
      <h:form id="form1">
<c:verbatim>
          <table height=96% width=98% align="center">
          <tr><td height=8>
</c:verbatim>
          <h:panelGrid styleClass="td_title" width="98%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1">
             <h:panelGroup>
                  <h:graphicImage value="/images/tips.gif" />
                  <h:outputText value="内部招聘应聘"/>
              </h:panelGroup>
          </h:panelGrid>
<c:verbatim>
         </td></tr>

          <tr>
              <td>
                  <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
                      <x:dataTable value="#{recruit_selfinnerBB.postlist}" var="list"  rowIndexVar="index" id="data"
                                           headerClass="td_top tr_fixrow"
                                           columnClasses="td_middle" styleClass="table03" width="95%" border="0">

                          <h:column>
                              <c:facet name="header"><h:outputText value="序号"/></c:facet>
                              <h:outputText value="#{index+1}"/>
                          </h:column>
						  <h:column>
                              <c:facet name="header"><h:outputText value="单位"/></c:facet>
                              <h:outputText value="#{list.orgName}"/>
                          </h:column>
                          <h:column>
                              <c:facet name="header"><h:outputText value="公布时间"/></c:facet>
                              <h:outputText value="#{list.publishdate}"/>
                          </h:column>
                          <h:column>
                              <c:facet name="header"><h:outputText value="所在部门"/></c:facet>
                              <h:outputText value="#{list.deptname}"/>
                          </h:column>

                          <h:column>
                              <c:facet name="header"><h:outputText value="岗位名称"/></c:facet>
                              <h:outputText value="#{list.postname}"/>
                          </h:column>

                        <h:column>
                          <c:facet name="header"><h:outputText value="状态"/></c:facet>
                          <h:outputText value="#{list.statusDes}"/>
                        </h:column>

                          <h:column>
                            <c:facet name="header"><h:outputText value="应聘情况"/></c:facet>
                            <h:outputText value="#{list.applyDes}"/>
                          </h:column>

                        <h:column>
                            <c:facet name="header"><h:outputText value="操作"/></c:facet>
                            <h:commandButton value="查看岗位" styleClass="button01" type="button" onclick="forViewPostInSelf('#{list.postid}')"></h:commandButton>
                            <h:commandButton value="应聘" styleClass="button01"  action="#{recruit_selfinnerBB.apply}">
                                 <x:updateActionListener property="#{recruit_selfinnerBB.itemID}" value="#{list.itemid}"/>
                            </h:commandButton>
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
