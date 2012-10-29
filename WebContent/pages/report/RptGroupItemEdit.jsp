<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
   String groupId =  request.getParameter("rptGroupId");
%>

<x:saveState value="#{GroupDirBB}"/>
<h:form id="form1">
<h:inputHidden value="#{GroupDirBB.eiditGroupItemInit}"></h:inputHidden>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="机构"></h:outputText>
			<h:panelGroup>
                 <h:inputText id="orgId" value="#{GroupDirBB.rptGroupItemBO.orgId}" readonly = "true"
                                  size="20" styleClass="input" code="" dict="yes" dict_num="OU" />
                <h:commandButton onclick="PopUpOrgDlg('form1:orgId',2,'')" styleClass="button_select"  type="button">
                  <h:inputHidden value="#{GroupDirBB.groupDirId}"></h:inputHidden>
                </h:commandButton>
                
            </h:panelGroup>

			 <h:outputText value="顺序"></h:outputText>
              <h:inputText   value="#{GroupDirBB.rptGroupItemBO.seq}" />
              <h:inputHidden value="#{GroupDirBB.rptGroupItemBO.dirId}"> </h:inputHidden>
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{GroupDirBB.saveOrupdateGroupDirItem} "
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
