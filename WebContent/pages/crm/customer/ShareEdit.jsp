<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>

<x:saveState value="#{customerBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{customerBB.shareEditInit}"></h:inputHidden>
	<f:verbatim>
	
	      <table width="102%">
		    <tr>
		      <td class="td_title" width="102%"></f:verbatim>
		       <h:graphicImage value="/images/tips.gif"  rendered="#{compPersonBB.flag == 1}"/>
			   <h:outputText value="�������- > Ȩ�޹��� " rendered="#{compPersonBB.flag == 1}"></h:outputText></td>
		      <f:verbatim>
		      </tr>
	    </table>
		<table id="tree" width="95%" border="0" align="center">
			<tr>
				<td align="right">
				</f:verbatim> 
				 <h:commandButton value="����"
					styleClass="button01" action="#{customerBB.saveCustomerShareBO}" />
				<h:commandButton value="����" styleClass="button01"  onclick="window.close();" /> 
					<f:verbatim>
				</td>
			</tr>

			<tr>
				<td></f:verbatim> <h:selectOneRadio value="#{customerBB.shareBO.power}">
					<f:selectItem itemLabel="ֻ��" itemValue="1" />
					<f:selectItem itemLabel="��д" itemValue="2" />
				</h:selectOneRadio> <f:verbatim></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>












