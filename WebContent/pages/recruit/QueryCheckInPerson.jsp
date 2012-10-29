<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

    <script type="text/javascript">
    function doQuery(id){
        window.showModalDialog("/recruit/resumeDetail2.jsf?personId="+id, "", "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.7+"px; status:0;resizable:yes");
        return true;
    }
    </script>

      <x:saveState value="#{recruit_outterPostBB}"></x:saveState>
      <h:form id="form1">
      <h:inputHidden id="initPublish" value="#{recruit_outterPostBB.initEnterPerson}"></h:inputHidden>
      <h:inputHidden id="planID" value="#{recruit_outterPostBB.planId}"></h:inputHidden>
<c:verbatim>
          <table height=96% width=98% align="center">
          <tr><td height=8>
</c:verbatim>
          <h:panelGrid styleClass="td_title" width="98%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1">
             <h:panelGroup>
                  <h:graphicImage value="/images/tips.gif" />
                  <h:outputText value=" 招聘管理 ->  查看录取人员"/>
              </h:panelGroup>
          </h:panelGrid>
<c:verbatim>
         </td></tr>

          <tr>
              <td>
                  <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
                      <x:dataTable value="#{recruit_outterPostBB.enterPersonList}" var="list"  rowIndexVar="index" id="data"
                                           headerClass="td_top tr_fixrow"
                                           columnClasses="td_middle" styleClass="table03" width="95%" border="0">

                          <h:column>
                              <c:facet name="header"><h:outputText value="序号"/></c:facet>
                              <h:outputText value="#{index+1}"/>
                          </h:column>
						  <h:column>
                              <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                              <h:outputText value="#{list.personName}"/>
                          </h:column>
                          <h:column>
                              <c:facet name="header"><h:outputText value="录取部门"/></c:facet>
                              <h:outputText value="#{list.deptName}"/>
                          </h:column>

                          <h:column rendered="#{recruit_outterPostBB.modeType=='0'}">
                              <c:facet name="header"><h:outputText value="岗位名称"/></c:facet>
                              <h:outputText value="#{list.postName}"/>
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
                			<c:facet name="header"><h:outputText value="操作"/></c:facet>
	                		<h:commandButton value="简历浏览" styleClass="button01"onclick="return doQuery('#{list.personId}');">
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
