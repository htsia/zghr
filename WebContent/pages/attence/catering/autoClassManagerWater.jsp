<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.*" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    String[] orgIdStr = (String[]) session.getAttribute("orgIdStr");
    String[] argmentStr = (String[]) session.getAttribute("argmentStr");
    Hashtable hashTableValue = (Hashtable) session.getAttribute("hashTableValue");
    
%>
<script type="text/javascript">
	function forFinanceDate(id, id1) {
		window
				.showModalDialog(
						"/attence/catering/autoClassManagerWaterAdd.jsf?subId=" + id
								+ "&orgId=" + id1,
						null,
						"dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
		document.all('form1:refresh').click();
		return true;
	}
</script>
<x:saveState value="#{autoclassmanagerruleBB}"/>
<h:form id="form1">
	<h:commandButton id="refresh" value="ˢ��" style="display:none;" action="#{autoclassmanagerruleBB.doQuery1}"></h:commandButton>
    <h:inputHidden value="#{autoclassmanagerruleBB.initEdit1}"/>
    <h:inputHidden value="#{autoclassmanagerruleBB.duraYearMonth}"/>
    <h:panelGrid columns="3" width="95%" align="center">
            
    </h:panelGrid>
    <c:verbatim >
        <br>
        <table width="95%" align="center" cellpadding="2" cellspacing="0" class="table03" id="setlist">
            <tr>
                <td colspan="3" nowrap class="td_middle_center">�����б�</td>
            </tr>

            <tr>
                <td nowrap class="td_top">��������</td>
                <td nowrap class="td_top">���ܿ����� </td>
                <td nowrap class="td_top">���ܳ�Ʒ��</td>
            </tr>
            <%
              if(orgIdStr!=null && orgIdStr.length>0){
            	for(int i=0;i<orgIdStr.length;i++){
            		String orgIdValue=orgIdStr[i];
            		String orgIdName=(String)hashTableValue.get(orgIdValue);

                          out.println("<tr>");
                          out.println("<td class=td_top>" + orgIdName + "</td>");
                          for(int j=0;j<argmentStr.length;j++){
                        	  String fldname = orgIdStr[i] + "|" + argmentStr[j];
                        	  out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='' class='input' size=10 maxlenght=20 style=\"behavior:url('../../js/mytextbox.htc');\" alt='����ֵ|1|f'></td>");	  
                          }
                          out.println("</tr>");
                          

            	}
              }
            %>
        </table>
    </c:verbatim>
    
    <h:panelGrid columns="3" width="95%" align="center">
            <h:commandButton styleClass="button01" value="����" action="#{autoclassmanagerruleBB.saveInput}"/>
    </h:panelGrid>
    
    <h:dataTable value="#{autoclassmanagerruleBB.argumentList}" var="list"
		align="center" id="dateList" headerClass="td_top"
		columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
		styleClass="table03" width="90%">
		<h:column>
			<c:facet name="header">
				<h:outputText value="��������" />
			</c:facet>
			<h:outputText value="#{list.orguidName}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="ʱ��" />
			</c:facet>
			<h:outputText value="#{list.attenceDate}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="���ܿ�����" />
			</c:facet>
			<h:outputText value="#{list.monthVolume}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="���ܳ�Ʒ��" />
			</c:facet>
			<h:outputText value="#{list.monthProduce}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="����" />
			</c:facet>
			<h:commandButton value="�޸�" styleClass="button01" type="button" onclick="return forFinanceDate('#{list.subID}','#{list.orguid}');" />
		</h:column>
	</h:dataTable>
</h:form>
<script type="text/javascript">
   setTableInputOver("setlist");
</script>
