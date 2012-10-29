<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
     function selEvaPost(){
	  var str="";
	  var str2="";
      chk=document.forms(0).selectItem;
      if (checkMutilSelect(chk)){
          var size = chk.length;
          if (size == null) {
              if (chk.checked) {
            	  idnames =chk.value.split(":");
                  str+=idnames[0];
                  str2+=idnames[1];
              }
          } else {
              for (var i = 0; i < size; i++) {
                  if (chk[i].checked) {
                	  idnames =chk[i].value.split(":");
                      if (str==""){
                          str+=idnames[0];
                          str2+=idnames[1];
                      }
                      else{
                          str+=","+idnames[0];
                          str2+=","+idnames[1];
                      }
                  }
              }
          }
         if(str != null && str!=""){
        	 parent.selEvaPost(str+"|"+str2);
          }
      }
  }
</script>
<x:saveState value="#{xys_PlanPostMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_PlanPostMgrBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{xys_PlanPostMgrBB.superId}"></h:inputHidden>
    <h:inputHidden id="planId" value="#{xys_PlanPostMgrBB.planId}"></h:inputHidden>
    <c:verbatim>
        <table height=98% width=98% align="center">
        <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
        <h:panelGrid align="left">
            <h:panelGroup>
               <h:outputText value="记录数:#{xys_PlanPostMgrBB.mypage.totalRecord}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="页数:#{xys_PlanPostMgrBB.mypage.totalPage}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="每页有#{xys_PlanPostMgrBB.mypage.pageSize}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="当前为第#{xys_PlanPostMgrBB.mypage.currentPage}页"></h:outputText>
                <h:commandButton value="首页" action="#{xys_PlanPostMgrBB.first}" styleClass="button01"></h:commandButton>
                <h:commandButton value="上页" action="#{xys_PlanPostMgrBB.pre}" styleClass="button01"></h:commandButton>
                <h:commandButton value="下页" action="#{xys_PlanPostMgrBB.next}" styleClass="button01"></h:commandButton>
                <h:commandButton value="尾页" action="#{xys_PlanPostMgrBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>

        <h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:commandButton value="确认" type="button" styleClass="button01" onclick="selEvaPost();"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
        </td></tr>
        <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </c:verbatim>
    <h:dataTable value="#{xys_PlanPostMgrBB.postList}" var="list" align="center" id="dateList"
                 headerClass="td_top"
                 columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%">
        <h:column>
            <f:facet name="header">
                <f:verbatim escape="false">
                    <input type="checkbox" name="all"
                           onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                </f:verbatim>
            </f:facet>
            <f:verbatim escape="false">
                <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
            <h:outputText value="#{list.postId}:#{list.postName}"/>
            <f:verbatim escape="false">"/></div></f:verbatim>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="岗位名称"/></c:facet>
            <h:outputText value="#{list.postName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="所属部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
    </h:dataTable>
    <c:verbatim>
        </div>
        </td></tr>
        </table>
    </c:verbatim>

</h:form>
<script type="text/javascript">
    setDataTableOver("form1:dateList");
</script>
