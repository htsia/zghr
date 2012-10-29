<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>

<x:saveState value="#{competitionBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden  value="#{competitionBB.selectInit}"/>
<f:verbatim>
 <table width="102%">
		    <tr>
		      <td class="td_title" width="102%"></f:verbatim>
		       <h:graphicImage value="/images/tips.gif"  rendered="#{compPersonBB.flag == 1}"/>
			   <h:outputText value="竞争对手 - > 选择竞争对手 " rendered="#{compPersonBB.flag == 1}"></h:outputText></td>
		      <f:verbatim>
		      </tr>
	    </table>

<table width="95%"   border="1" align="center" class="table02" >
     <tr>
    <td colspan="4">
    </f:verbatim>
         <h:commandButton value="保存"  action="#{competitionBB.saveCompetitonPerson}"
						styleClass="button01"></h:commandButton>
        <x:dataTable value="#{competitionBB.list}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_center">
                         
                         
                    <h:column>
						<c:facet name="header">
							<c:verbatim escape="false">
								<c:verbatim escape="false">
								<input type="checkbox" name="chkAll"
									onclick="selectAll(document.form1.chkAll, document.form1.selected_ids)";/>
							</c:verbatim>
							</c:verbatim>
						</c:facet>
						<c:verbatim escape="false">
							<input type="checkbox" name="selected_ids"
								value="</c:verbatim>
                  <h:outputText value="#{list.compeId}"/>
                  <c:verbatim>">
						</c:verbatim>
					</h:column>     


					<h:column>
						<c:facet name="header">
							<h:outputText value="公司名称" />
						</c:facet>
						<h:outputText value="#{list.compeName}" />
					</h:column>


					<h:column>
						<c:facet name="header">
							<h:outputText value="国家" />
						</c:facet>
						<h:outputText value="#{list.nation}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="城市" />
						</c:facet>
						<h:outputText value="#{list.city}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="邮编" />
						</c:facet>
						<h:outputText value="#{list.zip}" />
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


