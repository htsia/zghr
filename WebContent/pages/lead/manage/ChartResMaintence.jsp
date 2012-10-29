<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>

<script type="text/javascript">
    function forAddRes() {
        window.showModalDialog("/lead/ChartResEdit.jsf?resId="+document.all("form1:resId").value+"&GraphID="+document.all("form1:graphID").value, null, "dialogWidth:360px; dialogHeight:280px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
    function forModifyRes(ID) {
        window.showModalDialog("/lead/ChartResEdit.jsf?resId="+document.all("form1:resId").value+"&itemID="+ID, null, "dialogWidth:360px; dialogHeight:280px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
    function forAddSQL() {
        window.showModalDialog("/lead/LeadSQLEdit.jsf?resId="+document.all("form1:resId").value, null, "dialogWidth:430px; dialogHeight:320px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
    function forModifySQL(ID) {
        window.showModalDialog("/lead/LeadSQLEdit.jsf?resId="+document.all("form1:resId").value+"&sqlID="+ID, null, "dialogWidth:430px; dialogHeight:320px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
</script>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{leadfmtmaintenanceBackingBean}"/>
	<h:form id="form1">
    <h:inputHidden id="init" value="#{leadfmtmaintenanceBackingBean.runquery}"></h:inputHidden>
    <h:inputHidden id="resId" value="#{leadfmtmaintenanceBackingBean.resId}"></h:inputHidden>
    <h:inputHidden id="graphID" value="#{leadfmtmaintenanceBackingBean.gbo.graphID}"></h:inputHidden>
    <h:panelGrid width="100%"  align="center" border="0" cellpadding="2" cellspacing="0" columns="2" styleClass="td_title">
        <h:panelGroup>
            <c:verbatim><strong></c:verbatim>
            <h:outputText value ="ͼ�����:" /><h:outputText value ="#{leadfmtmaintenanceBackingBean.showcode}"/>
            <h:outputText value ="   " />
            <h:outputText value ="ͼ��˵��:" /><h:outputText value ="#{leadfmtmaintenanceBackingBean.showname}"/>
            <c:verbatim></strong></c:verbatim>
        </h:panelGroup>

	   <h:panelGrid columns="2" align="center">
		<h:commandButton value="�� ��" styleClass="button01" action="#{leadfmtmaintenanceBackingBean.editChart}" />
		<h:commandButton value="ȡ ��" type="reset" styleClass="button01" onclick="window.close();" />
	  </h:panelGrid>
	</h:panelGrid>

    <c:verbatim><br></c:verbatim>
    <h:panelGrid columns="8" columnClasses="td_top">
        <h:outputText value="ͼ�����" style="width:100px" />
        <h:outputText value="X�����" style="width:100px" />
        <h:outputText value="Y�����" style="width:100px" />
        <h:outputText value="Сͼ��" style="width:55px"/>
        <h:outputText value="Сͼ��" style="width:55px"/>
        <h:outputText value="��ͼ��" style="width:55px" />
        <h:outputText value="��ͼ��" style="width:55px"/>
        <h:outputText value="ͼ����" style="width:60px"/>

        <h:inputText   value="#{leadfmtmaintenanceBackingBean.gbo.graphTitle}"  style="width:100px;" />
        <h:inputText   value="#{leadfmtmaintenanceBackingBean.gbo.labelTitleX}"  style="width:100px;" />
        <h:inputText   value="#{leadfmtmaintenanceBackingBean.gbo.labelTitleY}"  style="width:100px;" />
        <h:inputText   value="#{leadfmtmaintenanceBackingBean.gbo.smallWidth}" style="width:55px"/>
        <h:inputText   value="#{leadfmtmaintenanceBackingBean.gbo.smallHeight}" style="width:55px"/>
        <h:inputText   value="#{leadfmtmaintenanceBackingBean.gbo.largeWidth}" style="width:55px"/>
        <h:inputText   value="#{leadfmtmaintenanceBackingBean.gbo.largeHeight}" style="width:55px"/>
        <h:selectOneMenu value="#{leadfmtmaintenanceBackingBean.gbo.graphType}" style="">
            <f:selectItems value="#{leadfmtmaintenanceBackingBean.graselects}"/>
        </h:selectOneMenu>
    </h:panelGrid>
    
    <c:verbatim><br></c:verbatim>

    <h:panelGrid columns="2" width="98%">
        <h:panelGroup>
            <c:verbatim><strong></c:verbatim>
            <h:outputText value="����˵��:"/>
            <c:verbatim></strong></c:verbatim>
        </h:panelGroup>
        <h:panelGrid align="right" columns="1">
             <h:panelGroup>
                 <h:commandButton value="����" styleClass="button01" onclick="return forAddRes();" action="#{leadfmtmaintenanceBackingBean.refreshChartItemList}"/>
             </h:panelGroup>
        </h:panelGrid>
    </h:panelGrid>

	<h:dataTable  value="#{leadfmtmaintenanceBackingBean.chartitemlist}"   var="chartitemlist" width="98%"  id="chartitemlist"
                  headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center,td_middle,td_middle_center "
             styleClass="table03" align="center">
             <h:column>
				<f:facet name="header">
					<h:outputText value="��" style="width:50px"/>
				</f:facet>
				<h:outputText   value="#{chartitemlist.x}" style="width:50px"/>
			</h:column>
        <h:column>
           <f:facet name="header">
               <h:outputText value="��" style="width:50px"/>
           </f:facet>
           <h:outputText   value="#{chartitemlist.y}" style="width:50px"/>
       </h:column>

        <h:column>
           <f:facet name="header">
               <h:outputText value="�б�ǩ" style="width:50px"/>
           </f:facet>
           <h:outputText   value="#{chartitemlist.labelTitleX}" style="width:50px"/>
       </h:column>

        <h:column>
           <f:facet name="header">
               <h:outputText value="�б�ǩ" style="width:50px"/>
           </f:facet>
           <h:outputText   value="#{chartitemlist.labelTitleY}" style="width:50px"/>
       </h:column>

        <h:column>
           <f:facet name="header">
               <h:outputText value="��Ӧ����" style="width:50px"/>
           </f:facet>
           <h:outputText   value="#{chartitemlist.graphValue}" style="width:50px"/>
        </h:column>

        <h:column>
           <f:facet name="header">
               <h:outputText value="����" style="width:50px"/>
           </f:facet>
           <h:panelGrid columns="2">
                 <h:commandButton value="�޸�" styleClass="button01"  onclick="return forModifyRes('#{chartitemlist.itemID}');" />
                 <h:commandButton value="ɾ��"  styleClass="button01" onclick="return confirm('ȷ��Ҫɾ����?');" action="#{leadfmtmaintenanceBackingBean.deleteGraphItem}">
                       <x:updateActionListener property="#{leadfmtmaintenanceBackingBean.deleteID}" value="#{chartitemlist.itemID}"/>
                 </h:commandButton>
           </h:panelGrid>
        </h:column>
    </h:dataTable>
    <br>
    <h:panelGrid columns="1" align="left" width="98%">
         <h:panelGrid columns="2" width="100%">
             <h:panelGroup>
                <c:verbatim><strong></c:verbatim>
                  <h:outputText value="�����б�:"></h:outputText>
                <c:verbatim></strong></c:verbatim>
             </h:panelGroup>

            <h:panelGrid align="right" columns="1">
                    <h:panelGroup>
                        <h:commandButton value="����" styleClass="button01"  action="#{leadfmtmaintenanceBackingBean.refreshGraphParaList}" onclick="return forAddSQL();" />
                        <h:commandButton value="ɾ��" styleClass="button01"  />
                    </h:panelGroup>
             </h:panelGrid>
         </h:panelGrid>

         <h:dataTable value="#{leadfmtmaintenanceBackingBean.paralist}" var="paralist" width="98%"  id="paralist"
                      headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center,td_middle,td_middle_center "
                      styleClass="table03" align="center">
                   <h:column>
                       <f:facet name="header">
                           <h:outputText value="��������" />
                       </f:facet>
                       <h:outputText  value="#{paralist.paraName}" />
                   </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="��������" style="width:480px"/>
                    </f:facet>
                    <h:outputText  value="#{paralist.sqlstr}" />
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����"/></c:facet>
                        <h:commandButton value="�޸�" styleClass="button01"  onclick="return forModifySQL('#{paralist.sqlId}')" />
                        <h:commandButton value="ɾ��" styleClass="button01" onclick="return confirm('ȷ��Ҫɾ����?');" action="#{leadfmtmaintenanceBackingBean.deleteSql}">
                            <x:updateActionListener property="#{leadfmtmaintenanceBackingBean.sqlId}" value="#{paralist.sqlId}"/>
                        </h:commandButton>

                </h:column>
           </h:dataTable>
     </h:panelGrid>
    </h:form>
<script type="text/javascript">
   setDataTableOver("form1:paralist");
   setDataTableOver("form1:chartitemlist");
</script>

