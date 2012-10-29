<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>

    <script type="text/javascript">
        function clearws() {
		    document.getElementById("checkSubmitFlg").value="0";
        }

        function clearStatew() {
            setInterval("clearws()",2000);
        }
    </script>

<x:saveState value="#{chk_verifyResBB}"/>

<h:form id="form1" >
        <h:inputHidden value = "#{chk_verifyResBB.init}"></h:inputHidden>
        <h:panelGrid width="95%" columns="2" >
		<h:panelGroup></h:panelGroup>
		    <h:panelGrid  columns="1"  align="right">
                <h:commandButton value="返回" action="#{chk_verifyResBB.goBack}" onclick ="document.forms(0).target='_self';"  styleClass="button01"/>
            </h:panelGrid>   
        </h:panelGrid>

		<h:panelGrid width="100%" columns="1" >
   		        <h:outputText value="本日检查情况："/>
				<h:panelGroup>
					<h:dataTable headerClass="td_top" value="#{chk_verifyResBB.dacResList}" id="dateList"
                                 var="cklist" width="98%" border="1" columnClasses="td_middle_center,td_middle,td_middle_left,td_middle_center" align="center" styleClass="table03">
				    	<h:column>
							<f:facet name="header">
								<h:outputText value="日期" />
							</f:facet>
							<h:outputText value="#{cklist.checkDate}" style="width:80"/>
						</h:column>

						<h:column>
						<f:facet name="header">
						<h:outputText value="开始时间" />
						</f:facet>
						<h:outputText value="#{cklist.beginTime}" style="width:80"/>
						</h:column>

                        <h:column>
                        <f:facet name="header">
                        <h:outputText value="检查项描述" />
                        </f:facet>
                        <h:outputText value="#{cklist.checkDesc}" />
                        </h:column>

						<h:column>
							<f:facet name="header">
								<h:outputText value="检查结果" style="width:80"/>
							</f:facet>

                            <x:commandLink  onclick="window.open('/pages/common/ShowExcel.jsp?filename=#{cklist.fileName}')" value="查看"  style="width:100%;text-align:center">
			                </x:commandLink>
						</h:column>

					</h:dataTable>
				</h:panelGroup>
		</h:panelGrid>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>