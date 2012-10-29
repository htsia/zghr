<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
       function doCheck(){
           if (document.all("form1:name").value==""){
               alert("名称不能为空!");
               return false;
           }
           if (document.all("form1:add").value==""){
               alert("地址不能为空!");
               return false;
           }
           return true;
       }
    </script>

<x:saveState value="#{sys_linkEditBB}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:inputHidden id="pageInit" value="#{sys_linkEditBB.pageInit}"/>
    <h:panelGrid align="center" width="98%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
             <f:verbatim>
                 <%=LanguageSupport.getResource("JGGL-1058","名称 ")%>  
             </f:verbatim>
            <h:inputText id="name" value="#{sys_linkEditBB.fbo.linkName}" />

             <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-1314","地址 ")%>  
             </f:verbatim>
            <h:inputText id="add" value="#{sys_linkEditBB.fbo.linkURL}" />
 
              <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-1315","显示单位范围")%>  
             </f:verbatim>
                <h:panelGroup>
                    <h:selectOneMenu id="orgID" value="#{sys_linkEditBB.fbo.orguid}">
                        <c:selectItems value="#{sys_linkEditBB.orgList}"></c:selectItems>
                    </h:selectOneMenu>
                </h:panelGroup>

             <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-1157","顺序")%>  
             </f:verbatim>
            <h:inputText id="seq" value="#{sys_linkEditBB.fbo.showseq}" />

            <h:outputText escape="false" value="#{sys_linkEditBB.des}" style="width:60px"/>
            <h:panelGrid columns="1">
                <h:graphicImage value="/images/maininterface/friendlink/#{sys_linkEditBB.fbo.linkFile}"  />
                <x:inputFileUpload styleClass="input" id="blobFile" value="#{sys_linkEditBB.blobFile}"  storage="file" size="25" />
           </h:panelGrid>

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{sys_linkEditBB.Save}"
                             onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>

