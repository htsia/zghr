<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<script type="text/javascript">
function showProcessBar() {
    x = document.body.clientWidth / 2 - 150;
    y = document.body.clientHeight / 2;
    document.all('processbar').style.top = y;
    document.all('processbar').style.left = x;
    document.all('processbar').style.display = "";
 }
</script>
<x:saveState value="#{periodsetattcaclinfoBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{periodsetattcaclinfoBB.pageInit}"></h:inputHidden>
    <h:inputHidden  value="#{periodsetattcaclinfoBB.perIdsValue}"></h:inputHidden>
	<h:panelGrid width="98%" columns="1" align="center">
		<h:panelGrid columns="5" align="left">
			<h:panelGrid columns="2" align="center">
				<h:selectBooleanCheckbox value="#{periodsetattcaclinfoBB.isMon}" />
				<h:outputText value="�����»���" />
			</h:panelGrid>
			<h:panelGrid columns="2" align="center">
			<h:selectBooleanCheckbox value="#{periodsetattcaclinfoBB.isExist}" />
			<h:outputText value="�Ƿ��������ˢ��" />
			</h:panelGrid>
						<h:panelGroup>
						<h:outputText value=" " />
						<h:outputText value=" " />
						<h:outputText value="(" />
						<h:outputText value="������Ա:#{periodsetattcaclinfoBB.personName}" />
						<h:outputText value=", " />
						<h:outputText value="����ʱ��:#{periodsetattcaclinfoBB.cacltime}" />
						<h:outputText value=", " />
						<h:outputText value="������Ա:#{periodsetattcaclinfoBB.perIdsValueName}" />
						<h:outputText value=")" />
			</h:panelGroup>
			<h:commandButton value="���ܼ���" styleClass="button01" onclick="showProcessBar();"
				action="#{periodsetattcaclinfoBB.cacl}"></h:commandButton>
			<h:commandButton styleClass="button01" value="ȡ������"
				onclick="window.close();" />
		</h:panelGrid>

		<x:dataTable value="#{periodsetattcaclinfoBB.itemList}"
			headerClass="td_top" rowIndexVar="index" var="briefList"
			styleClass="table03" border="1" width="98%" id="dateList" 
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center">
			<h:column>
				<c:facet name="header">
					<c:verbatim escape="false">
						<input type="checkbox" name="chkAll"
							onclick="selectAll(document.form1.chkAll, document.form1.selected_ids);" />
					</c:verbatim>
				</c:facet>
				<c:verbatim escape="false">
					<input type="checkbox" name="selected_ids"
						value="</c:verbatim>
                  <h:outputText value="#{briefList.attDate}"/>
                  <c:verbatim>">
				</c:verbatim>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��������(������)" />
				</f:facet>
				<h:outputText value="#{briefList.attDate}"></h:outputText>
			</h:column>
		</x:dataTable>
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>
	
	      <marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
               scrollamount="5" scrolldelay="10"
               bgcolor="#ECF2FF">
          <table cellspacing="1" cellpadding="0">
              <tr height=8>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
              </tr>
          </table>
      </marquee>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
