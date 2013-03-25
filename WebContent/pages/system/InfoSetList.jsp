<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

    <%
        response.setHeader("progma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    %>
<script type="text/javascript">
    function doCheckSelect() {
        if (!checkMutilSelect(formInfoSetList.selectItem)) {
            alert("请选择项目!");
            return false;
        }
        return true;
    }
</script>

<x:saveState value="#{sys_infoSetListBB}"/>
<h:form id="formInfoSetList">
    <h:inputHidden id="pageInit" value="#{sys_infoSetListBB.pageInit}"/>
    <h:inputHidden  id="set_sType" value="#{sys_infoSetListBB.set_sType}"/>
    <h:inputHidden  id="set_bType" value="#{sys_infoSetListBB.set_bType}"/>
    <h:inputHidden  value="#{sys_infoSetListBB.onlyUse}"/>
    <h:panelGrid columns="2" width="97%" cellpadding="0" align="left"   cellspacing="0" border="0" >
        <h:panelGrid columns="1" width="50%" cellpadding="0"     align="left" border="0" >
            <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-1001","当前信息集列表")%>  
            </f:verbatim>
        </h:panelGrid>

        <h:panelGrid columns="1" width="50%" cellpadding="0"    align="right" border="0" >
            <h:panelGroup>
                <h:commandButton value="新 建" action="add" styleClass="button01" rendered="#{sys_infoSetListBB.operRight}">
                    <x:updateActionListener property="#{sys_infoSetEditBB.editStatus}" value="false"/>
                    <x:updateActionListener property="#{sys_infoSetEditBB.set_sType}" value="#{sys_infoSetListBB.set_sType}"/>
                    <x:updateActionListener property="#{sys_infoSetEditBB.set_bType}" value="#{sys_infoSetListBB.set_bType}"/>
                </h:commandButton>
                <h:commandButton value="删 除" action="#{sys_infoSetListBB.deleteInfoSets}" styleClass="button01"  rendered="#{sys_infoSetListBB.operRight}"  onclick="return checkBatchDelete('selectItem')"/>
                <h:commandButton value="启 用" action="#{sys_infoSetListBB.setStatusOpen}"  onclick="return doCheckSelect();" rendered="#{sys_infoSetListBB.operRight}" styleClass="button01"/>
                <h:commandButton value="禁 用" action="#{sys_infoSetListBB.setStatusBan}"  onclick="return doCheckSelect();" rendered="#{sys_infoSetListBB.operRight}" styleClass="button01"/>
            </h:panelGroup>
        </h:panelGrid>
     </h:panelGrid>

    <f:verbatim>
        <br>
        <br>
        <br>
    </f:verbatim>

    <h:dataTable value="#{sys_infoSetListBB.tableList}" var="list"   width="600" id="dateList"
                 headerClass="td_top" rowClasses="td_middle" styleClass="table03"
                 border="1" align="left">
        <h:column>
            <f:facet name="header">
                <f:verbatim escape="false"> <input type="checkbox" name="all"  onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"
                </f:verbatim>
                <h:outputText  value="#{list.checkReadOnly}"></h:outputText>

            </f:facet>
            <f:verbatim escape="false">
             <div align="center">
              <input type="checkbox" name="selectItem" value="</f:verbatim>
            <h:outputText value="#{list.setId}"/>
            <f:verbatim escape="false">"/></div>
            </f:verbatim>
        </h:column>

        <h:column>
            <f:facet name="header">
            <f:verbatim>
                    <%=LanguageSupport.getResource("YXGL-1026","操作")%>
            </f:verbatim>
            </f:facet>
            <h:panelGrid align="center" cellspacing="2" columns="2">
                <h:commandButton id="modify" styleClass="button01" action="edit"   value="修改属性" rendered="#{list.setProperty!='3'}">
                     <x:updateActionListener property="#{sys_infoSetEditBB.editStatus}" value="true"/>
                    <x:updateActionListener property="#{sys_infoSetEditBB.setId}" value="#{list.setId}"/>
                </h:commandButton>
                <h:commandButton id="view" styleClass="button01" action="itemlist" value="修改指标">
                    <x:updateActionListener property="#{sys_infoItemListBB.setId}" value="#{list.setId}"/>
                    <x:updateActionListener property="#{sys_infoItemListBB.setName}" value="#{list.setName}"/>
                    <x:updateActionListener property="#{sys_infoItemListBB.set_sType}" value="#{sys_infoSetListBB.set_sType}"/>
                </h:commandButton>
            </h:panelGrid>
        </h:column>
        <h:column>
            <f:facet name="header">
                <f:verbatim>
                    <%=LanguageSupport.getResource("JGGL-1058","名称")%>  
                </f:verbatim>
            </f:facet>
            <h:outputText escape="false" value="#{list.setNameEx}"/>
        </h:column>

        <h:column>
            <f:facet name="header">
                <f:verbatim>
                    <%=LanguageSupport.getResource("XTGL-1002","类型")%>  
                </f:verbatim>
            </f:facet>
            <h:outputText escape="false" value="#{list.setPropertyDes}"/>
        </h:column>

        <h:column>
            <f:facet name="header">
               <f:verbatim>
                    <%=LanguageSupport.getResource("XTGL-1003","範圍")%>  
                </f:verbatim>
            </f:facet>
            <h:outputText escape="false" value="#{list.setScaleName}"/>
        </h:column>
        <h:column>
            <f:facet name="header">
                <f:verbatim>
                    <%=LanguageSupport.getResource("XTGL-1004","记录类型")%>  
                </f:verbatim>
            </f:facet>
            <h:outputText escape="false" value="#{list.set_rsType}"/>
        </h:column>

        <h:column>
            <f:facet name="header">
                 <f:verbatim>
                    <%=LanguageSupport.getResource("XTGL-1005","显示顺序")%>  
                </f:verbatim>
            </f:facet>
            <h:outputText escape="false" value="#{list.setSequence}"/>
        </h:column>

        <h:column>
            <f:facet name="header">
                <f:verbatim>
                    <%=LanguageSupport.getResource("XTGL-1006","启用/禁用")%>  
                </f:verbatim>
            </f:facet>
            <h:outputText escape="false" value="#{list.setStatus}"/>
        </h:column>


    </h:dataTable>
</h:form>
<script type="text/javascript">
   setDataTableOver("formInfoSetList:dateList");
</script>
