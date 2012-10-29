<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function forAddRes() {
        window.showModalDialog("/lead/GridResEdit.jsf?resId="+document.all("form1:resId").value, null, "dialogWidth:430px; dialogHeight:620px;center:center;resizable:no;status:no;scroll:auto;");
        return true;
    }
    function forModifyRes(ID) {
        window.showModalDialog("/lead/GridResEdit.jsf?resId="+document.all("form1:resId").value+"&gridID="+ID, null, "dialogWidth:430px; dialogHeight:620px;center:center;resizable:no;status:no;scroll:auto;");
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

<x:saveState value="#{leadfmtmaintenanceBackingBean}"/>
<h:form id="form1">
	<h:inputHidden id="init" value="#{leadfmtmaintenanceBackingBean.runquery}"></h:inputHidden>
    <h:inputHidden id="resId" value="#{leadfmtmaintenanceBackingBean.resId}"></h:inputHidden>
    <h:panelGrid width="98%"  border="0"  cellpadding="2" cellspacing="0" columns="2" align="center" styleClass="td_title">
        <h:panelGroup>
            <h:outputText value ="������:" /><h:outputText value ="#{leadfmtmaintenanceBackingBean.showcode}"/>
            <h:outputText value ="   " />
            <h:outputText value ="���˵��:" /><h:outputText value ="#{leadfmtmaintenanceBackingBean.showname}"/>
        </h:panelGroup>

        <h:panelGrid columns="4">
             <h:commandButton value="�� ��" styleClass="button01" onclick="return forAddRes();" />
             <h:commandButton value="����" type="reset" styleClass="button01" onclick="window.close();" />
        </h:panelGrid>
	</h:panelGrid>
    <c:verbatim><br></c:verbatim>
	<h:dataTable width="98%" value="#{leadfmtmaintenanceBackingBean.gridlist}"   var="gridlist"   id="gridlist"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center "
                 styleClass="table03" align="center">

            <h:column>
                <c:facet name="header"><h:outputText value="����" style="width:40px;border:0px"/></c:facet>
                <h:commandButton value="�޸�" styleClass="button01"  onclick="return forModifyRes('#{gridlist.gridID}')" />
                <h:commandButton value="ɾ ��" styleClass="button01" action="#{leadfmtmaintenanceBackingBean.deleGrid}">
                    <x:updateActionListener property="#{leadfmtmaintenanceBackingBean.deleteID}" value="#{gridlist.gridID}"/>
                </h:commandButton>
            </h:column>

			<h:column>
				<f:facet name="header" >
					<h:outputText value="˳��" style="width:40px;border:0px"/>
				</f:facet>
				<h:outputText   value="#{gridlist.orderNo}" style="width:40px;border:0px" />
			</h:column>

			<h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ1" style="width:40px" />
				</f:facet>
				<h:outputText  value="#{gridlist.showInfo1}" style="width:80;border:0px"/>
			</h:column>

			<h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ2" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo2}" style="width:40px;border:0px"/>
			</h:column>
			
			<h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ3" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo3}" style="width:40px;border:0px"/>
			</h:column>
			
			<h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ4" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo4}" style="width:40px;border:0px"/>
			</h:column>
			
			<h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ5" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo5}" style="width:40px;border:0px"/>
			</h:column>
			
			<h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ6" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo6}" style="width:40px;border:0px"/>
			</h:column>

			<h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ7" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo7}" style="width:40px;border:0px"/>
			</h:column>
			
			<h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ8" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo8}" style="width:40px;border:0px"/>
			</h:column>
			
			<h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ9" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo9}" style="width:40px;border:0px"/>
			</h:column>
			
			<h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ10" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo10}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ11" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo11}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ12" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo12}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ13" style="width:40px"/>
				</f:facet>
				<h:inputText value="#{gridlist.showInfo13}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ14" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo14}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ15" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo15}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ16" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo16}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ17" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo17}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ18" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo18}" style="width:40px;border:0px"/>
			</h:column>
            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ19" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo19}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ20" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo20}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ21" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo21}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ22" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo22}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ23" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo23}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ24" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo24}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ25" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo25}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ26" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo26}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ27" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo27}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ28" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo28}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ29" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo29}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ30" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo30}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ31" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo31}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ32" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo32}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ33" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo33}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ34" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo34}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ35" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo35}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ36" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo36}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ37" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo37}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ38" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo38}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ39" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo39}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="��Ϣ40" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo40}" style="width:40px;border:0px"/>
			</h:column>

        </h:dataTable>
	  <h:outputText escape="false"  value="<br>˵��<UL><li>��Ϣ(1-40):����1��~40������</li> <li>˳��:��ʾ���г��ֵ��Ⱥ�</li>" style="border:0px" /> 

      <h:panelGrid columns="1" align="left" width="98%">
        <h:panelGroup>
            <h:outputText value="�����б�:"></h:outputText>
            <h:panelGrid align="right" columns="2">
                <h:commandButton value="����" styleClass="button01"  onclick="return forAddSQL();" />
            </h:panelGrid>
        </h:panelGroup>

        <h:dataTable value="#{leadfmtmaintenanceBackingBean.paralist}" var="paralist" width="100%" styleClass="table03" 
               headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center" id="paralist"
                align="center">
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
                    <h:commandButton value="ɾ��" styleClass="button01" action="#{leadfmtmaintenanceBackingBean.deleteSql}">
                        <x:updateActionListener property="#{leadfmtmaintenanceBackingBean.sqlId}" value="#{paralist.sqlId}"/>
                    </h:commandButton>
            </h:column>
       </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:gridlist");
   setDataTableOver("form1:paralist");
</script>


