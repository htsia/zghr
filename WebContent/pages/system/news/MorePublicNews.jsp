<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<x:saveState value="#{sys_NewsBriefMoreBB}"/>
<h:form id="form1">
    <c:verbatim>
    <table height=98% width=98% align="center">
      <tr><td >
    <div style='width:100%;height:100%;overflow:auto' id=datatable>
 </c:verbatim>
        <x:dataTable value="#{sys_NewsBriefMoreBB.newsList2}" id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

				<h:column>
					<f:facet name="header">
				       <f:verbatim>
                               <%=LanguageSupport.getResource("XTGL-1331","新闻信息 ")%>:
                       </f:verbatim>
					</f:facet>
                    <h:outputText value="#{briefList.newTopic}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <f:verbatim>
                               <%=LanguageSupport.getResource("XTGL-1297","生效时间 ")%>:
                       </f:verbatim>
                    </f:facet>
                    <h:outputText value="#{briefList.startDate}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                       <h:panelGroup>
                            <h:graphicImage value="/images/common/new.gif"></h:graphicImage>
                             <f:verbatim>
                               <%=LanguageSupport.getResource("XTGL-1091","标示失效时间")%>:
                       		</f:verbatim>
                       </h:panelGroup>
                    </f:facet>
                    <h:outputText value="#{briefList.newEndDate}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                    <f:verbatim>
                               <%=LanguageSupport.getResource("XTGL-1092","失效时间")%>:
                    </f:verbatim>
                    </f:facet>
                    <h:outputText value="#{briefList.endDate}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                         <f:verbatim>
                               <%=LanguageSupport.getResource("YXGL-1026","操作")%>:
                         </f:verbatim>
                    </f:facet>

					<h:commandButton value="查看详细信息" type="button" styleClass="button01" onclick="doShowNews('#{briefList.newId}');">
					</h:commandButton>
				</h:column>
			</x:dataTable>
<c:verbatim>
    </div>
      </td></tr>
  </table>
    </c:verbatim>




</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>


