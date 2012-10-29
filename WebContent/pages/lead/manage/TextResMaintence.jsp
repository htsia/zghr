<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function forAdd() {
        window.showModalDialog("/lead/LeadSQLEdit.jsf?resId="+document.all("form1:resId").value, null, "dialogWidth:430px; dialogHeight:320px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
    function forModify(ID) {
        window.showModalDialog("/lead/LeadSQLEdit.jsf?resId="+document.all("form1:resId").value+"&sqlID="+ID, null, "dialogWidth:430px; dialogHeight:320px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
</script>

<x:saveState value="#{leadfmtmaintenanceBackingBean}"/>
    <h:form id="form1">
	<h:inputHidden id="init" value="#{leadfmtmaintenanceBackingBean.runquery}"></h:inputHidden>
    <h:inputHidden id="resId" value="#{leadfmtmaintenanceBackingBean.resId}"></h:inputHidden>

	<h:panelGrid width="98%"  align="center" border="0"  cellpadding="2" cellspacing="0" columns="2" styleClass="td_title">
	   <h:panelGroup>
	       <h:outputText value ="����:#{leadfmtmaintenanceBackingBean.showcode}"/>
           <h:outputText value ="  "/>
           <h:outputText value ="����:#{leadfmtmaintenanceBackingBean.showname}"/>
       </h:panelGroup>

      <h:panelGrid columns="2" align="right">
		<h:commandButton value="�� ��" styleClass="button01" action="#{leadfmtmaintenanceBackingBean.editText}" />
		<h:commandButton value="ȡ ��" type="reset" styleClass="button01" onclick="window.close();" />
 	  </h:panelGrid>
	</h:panelGrid>

    <h:panelGrid columns="1" align="center">
        <h:outputText value="��Ŀ���ݱ��ʽ" style="width:480px"/>
        <h:inputTextarea rows = "9" cols = "90" value="#{leadfmtmaintenanceBackingBean.textBO.expressions}" />
        <h:outputText escape="false" value="<br>&nbsp;&nbsp;��Ŀ���ݱ��ʽ˵��:<UL><li>֧�ּ򵥵�HTML��ʽ;</li><li>���ʽ���漰����������#P01#һֱ��#P20#</li><li>$B$����Ҫͳ�Ƶĵ�λ #DATE#����Ҫͳ�Ƶ�ʱ��</li></ul>" style="border:0px" />

        <h:panelGroup>
            <h:outputText escape="false" value="<strong>�����б�:<strong>"></h:outputText>
            <h:panelGrid align="right" columns="2">
                <h:commandButton value="����" styleClass="button01"  onclick="return forAdd();" />
            </h:panelGrid>
        </h:panelGroup>
       
        <h:dataTable value="#{leadfmtmaintenanceBackingBean.paralist}" var="paralist" width="98%"   id="paralist"
               headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center" styleClass="table03" align="center">
               <h:column>
                   <f:facet name="header">
                       <h:outputText value="��������" style="width:100px;"/>
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
                    <h:commandButton value="�޸�" styleClass="button01"  onclick="return forModify('#{paralist.sqlId}')" />
                    <h:commandButton value="ɾ��" styleClass="button01" action="#{leadfmtmaintenanceBackingBean.deleteSql}">
                        <x:updateActionListener property="#{leadfmtmaintenanceBackingBean.sqlId}" value="#{paralist.sqlId}"/>
                    </h:commandButton>
            </h:column>
       </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:paralist");
</script>
