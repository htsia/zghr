<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<script>
   function check(){
      if(document.all("form1:name").value == ""){
		alert("目录名称不能为空！");
		return false;
      }
	   }
</script>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{GroupDirBB}"/>
<h:form id="form1">
<h:inputHidden value="#{GroupDirBB.editGroupDirInit}"></h:inputHidden>
<h:inputHidden value="#{GroupDirBB.groupId}"></h:inputHidden>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
           
            <h:outputText value="上级节点"></h:outputText>
			<h:panelGroup>
                <h:inputText id="parentname" readonly="true" value="#{GroupDirBB.groupDirBO.parentName}" styleClass="input" />
                <h:inputHidden id="parentid" value="#{GroupDirBB.groupDirBO.parentId}"/>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpItemRptGroupDirTwoControl(document.all('form1:parentid'),document.all('form1:parentname'))"/>
                <h:inputHidden value="#{GroupDirBB.groupId}"></h:inputHidden>
            </h:panelGroup>
  
            <h:outputText value="节点名称"/>
            <h:inputText id="name" value="#{GroupDirBB.groupDirBO.dirName}" />
            
			 <h:outputText value="顺序"></h:outputText>
             <h:inputText   value="#{GroupDirBB.groupDirBO.seq}" />
             
             
               <h:outputText value="关联机构"></h:outputText>
			<h:panelGroup>
                 <h:inputText id="orgId" value="#{GroupDirBB.groupDirBO.orguId}" readonly = "true"
                                  size="20" styleClass="input" code="" dict="yes" dict_num="OU" />
                <h:commandButton onclick="PopUpOrgDlg('form1:orgId',2,'')" styleClass="button_select"  type="button">
                  <h:inputHidden value="#{GroupDirBB.groupId}"></h:inputHidden>
                </h:commandButton>
                
        </h:panelGroup>
             
        </h:panelGrid>

       

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{GroupDirBB.saveOrupdateGroupDir} "
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>


