<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<x:saveState value="#{sys_codeSetListBB}"/>
<h:form id = "formCodeItemEdit">
    <h:inputHidden id="pageInit" value="#{sys_codeItemEditBB.pageInit}"/>
    <h:inputHidden id="editStatus" value="#{sys_codeItemEditBB.editStatus}"/>
    <h:inputHidden id="itemId" value="#{sys_codeItemEditBB.itemId}"/>
    <c:verbatim><br></c:verbatim>

    <h:panelGrid columns="1" width="97%" cellpadding="0" align="center"
                    cellspacing="0" border="0" >
        <h:inputHidden value="#{sys_codeItemEditBB.setId}"/>
        <h:panelGrid columns="4"
                        width="97%"
                        cellpadding="0" border="1" align="center"
                        styleClass="table03" columnClasses="td_form01,td_form02,td_form01,td_form02">

            <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1171","�������뼯")%> :
            </f:verbatim>
            <h:inputText value="#{sys_codeItemEditBB.setName}" readonly="true" alt="�������뼯|1|s|50"  styleClass="input"/>

             <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1172","�ϼ�������")%> :
            </f:verbatim>
            <h:panelGroup>
                <h:inputText id="itemSuper" value="#{sys_codeItemEditBB.itemSuper}" code="" dict="yes" dict_num="#{sys_codeItemEditBB.setId}"/>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('formCodeItemEdit:itemSuper','','1')"/>
            </h:panelGroup>

            <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1173","����������")%> :
            </f:verbatim>
            <h:inputText id="itemName" value="#{sys_codeItemEditBB.itemName}" alt="����������|1|s|50" styleClass="input"/>

             <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1174","�û�����")%> :
            </f:verbatim>
            <h:inputText id="userItemId" value="#{sys_codeItemEditBB.userItemId}"  alt="����|1|s|50" styleClass="input"/>

             <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1175","��д")%> :
            </f:verbatim>
            <h:inputText value="#{sys_codeItemEditBB.itemAbbr}" alt="��д|1|s|50" styleClass="input"/>

             <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1176","ƴ��/Ӣ��")%> :
            </f:verbatim>
            <h:panelGroup>
                <h:inputText value="#{sys_codeItemEditBB.itemSpell}" alt="ƴ��/Ӣ��|1|s|50" styleClass="input"/>
            </h:panelGroup>

            <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1177","ͬ����������")%> :
            </f:verbatim>
            <h:inputText value="#{sys_codeItemEditBB.seqId}" alt="�����|1|s|50" styleClass="input"/>

            <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1006","����/����")%> :
            </f:verbatim>
            <h:selectOneRadio value="#{sys_codeItemEditBB.itemStatus}">
                <f:selectItem itemValue="1" itemLabel="����"/>
                <f:selectItem itemValue="0" itemLabel="����"/>
            </h:selectOneRadio>

            <h:outputText value="��������ֵ"/>
            <h:inputText value="#{sys_codeItemEditBB.lowValue}" alt="��������ֵ|1|s|50" styleClass="input"/>

            <h:outputText value="��������ֵ"/>
            <h:inputText value="#{sys_codeItemEditBB.highValue}" alt="��������ֵ|1|s|50" styleClass="input"/>
            
            <h:outputText value="����ֵ"/>
            <h:inputText value="#{sys_codeItemEditBB.tagValue}"  styleClass="input"/>

        </h:panelGrid>

        <h:panelGrid columns="1" width="20%" cellpadding="0"
                        align="right" border="0">
            <h:panelGroup>
                <h:commandButton value="�� ��" onclick="return forsubmit(document.forms(0))" action="#{sys_codeItemEditBB.saveCodeSet}" styleClass="button01"/>
                <h:commandButton value="�� ��" onclick="return forsubmit(document.forms(0))" action="itemlist" styleClass="button01">
                     <x:updateActionListener property="#{sys_codeItemListBB.setId}" value="#{sys_codeItemEditBB.setId}"/>
                    <x:updateActionListener property="#{sys_codeItemListBB.setName}" value="#{sys_codeItemEditBB.setName}"/>
                    <x:updateActionListener property="#{sys_codeItemListBB.curCode}" value="#{sys_codeItemEditBB.itemSuper}"/>
                </h:commandButton>
            </h:panelGroup>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>