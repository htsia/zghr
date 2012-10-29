<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "eno-cache");
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

<x:saveState value="#{sys_portalBB}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:inputHidden id="pageInit" value="#{sys_portalBB.pageInit}"/>
    <h:panelGrid align="center" width="98%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
             <f:verbatim>
                 <%=LanguageSupport.getResource("JGGL-1058"," 名称")%> 
             </f:verbatim>
            <h:inputText id="name" value="#{sys_portalBB.portalbo.itemName}" style="width:240px" />

             <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-1314"," 地址")%> 
             </f:verbatim>
            <h:inputText id="add" value="#{sys_portalBB.portalbo.url}" style="width:240px" />

             <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-1157"," 顺序")%> 
            </f:verbatim>
            <h:inputText id="seq" value="#{sys_portalBB.portalbo.seq}" />

            <h:outputText value="显示模式" style="width:60px"/>
            <h:selectOneMenu id="uimode" value="#{sys_portalBB.portalbo.uimode}" >
                <c:selectItem itemValue="1" itemLabel="嵌入应用"></c:selectItem>
                <c:selectItem itemValue="2" itemLabel="弹出应用"></c:selectItem>
                <c:selectItem itemValue="3" itemLabel="简单链接"></c:selectItem>
            </h:selectOneMenu>

            <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-1340"," 图标")%> 
            </f:verbatim>
            <h:panelGrid columns="1">
                <h:graphicImage value="/images/maininterface/portal/#{sys_portalBB.portalbo.icon}"  />
                <x:inputFileUpload id="blobFile" styleClass="input" value="#{sys_portalBB.blobFile}"  storage="file" size="25" />
           </h:panelGrid>

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{sys_portalBB.Save}"
                             onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>

