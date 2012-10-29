<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">

      function postMgr(id) {
        window.showModalDialog("/xys/eva/RelSetPostList.jsf?postId="+id, null, "dialogWidth:"+screen.width*0.7+"px;dialogHeight:500px;center:center;resizable:no;status:no;scroll:no;");
        return true;
       }
      function roleSet(){
      	var str="";
          chk=document.forms(0).selectItem;
          if (checkMutilSelect(chk)){
              var size = chk.length;
              if (size == null) {
                  if (chk.checked) {
                      str+=chk.value;
                  }
              } else {
                  for (var i = 0; i < size; i++) {
                      if (chk[i].checked) {
                          if (str==""){
                              str+=chk[i].value;
                          }
                          else{
                              str+=","+chk[i].value;
                          }
                      }
                  }
              }
             if(str != null && str!=""){
            	document.all("form1:postIds").value =str;
            	var returnValue=window.showModalDialog("/xys/eva/SelEvaRole.jsf", null, "dialogWidth:"+screen.width*0.6+"px;dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
                if(returnValue!=null){
              	  document.all("form1:roleId").value=returnValue;
                  return true; 
                }else{
              	  return false;
                }
             }
          }else{
          	alert("请选择！");
          	return false;
          }
          
      }
      
    </script>

<x:saveState value="#{xys_evaRelSetMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_evaRelSetMgrBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{xys_evaRelSetMgrBB.superId}"></h:inputHidden>
    <h:inputHidden id="roleId" value="#{xys_evaRelSetMgrBB.roleId}"></h:inputHidden>
    <h:inputHidden id="postIds" value="#{xys_evaRelSetMgrBB.postIds}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="3">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="当前机构:"></h:outputText>
                  <h:outputText value="#{xys_evaRelSetMgrBB.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:commandButton value="设置角色" onclick="return roleSet('#{list.postId}');" action="#{xys_evaRelSetMgrBB.setRole}" styleClass="button01"></h:commandButton>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="记录数:#{xys_evaRelSetMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{xys_evaRelSetMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{xys_evaRelSetMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{xys_evaRelSetMgrBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{xys_evaRelSetMgrBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{xys_evaRelSetMgrBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{xys_evaRelSetMgrBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{xys_evaRelSetMgrBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{xys_evaRelSetMgrBB.postList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
        
        <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox"  name="all"
                                   onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                    <h:outputText value="#{list.postId}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="岗位名称"/></c:facet>
            <h:outputText value="#{list.name}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="所属部门"/></c:facet>
            <h:outputText value="#{list.orgId}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="上级岗位"/></c:facet>
            <h:outputText value="#{list.superId}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="岗位类别"/></c:facet>
            <h:outputText value="#{list.postType}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="岗位级别"/></c:facet>
            <h:outputText value="#{list.postLevel}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="绩效角色"/></c:facet>
            <h:outputText value="#{list.roleId}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="是否维护"/></c:facet>
            <h:outputText value="#{list.isCtr}" escape="false"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="考核关系维护" onclick="return postMgr('#{list.postId}')" styleClass="button01"></h:commandButton>
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
