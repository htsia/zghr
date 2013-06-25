<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   <script type="text/javascript">
       function chkData(){
    	   var type=document.all('form1:type').value;
    	   if(type=='2'){
    		   if(!checkValidate(form1.all('form1:weightPreLeader'), '���ϼ�Ȩ��', 'i')){
                   return false;
                }else if(!checkValidate(form1.all('form1:weightLeader'), 'ֱ���ϼ�','i')){
                    return false;
                }else if(!checkValidate(form1.all('form1:weightOtherLeader'), '�����ϼ�', 'i')){
                   return false;
                }else if(!checkValidate(form1.all('form1:weightVis'), 'ͬ��Ȩ��', 'i')){
                   return false;
                }else if(!checkValidate(form1.all('form1:weightOtherVis'), '����ͬ��Ȩ��', 'i')){
                   return false;
                }else if(!checkValidate(form1.all('form1:weightLower'), '�¼�Ȩ��', 'i')){
                   return false;
                }else{
                   return true;
                }  
    	   }else{
    		   if(!checkValidate(form1.all('form1:weightPreLeader'), '���ϼ�Ȩ��', 'i')){
                   return false;
                }else if(!checkValidate(form1.all('form1:weightLeader'), 'ֱ���ϼ�','i')){
                    return false;
                }else if(!checkValidate(form1.all('form1:weightOtherLeader'), '�����ϼ�', 'i')){
                   return false;
                }else{
                   return true;
                }  
    	   }

       }
   </script>
  <x:saveState value="#{xys_PlanPostMgrBB}" />
  <h:form id="form1">
      <h:inputHidden id="initLevel" value="#{xys_PlanPostMgrBB.initLevel}"></h:inputHidden>
      <h:inputHidden id="planId" value="#{xys_PlanPostMgrBB.planId}"></h:inputHidden>
      <h:inputHidden id="postId" value="#{xys_PlanPostMgrBB.postId}"></h:inputHidden>
      <h:inputHidden id="type" value="#{xys_PlanPostMgrBB.type}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ��Ч���� ->�㼶Ȩ������"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
              <h:outputText value="���ϼ�Ȩ�أ�%��"/>
              <h:inputText id="weightPreLeader" value="#{xys_PlanPostMgrBB.levelBo.weightPreLeader}" />
               <h:outputText value="ֱ���ϼ�Ȩ�أ�%��"/>
              <h:inputText id="weightLeader" value="#{xys_PlanPostMgrBB.levelBo.weightLeader}" />
               <h:outputText value="�����ϼ�Ȩ�أ�%��"/>
              <h:inputText id="weightOtherLeader" value="#{xys_PlanPostMgrBB.levelBo.weightOtherLeader}" />
              <h:outputText value="ͬ��Ȩ�أ�%��" rendered="#{xys_PlanPostMgrBB.type=='2'}"/>
              <h:inputText id="weightVis" value="#{xys_PlanPostMgrBB.levelBo.weightVis}" rendered="#{xys_PlanPostMgrBB.type=='2'}"/>
               <h:outputText value="����ͬ��Ȩ�أ�%��" rendered="#{xys_PlanPostMgrBB.type=='2'}" />
              <h:inputText id="weightOtherVis" value="#{xys_PlanPostMgrBB.levelBo.weightOtherVis}" rendered="#{xys_PlanPostMgrBB.type=='2'}"/>
              <h:outputText value="�¼�Ȩ�أ�%��" rendered="#{xys_PlanPostMgrBB.type=='2'}"/>
              <h:inputText id="weightLower" value="#{xys_PlanPostMgrBB.levelBo.weightLower}" rendered="#{xys_PlanPostMgrBB.type=='2'}" />
              <h:outputText value="�Ƿ�ϲ�" rendered="#{xys_PlanPostMgrBB.type=='1'}"/>
              <h:selectOneMenu value="#{xys_PlanPostMgrBB.levelBo.gradeType}" rendered="#{xys_PlanPostMgrBB.type=='1'}">
              		<c:selectItem itemLabel="�ϲ�" itemValue="1"/>
              		<c:selectItem itemLabel="���ϲ�" itemValue="0"/>
              </h:selectOneMenu>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="����"  styleClass="button01"  action="#{xys_PlanPostMgrBB.saveLevel}" onclick="return chkData();"/>
           </h:panelGrid>
           
          
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>