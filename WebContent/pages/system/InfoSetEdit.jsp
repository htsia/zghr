<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
    <%
        response.setHeader("progma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    %>

<x:saveState value="#{sys_infoSetEditBB}"/>
<h:form id="formInfoSetEdit">
    <h:inputHidden id="pageInit" value="#{sys_infoSetEditBB.pageInit}"></h:inputHidden>
    <h:inputHidden value="#{sys_infoSetEditBB.set_bType}"></h:inputHidden>
    <h:inputHidden value="#{sys_infoSetEditBB.setCreator}"></h:inputHidden>
    <h:inputHidden value="#{sys_infoSetEditBB.set_Issue}"></h:inputHidden>
    <h:inputHidden value="#{sys_infoSetEditBB.setOrder}"></h:inputHidden>
    <h:inputHidden value="#{sys_infoSetEditBB.set_sType}"></h:inputHidden>
    <h:inputHidden value="#{sys_infoSetEditBB.setProperty}"></h:inputHidden>
    <h:inputHidden value="#{sys_infoSetEditBB.setPk}"></h:inputHidden>
    <h:inputHidden value="#{sys_infoSetEditBB.setFk}"></h:inputHidden>
    <h:inputHidden value="#{sys_infoSetEditBB.setId}"></h:inputHidden>
    <h:inputHidden value="#{sys_infoSetEditBB.delFunction}"></h:inputHidden>
    <h:inputHidden value="#{sys_infoSetEditBB.addFunction}"></h:inputHidden>
    <h:inputHidden value="#{sys_infoSetEditBB.updateFunction}"></h:inputHidden>
    <h:inputHidden value="#{sys_infoSetEditBB.editStatus_rsType}"></h:inputHidden>
    <h:inputHidden id="editStatus" value="#{sys_infoSetEditBB.editStatus}"></h:inputHidden>

    <h:panelGrid columns="1" width="97%" cellpadding="0" align="center"
                    cellspacing="0" border="0" >
        <h:panelGrid columns="1" width="97%" cellpadding="0"
                        align="center" border="0" >
            <f:verbatim>
				   <%=LanguageSupport.getResource("XTGL-1135", "�鿴ָ�꼯")%>
		   </f:verbatim>
        </h:panelGrid>

        <f:verbatim>
            <br>
        </f:verbatim>

        <h:panelGrid columns="4"
                        width="97%"
                        cellpadding="0" border="1" align="center"
                        styleClass="table03"  columnClasses="td_form01,td_form02,td_form01,td_form02">
            <f:verbatim>
				   <%=LanguageSupport.getResource("XTGL-1136", "ָ�꼯����")%>
		   </f:verbatim>
            <h:inputText value="#{sys_infoSetEditBB.setName}" alt="ָ�꼯����|0|s|50" styleClass="input"/>

            <f:verbatim>
				   <%=LanguageSupport.getResource("XTGL-1015", "����")%>
		   </f:verbatim>
            <h:inputText value="#{sys_infoSetEditBB.setDesc}" alt="����|1|s|500" styleClass="input"/>

             <f:verbatim>
				   <%=LanguageSupport.getResource("XTGL-1004", "��¼����")%>
		   </f:verbatim>
            <h:selectOneRadio id="rsType" value="#{sys_infoSetEditBB.set_rsType}">
                <f:selectItem itemValue="1" itemLabel="����¼"/>
                <f:selectItem itemValue="2" itemLabel="���¼"/>
            </h:selectOneRadio>

           <f:verbatim>
				   <%=LanguageSupport.getResource("XTGL-1006", "����/����")%>
		   </f:verbatim>
            <h:selectOneRadio value="#{sys_infoSetEditBB.setStatus}">
                <f:selectItem itemValue="1" itemLabel="����"/>
                <f:selectItem itemValue="0" itemLabel="����"/>
            </h:selectOneRadio>

             <f:verbatim>
				   <%=LanguageSupport.getResource("XTGL-1005", "��ʾ˳��")%>
		   </f:verbatim>
            <h:inputText value="#{sys_infoSetEditBB.setSequence}" alt="��ʾ˳��|0|i|3|1|999" styleClass="input"/>

             <f:verbatim>
				   <%=LanguageSupport.getResource("XTGL-1137", "�Ƿ�������������")%>
		   </f:verbatim>
            <h:selectOneRadio id="isself" value="#{sys_infoSetEditBB.itemSelf}">
                <f:selectItem itemValue="0" itemLabel="������"/>
                <f:selectItem itemValue="1" itemLabel="����"/>
            </h:selectOneRadio>

             <f:verbatim>
				   <%=LanguageSupport.getResource("XTGL-1138", "�Ƿ�������")%>
		   </f:verbatim>
            <h:selectOneRadio id="canImport" value="#{sys_infoSetEditBB.canImport}">
                <f:selectItem itemValue="0" itemLabel="������"/>
                <f:selectItem itemValue="1" itemLabel="����"/>
            </h:selectOneRadio>
        </h:panelGrid>
        <f:verbatim>
            <br>
            <br>
        </f:verbatim>
        <h:panelGrid columns="1" width="100%" cellpadding="0"    align="right" border="0">
            <h:panelGroup>
                <h:commandButton value="�� ��" action="#{sys_infoSetEditBB.saveInfoSet}" styleClass="button01">
                    <x:updateActionListener property="#{sys_infoSetListBB.set_sType}" value="#{sys_infoSetEditBB.set_sType}"/>
                </h:commandButton>
                <h:commandButton value="�� ��" action="setlist" styleClass="button01">
                    <x:updateActionListener property="#{sys_infoSetListBB.set_sType}" value="#{sys_infoSetEditBB.set_sType}"/>
                </h:commandButton>
            </h:panelGroup>
        </h:panelGrid>
    </h:panelGrid>

    <script language=javascript>
        var form1 = document.forms[0];
        var status = form1["formInfoSetEdit:editStatus"];
        // debugger;
        if (status.value == "true") {
            var rstype = form1["formInfoSetEdit:rsType"];
            rstype[0].disabled = true;
            rstype[1].disabled = true;
            //        for(var i=0;i<rstype.length;i++)
            //            if(rstype[i].type=="redio")
            //            {
            //               rstype[i].disabled=true;
            //            }
        }
    </script>
</h:form>
