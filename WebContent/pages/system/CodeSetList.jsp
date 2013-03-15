<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript" language="javascript">
        function doCheckSelect() {
            if (!checkMutilSelect(formCodeSetList.selectItem)) {
                alert("请选择项目!");
                return false;
            }
            return true;
        }

        function doExportCode(){
            window.showModalDialog("/system/CodeInfoToExport.jsf", null, "dialogWidth:400px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
        }
    </script>

<x:saveState value="#{sys_codeSetListBB}"/>
  <h:form id="formCodeSetList">
    <h:inputHidden id="pageInit" value="#{sys_codeSetListBB.pageInit}"/>
<f:verbatim>
    <table width="97%" height="96%" cellpadding="0" align="center" cellspacing="0" border="0" >
        <tr>
            <td height=8 class="td_title">
</f:verbatim>
                <h:graphicImage value="/images/tips.gif" />
                <f:verbatim>
                    <%=LanguageSupport.getResource("XTGL-0900","系统管理")%> ->
                    <%=LanguageSupport.getResource("XTGL-0910","代码管理")%>  
                </f:verbatim>
<f:verbatim>
            </td>
            <td class="td_title" height=8 align="right">
</f:verbatim>
              <h:commandButton styleClass="button01" onclick="doExportCode()" type="button" value="导出代码信息"></h:commandButton>
<f:verbatim>
            </td>
        </tr>
        <tr><td height=8 colspan=2>
</f:verbatim>
            <h:panelGrid columns="2" width="97%" cellpadding="0" 	align="center" border="0" >
                <h:panelGroup>
                    <h:selectBooleanCheckbox id="orderByName" value="#{sys_codeSetListBB.orderByName}" onclick="submit()" valueChangeListener="#{sys_codeSetListBB.outputByName}" ></h:selectBooleanCheckbox>
                    <f:verbatim>
                    <%=LanguageSupport.getResource("XTGL-1007","按名称排序")%>  
                   </f:verbatim>
                </h:panelGroup>
                <h:panelGrid align="right" columns="6">
                    <h:inputText value="" styleClass="input" id="searchName" />
                    <h:commandButton value="检 索" action="" styleClass="button01"  onclick="return forSearch(document.all('formCodeSetList:searchName').value)"  />
                    <h:commandButton value="新 建" action="add" styleClass="button01"  rendered="#{sys_codeSetListBB.operRight}" >
                    	<x:updateActionListener property="#{sys_codeSetEditBB.editStatus}" value="false"/>
                    	<x:updateActionListener property="#{sys_codeSetEditBB.moudleID}" value=""/>
                    </h:commandButton>
                    <h:commandButton value="删 除" action="#{sys_codeSetListBB.deleteCodeSets}" styleClass="button01"  rendered="#{sys_codeSetListBB.operRight}"  onclick="return checkBatchDelete('selectItem')" />
                    <h:commandButton value="启 用" action="#{sys_codeSetListBB.setStatusOpen}" onclick="return doCheckSelect();" styleClass="button01"  rendered="#{sys_codeSetListBB.operRight}"/>
                    <h:commandButton value="禁 用" action="#{sys_codeSetListBB.setStatusBan}" onclick="return doCheckSelect();" styleClass="button01"  rendered="#{sys_codeSetListBB.operRight}"/>
                </h:panelGrid>
            </h:panelGrid>
<f:verbatim>
           </td></tr>

           <tr><td colspan=2>
            <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
                <h:dataTable value="#{sys_codeSetListBB.codesets}" var="list" width="97%"   id="dateList"
                    headerClass="td_top tr_fixrow" columnClasses="td_middle" styleClass="table03"
                      border="0">
                    <h:column >
                        <f:facet name="header">
                            <f:verbatim escape="false">
                                <input type="checkbox" name="all" onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                            </f:verbatim>
                        </f:facet>
                        <f:verbatim escape="false">
                         <div align="center">    <input type="checkbox" name="selectItem" value="</f:verbatim>
                            <h:outputText value="#{list.setId}"/>
                            <f:verbatim escape="false">"/></div></f:verbatim>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                             <f:verbatim>
                    				<%=LanguageSupport.getResource("XTGL-1009","代码集名称")%>  
                            </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.setNameEx}" />
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                             <f:verbatim>
                    				<%=LanguageSupport.getResource("XTGL-1008","国标代码")%>  
                            </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.setDesc}" />
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                         <f:verbatim>
                    				<%=LanguageSupport.getResource("XTGL-1003","范围")%>  
                            </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.setScaleName}" />
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                             <f:verbatim>
                    				<%=LanguageSupport.getResource("XTGL-1010","录入标志")%>  
                            </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.setLayer}" />
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                             <f:verbatim>
                    				<%=LanguageSupport.getResource("XTGL-1051","启用/禁用")%>  
                            </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.setStatus}" />
                    </h:column>

                    <h:column>
                    <f:facet name="header">
                            <f:verbatim>
                    				<%=LanguageSupport.getResource("YXGL-1051","操作")%>  
                            </f:verbatim>
                   </f:facet>
                    <h:panelGrid align="center" cellspacing="2" columns="2">
                        <h:commandButton id="modify" styleClass="button01" action="edit"   value="维护代码集">
                            <x:updateActionListener property="#{sys_codeSetEditBB.setId}" value="#{list.setId}"/>
                            <x:updateActionListener property="#{sys_codeSetEditBB.editStatus}" value="true"/>
                            <x:updateActionListener property="#{sys_codeSetEditBB.moudleID}" value=""/>
                        </h:commandButton>
                        <h:commandButton id="view" styleClass="button01" action="itemlist" value="维护代码项">
                            <x:updateActionListener property="#{sys_codeItemListBB.setId}" value="#{list.setId}"/>
                            <x:updateActionListener property="#{sys_codeItemListBB.setName}" value="#{list.setName}"/>
                        </h:commandButton>
                     </h:panelGrid>
                    </h:column>
                </h:dataTable>
<f:verbatim>
            </div>
           </td></tr>
        </table>
</f:verbatim>
    </h:form>
<script type="text/javascript">
   setDataTableOver("formCodeSetList:dateList");
</script>