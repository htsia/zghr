<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   <script type="text/javascript">
       function selPost(){
    	   fPopUpPostDlg(document.all("form1:A001715"),null,document.all("form1:orgId").value);
       }
       function chkData(){
             if (document.all('form1:A001715').value==""){
                alert("岗位不能为空!");
                return false;
             }else{
                forsubmit(document.forms(0));
             }
         }
   </script>
  <x:saveState value="#{xys_evaRelSetMgrBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{xys_evaRelSetMgrBB.initEdit}"></h:inputHidden>
      <h:inputHidden id="postId" value="#{xys_evaRelSetMgrBB.postId}"></h:inputHidden>
      <h:inputHidden id="orgId" value="#{xys_evaRelSetMgrBB.orgId}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 绩效管理 ->考核关系"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="岗位"></h:outputText>
			   <h:panelGroup>
                   <h:inputText styleClass="input" id="A001715" code="" dict="yes" dict_num="PO"
                     readonly="true" value="#{xys_evaRelSetMgrBB.relBO.evaPostId}"
                     alt="岗位|1|s|50||"/>
                   <h:commandButton type="button" styleClass="button_post" onclick="selPost()"></h:commandButton>
			   </h:panelGroup>
               <h:outputText value="考核关系"></h:outputText>
               <h:selectOneMenu value="#{xys_evaRelSetMgrBB.relBO.evaType}">
                      <c:selectItem itemLabel="上上级" itemValue="4"/>
                     <c:selectItem itemLabel="直接上级" itemValue="1"/>
                      <c:selectItem itemLabel="其他上级" itemValue="5"/>
                      <c:selectItem itemLabel="同级" itemValue="2"/>
                      <c:selectItem itemLabel="其他同级" itemValue="6"/>
                       <c:selectItem itemLabel="下级" itemValue="3"/>
               </h:selectOneMenu>
               
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="保存"  styleClass="button01"  action="#{xys_evaRelSetMgrBB.saveRel}" onclick="chkData();"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>