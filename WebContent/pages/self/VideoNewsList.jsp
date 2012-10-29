<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<script type="text/javascript">
</script>

<x:saveState value="#{sys_videoNewsBB}"/>
<h:form id="form1">
      <h:panelGrid width="98%" columns="1" align="center">
          <h:panelGrid columns="1" align="right">
                 <h:commandButton value="返回" type="button" styleClass="button01" onclick="window.close();"></h:commandButton>
          </h:panelGrid>

          <x:dataTable value="#{sys_videoNewsBB.morevideoList}" id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

				<h:column>
					<f:facet name="header">
						<h:outputText value="标题" />
					</f:facet>
                    <h:outputText value="#{briefList.title}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="发布时间" />
                    </f:facet>
                    <h:outputText value="#{briefList.createDate}" ></h:outputText>
                </h:column>


                <h:column>
                    <f:facet name="header">
                        <h:outputText value="操作" />
                    </f:facet>
                    <h:commandButton value="播放" type="button" styleClass="button01" onclick="doShowCource('1','#{briefList.title}','/file/videoNews/#{briefList.fileName}');"> </h:commandButton>
				</h:column>
			</x:dataTable>
		</h:panelGrid>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>

