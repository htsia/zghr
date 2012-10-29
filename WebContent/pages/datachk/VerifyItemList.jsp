<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>

<x:saveState value="#{chk_verifyItemBB}"/>
   <h:form id="form1" >
        <h:inputHidden value = "#{chk_verifyItemBB.init}"></h:inputHidden>
       <h:inputHidden value = "#{chk_verifyItemBB.orgId}"></h:inputHidden>
        <h:panelGrid width="100%" columns="2"  >
            <h:outputText value="��ǰ����:#{chk_verifyItemBB.orgName}"/>
            <h:panelGrid align="right" columns="1">
                <h:panelGroup>
                    <h:commandButton value="��ʼ���" action="#{chk_verifyItemBB.checkData}"  styleClass="button01"/>
                    <h:commandButton value="�����" action="#{chk_verifyItemBB.gotoResult}"  styleClass="button01"/>
                </h:panelGroup>
             </h:panelGrid>
        </h:panelGrid>

		<h:panelGrid width="98%" columns="1" align="center">
		<h:outputText value="�ȴ���ߵ���ѡ���鷶Χ��Ȼ�����·�ѡ�������ݣ�"/>
				<h:panelGroup>
					<h:dataTable value="#{chk_verifyItemBB.dacItemList}" var="cklist" width="98%"  id="dateList"
                                 styleClass="table03" headerClass="td_top"  border="1" columnClasses="center,left" align="center" >

					    <h:column >
                            <f:facet name="header" >
                               <f:verbatim escape="false"><input style="width:30px;" type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selItems)"/>                                        </f:verbatim>
                            </f:facet>
                            <f:verbatim escape="false"><input style="width:30px;" type="checkbox" name="selItems" value="</f:verbatim><h:outputText value="#{cklist.checkId}"></h:outputText><f:verbatim>"></f:verbatim>
                        </h:column>

						<h:column>
							<f:facet name="header">
								<h:outputText value="�������" />
							</f:facet>
							<h:outputText value="#{cklist.checkDesc}" />
						</h:column>
					</h:dataTable>
				</h:panelGroup>
		</h:panelGrid>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>