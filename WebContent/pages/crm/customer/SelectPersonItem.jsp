<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
  
 </script>
<x:saveState value="#{customerBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="#{customerBB.selectPersonInit}"></h:inputHidden>
<h:inputHidden value="#{customerBB.cuId}"></h:inputHidden>
<f:verbatim>
 
     <table width="102%">
		    <tr>
		      <td class="td_title" width="102%"></f:verbatim>
		       <h:graphicImage value="/images/tips.gif"  rendered="#{compPersonBB.flag == 1}"/>
			   <h:outputText value="共享设置- > 选择共享人员" rendered="#{compPersonBB.flag == 1}"></h:outputText></td>
		      <f:verbatim>
		      </tr>
	    </table>
 
	<table width="95%" border="0" align="center" class="table02">
		<tr>
			<td align="center" colspan="4" class="td_form01">
			 </f:verbatim>
			    <x:dataTable value="#{customerBB.list}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_center">
					<h:column>
						<c:facet name="header">
							<h:outputText value="人员姓名" />
						</c:facet>
						<h:outputText value="#{list.name}" />
					</h:column>
					 <h:column>
						<c:facet name="header">
							<h:outputText value="共享规则" />
						</c:facet>
						
						<h:commandButton action="#{customerBB.readWrite}"  styleClass="button02"  value="读 写">
							<x:updateActionListener value="#{list.personId}"
								property="#{customerBB.persionId}"></x:updateActionListener>
						</h:commandButton>
						
						<h:commandButton action="#{customerBB.readOnly}" styleClass="button02"  value="只 读">
							<x:updateActionListener value="#{list.personId}"
								property="#{customerBB.persionId}"></x:updateActionListener>
						</h:commandButton>
					</h:column>
				</x:dataTable>
             <f:verbatim>
            </td>
		</tr> 
	</table>
</f:verbatim>
</h:form>

<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
