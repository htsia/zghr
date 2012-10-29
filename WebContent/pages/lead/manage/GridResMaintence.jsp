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
            <h:outputText value ="表格代码:" /><h:outputText value ="#{leadfmtmaintenanceBackingBean.showcode}"/>
            <h:outputText value ="   " />
            <h:outputText value ="表格说明:" /><h:outputText value ="#{leadfmtmaintenanceBackingBean.showname}"/>
        </h:panelGroup>

        <h:panelGrid columns="4">
             <h:commandButton value="新 增" styleClass="button01" onclick="return forAddRes();" />
             <h:commandButton value="返回" type="reset" styleClass="button01" onclick="window.close();" />
        </h:panelGrid>
	</h:panelGrid>
    <c:verbatim><br></c:verbatim>
	<h:dataTable width="98%" value="#{leadfmtmaintenanceBackingBean.gridlist}"   var="gridlist"   id="gridlist"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center "
                 styleClass="table03" align="center">

            <h:column>
                <c:facet name="header"><h:outputText value="操作" style="width:40px;border:0px"/></c:facet>
                <h:commandButton value="修改" styleClass="button01"  onclick="return forModifyRes('#{gridlist.gridID}')" />
                <h:commandButton value="删 除" styleClass="button01" action="#{leadfmtmaintenanceBackingBean.deleGrid}">
                    <x:updateActionListener property="#{leadfmtmaintenanceBackingBean.deleteID}" value="#{gridlist.gridID}"/>
                </h:commandButton>
            </h:column>

			<h:column>
				<f:facet name="header" >
					<h:outputText value="顺序" style="width:40px;border:0px"/>
				</f:facet>
				<h:outputText   value="#{gridlist.orderNo}" style="width:40px;border:0px" />
			</h:column>

			<h:column>
				<f:facet name="header">
					<h:outputText value="信息1" style="width:40px" />
				</f:facet>
				<h:outputText  value="#{gridlist.showInfo1}" style="width:80;border:0px"/>
			</h:column>

			<h:column>
				<f:facet name="header">
					<h:outputText value="信息2" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo2}" style="width:40px;border:0px"/>
			</h:column>
			
			<h:column>
				<f:facet name="header">
					<h:outputText value="信息3" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo3}" style="width:40px;border:0px"/>
			</h:column>
			
			<h:column>
				<f:facet name="header">
					<h:outputText value="信息4" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo4}" style="width:40px;border:0px"/>
			</h:column>
			
			<h:column>
				<f:facet name="header">
					<h:outputText value="信息5" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo5}" style="width:40px;border:0px"/>
			</h:column>
			
			<h:column>
				<f:facet name="header">
					<h:outputText value="信息6" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo6}" style="width:40px;border:0px"/>
			</h:column>

			<h:column>
				<f:facet name="header">
					<h:outputText value="信息7" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo7}" style="width:40px;border:0px"/>
			</h:column>
			
			<h:column>
				<f:facet name="header">
					<h:outputText value="信息8" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo8}" style="width:40px;border:0px"/>
			</h:column>
			
			<h:column>
				<f:facet name="header">
					<h:outputText value="信息9" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo9}" style="width:40px;border:0px"/>
			</h:column>
			
			<h:column>
				<f:facet name="header">
					<h:outputText value="信息10" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo10}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息11" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo11}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息12" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo12}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息13" style="width:40px"/>
				</f:facet>
				<h:inputText value="#{gridlist.showInfo13}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息14" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo14}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息15" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo15}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息16" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo16}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息17" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo17}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息18" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo18}" style="width:40px;border:0px"/>
			</h:column>
            <h:column>
				<f:facet name="header">
					<h:outputText value="信息19" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo19}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息20" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo20}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="信息21" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo21}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="信息22" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo22}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="信息23" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo23}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="信息24" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo24}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="信息25" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo25}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="信息26" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo26}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="信息27" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo27}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息28" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo28}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="信息29" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo29}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息30" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo30}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息31" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo31}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="信息32" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo32}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息33" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo33}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息34" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo34}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息35" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo35}" style="width:40px;border:0px"/>
			</h:column>


            <h:column>
				<f:facet name="header">
					<h:outputText value="信息36" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo36}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息37" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo37}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息38" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo38}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息39" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo39}" style="width:40px;border:0px"/>
			</h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="信息40" style="width:40px"/>
				</f:facet>
				<h:outputText value="#{gridlist.showInfo40}" style="width:40px;border:0px"/>
			</h:column>

        </h:dataTable>
	  <h:outputText escape="false"  value="<br>说明<UL><li>信息(1-40):表格的1列~40列数据</li> <li>顺序:表示该行出现的先后</li>" style="border:0px" /> 

      <h:panelGrid columns="1" align="left" width="98%">
        <h:panelGroup>
            <h:outputText value="参数列表:"></h:outputText>
            <h:panelGrid align="right" columns="2">
                <h:commandButton value="增加" styleClass="button01"  onclick="return forAddSQL();" />
            </h:panelGrid>
        </h:panelGroup>

        <h:dataTable value="#{leadfmtmaintenanceBackingBean.paralist}" var="paralist" width="100%" styleClass="table03" 
               headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center" id="paralist"
                align="center">
               <h:column>
                   <f:facet name="header">
                       <h:outputText value="参数名称" />
                   </f:facet>
                   <h:outputText  value="#{paralist.paraName}" />
               </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="参数定义" style="width:480px"/>
                </f:facet>
                <h:outputText  value="#{paralist.sqlstr}" />
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                    <h:commandButton value="修改" styleClass="button01"  onclick="return forModifySQL('#{paralist.sqlId}')" />
                    <h:commandButton value="删除" styleClass="button01" action="#{leadfmtmaintenanceBackingBean.deleteSql}">
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


