<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function doCheckSelect() {
        if (!checkMutilSelect(formCodeItemList.selectItem)) {
            alert("请选择项目!");
            return false;
        }
        return true;
    }

    function changeCode(){
         PopUpCodeDlgTwoControlSelectAll(document.all('formCodeItemList:showcode'),document.all('formCodeItemList:showvalue'),document.all('formCodeItemList:setid').value);
         if (document.all('formCodeItemList:showcode').value==""){
             document.all('formCodeItemList:showcode').value="-1";
         }
         document.all("formCodeItemList").submit();
         return true;
    }
</script>
<x:saveState value="#{sys_codeSetListBB}"/>
<x:saveState value="#{sys_codeItemListBB}"/>
    <h:form id="formCodeItemList">
       <h:inputHidden id="pageInit" value="#{sys_codeItemListBB.pageInit}"/>
       <h:inputHidden id="setid" value="#{sys_codeItemListBB.setId}"/>
       <c:verbatim>
       <table width="97%" height="96%" cellpadding="0" align="center"cellspacing="0" border="0" >
			<tr  >
				<td class="td_title" colspan=2 height=2>
       </c:verbatim>
            <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1180","代码集")%> :
            </f:verbatim>
                    <h:outputText value="#{sys_codeItemListBB.setNameEx}" />
       <c:verbatim> 
                </td>
            </tr>

           <tr><td height=10 colspan=2></td></tr>

           <tr>
           <td height=2>
     </c:verbatim>
                <h:panelGroup>
                    <f:verbatim>
                   		<%=LanguageSupport.getResource("XTGL-1181","当前代码")%> :
                    </f:verbatim>
	                <h:inputHidden id="showcode" value="#{sys_codeItemListBB.curCode}"/>
                    <h:inputText readonly="true" id="showvalue" value="#{sys_codeItemListBB.curCodeDes}" />
					<h:selectBooleanCheckbox value="#{sys_codeItemListBB.orderByName}" onclick="submit()" valueChangeListener="#{sys_codeItemListBB.outputByName}"/>
                     <f:verbatim>
                   		<%=LanguageSupport.getResource("XTGL-1007","按名称排序")%> :
                    </f:verbatim>
                    <h:inputText value="" id="searchName" styleClass="input" onkeypress ="enterKeyDown('formCodeItemList:query')"/>
					<h:commandButton value="检 索"  id="query" onclick="return forSearch(document.all('formCodeItemList:searchName').value)"  action="" styleClass="button01"/>
                </h:panelGroup>
<c:verbatim>
             </td>
             <td height=2>
</c:verbatim>
                <h:panelGroup>
                    <h:commandButton value="显示代码树"   onclick="return changeCode();" styleClass="button01" type="button"/>
                    <h:commandButton value="新 建" action="add" styleClass="button01"  >
                        <x:updateActionListener property="#{sys_codeItemEditBB.setId}" value="#{sys_codeItemListBB.setId}"/>
                        <x:updateActionListener property="#{sys_codeItemEditBB.setName}" value="#{sys_codeItemListBB.setName}"/>
                        <x:updateActionListener property="#{sys_codeItemEditBB.editStatus}" value="false"/>
                        <x:updateActionListener property="#{sys_codeItemEditBB.itemSuper}" value="#{sys_codeItemListBB.curCode}"/>
                        </h:commandButton>
                    <h:commandButton value="删 除" action="#{sys_codeItemListBB.deleteCodeItems}"  onclick="return checkBatchDelete('selectItem')" styleClass="button01" />
                    <h:commandButton value="启 用" action="#{sys_codeItemListBB.makeStatusOpen}" onclick="return doCheckSelect();"  styleClass="button01" />
                    <h:commandButton value="禁 用" action="#{sys_codeItemListBB.makeStatusBan}" onclick="return doCheckSelect();"  styleClass="button01" />
                    <h:commandButton value="返 回" action="setlist" styleClass="button01"/>
                </h:panelGroup>
<c:verbatim>
            </td>
            </tr>

            <tr><td colspan=2 height=12></td></tr>

            <tr><td colspan=2>
            <strong>下级代码</strong><br>
            <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
                <h:dataTable value="#{sys_codeItemListBB.cItems}" var="list" width="98%"    id="dateList"
                    headerClass="tr_fixrow td_top" columnClasses="td_middle,td_middle" styleClass="table03"  border="0">
                    <h:column >
                        <f:facet name="header">
                            <f:verbatim escape="false">
                                <input type="checkbox" name="all" onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                            </f:verbatim>
                        </f:facet>
                        <f:verbatim escape="false">
                            <input type="checkbox" name="selectItem" value="</f:verbatim>
                            <h:outputText value="#{list.itemId}"/>
                            <f:verbatim escape="false">"/>
                        </f:verbatim>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="代码项（代码值）" />
                        </f:facet>
                        <h:outputText escape="false" value="#{list.itemNameEx}" />
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="缩写" />
                        </f:facet>
                        <h:outputText escape="false" value="#{list.itemAbbr}" />
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="拼音/英文" />
                        </f:facet>
                        <h:outputText escape="false" value="#{list.itemSpell}" />
                    </h:column>



                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="用户代码" />
                        </f:facet>
                        <h:outputText escape="false" value="#{list.userItemId}" />
                    </h:column>
                    <h:column>
                                <f:facet name="header">
                                            <h:outputText value="层次码" />
                                        </f:facet>
                                        <h:outputText escape="false" value="#{list.treeId}" />
                                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText  value="启用/禁用" />
                        </f:facet>

                        <h:outputText id="itemstatus"   escape="false" value="#{list.itemStatus}" />
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText  value="区间低值" />
                        </f:facet>
                        <h:outputText id="lowValue"   escape="false" value="#{list.lowValue}" />
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText  value="区间高值" />
                        </f:facet>
                        <h:outputText id="highValue"   escape="false" value="#{list.highValue}" />
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="操作" />
                        </f:facet>
                          <h:panelGrid align="center" cellspacing="2" columns="2">
                        <h:commandButton id="modify" styleClass="button01" action="edit" value="维护代码项" >
                            <x:updateActionListener property="#{sys_codeItemEditBB.itemId}" value="#{list.itemId}"/>
                            <x:updateActionListener property="#{sys_codeItemEditBB.setName}" value="#{sys_codeItemListBB.setName}"/>
                            <x:updateActionListener property="#{sys_codeItemEditBB.editStatus}" value="true"/>
                        </h:commandButton>
                     </h:panelGrid>
                    </h:column>

                </h:dataTable>
<c:verbatim>
            </div>
            </td></tr>
        </table>
</c:verbatim>
    </h:form>

<script type="text/javascript">
   setDataTableOver("formCodeItemList:dateList");
</script>
