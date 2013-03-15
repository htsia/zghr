<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript" language="javascript">
        function doCheckSelect() {
            if (!checkMutilSelect(formCodeSetList.selectItem)) {
                alert("��ѡ����Ŀ!");
                return false;
            }
            return true;
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
                <f:verbatim>н����� -> ��������</f:verbatim>
<f:verbatim>
            </td>
        </tr>
        <tr><td height=8>
</f:verbatim>
            <h:panelGrid columns="2" width="97%" cellpadding="0" 	align="center" border="0" >
                <h:panelGroup>
                    <h:selectBooleanCheckbox id="orderByName" value="#{sys_codeSetListBB.orderByName}" onclick="submit()" valueChangeListener="#{sys_codeSetListBB.outputByName}" ></h:selectBooleanCheckbox>
                    <f:verbatim>
                    <%=LanguageSupport.getResource("XTGL-1007","����������")%>  
                   </f:verbatim>
                </h:panelGroup>
                <h:panelGrid align="right" columns="6">
                    <h:inputText value="" styleClass="input" id="searchName" />
                    <h:commandButton value="�� ��" action="" styleClass="button01"  onclick="return forSearch(document.all('formCodeSetList:searchName').value)"  />
                    <h:commandButton value="�� ��" action="add" styleClass="button01"  rendered="#{sys_codeSetListBB.operRight}" >
                    	<x:updateActionListener property="#{sys_codeSetEditBB.editStatus}" value="false"/>
                    	<x:updateActionListener property="#{sys_codeSetEditBB.moudleID}" value="wage"/>
                    </h:commandButton>
                    <h:commandButton value="ɾ ��" action="#{sys_codeSetListBB.deleteCodeSets}" styleClass="button01"  rendered="#{sys_codeSetListBB.operRight}"  onclick="return checkBatchDelete('selectItem')" />
                    <h:commandButton value="�� ��" action="#{sys_codeSetListBB.setStatusOpen}" onclick="return doCheckSelect();" styleClass="button01"  rendered="#{sys_codeSetListBB.operRight}"/>
                    <h:commandButton value="�� ��" action="#{sys_codeSetListBB.setStatusBan}" onclick="return doCheckSelect();" styleClass="button01"  rendered="#{sys_codeSetListBB.operRight}"/>
                </h:panelGrid>
            </h:panelGrid>
<f:verbatim>
           </td></tr>

           <tr><td>
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
                    				<%=LanguageSupport.getResource("XTGL-1009","���뼯����")%>  
                            </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.setNameEx}" />
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                             <f:verbatim>
                    				<%=LanguageSupport.getResource("XTGL-1051","����/����")%>  
                            </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.setStatus}" />
                    </h:column>

                    <h:column>
                    <f:facet name="header">
                            <f:verbatim>
                    				<%=LanguageSupport.getResource("YXGL-1051","����")%>  
                            </f:verbatim>
                   </f:facet>
                    <h:panelGrid align="center" cellspacing="2" columns="2">
                        <h:commandButton id="modify" styleClass="button01" action="edit"   value="ά�����뼯">
                            <x:updateActionListener property="#{sys_codeSetEditBB.setId}" value="#{list.setId}"/>
                            <x:updateActionListener property="#{sys_codeSetEditBB.editStatus}" value="true"/>
                            <x:updateActionListener property="#{sys_codeSetEditBB.moudleID}" value="wage"/>
                        </h:commandButton>
                        <h:commandButton id="view" styleClass="button01" action="itemlist" value="ά��������">
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