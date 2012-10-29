<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doAddNews(){
        window.showModalDialog("/system/VideoNewsEdit.jsf", null, "dialogWidth:500px; dialogHeight:350px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyNews(id){
        window.showModalDialog("/system/VideoNewsEdit.jsf?itemID="+id, null, "dialogWidth:500px; dialogHeight:350px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{sys_videoNewsBB}"/>
<h:form id="form1">
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="1" align="right">
                 <h:commandButton value="增加" styleClass="button01" onclick="doAddNews();"></h:commandButton>
          </h:panelGrid>

          <x:dataTable value="#{sys_videoNewsBB.videoList}" id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

				<h:column>
					<f:facet name="header">
					   <f:verbatim>
		                 <%=LanguageSupport.getResource("XTGL-1105","标题")%>  
		               </f:verbatim>
					</f:facet>
                    <h:outputText value="#{briefList.title}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                         <f:verbatim>
		                 <%=LanguageSupport.getResource("XTGL-1120","发布时间")%>  
		               </f:verbatim>
                    </f:facet>
                    <h:outputText value="#{briefList.createDate}" ></h:outputText>
                </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="排序码" />
                  </f:facet>
                  <h:outputText value="#{briefList.seq}" ></h:outputText>
              </h:column>

                  <h:column>
                      <f:facet name="header">
                        <f:verbatim>
		                 <%=LanguageSupport.getResource("XTGL-1121","是否当前")%>  
		               </f:verbatim>
                      </f:facet>
                      <h:selectOneRadio value="#{briefList.isCurrent}" disabled="true">
                          <c:selectItem itemValue="0" itemLabel="否"></c:selectItem>
                          <c:selectItem itemValue="1" itemLabel="是"></c:selectItem>
                      </h:selectOneRadio>
                  </h:column>

                <h:column>
                    <f:facet name="header">
                         <f:verbatim>
		                 <%=LanguageSupport.getResource("YXGL-1026","操作")%>  
		               </f:verbatim>
                    </f:facet>
                    <h:commandButton value="置为当前" styleClass="button01"    action="#{sys_videoNewsBB.setCurrent}" >
                        <x:updateActionListener property="#{sys_videoNewsBB.itemID}" value="#{briefList.itemID}"/>
                    </h:commandButton>
                    <h:commandButton value="删除" styleClass="button01"    action="#{sys_videoNewsBB.delete}" onclick="return confirm('确认删除？')">
                        <x:updateActionListener property="#{sys_videoNewsBB.itemID}" value="#{briefList.itemID}"/>
                    </h:commandButton>
                    <h:commandButton value="修改" styleClass="button01" onclick="doModifyNews('#{briefList.itemID}');"> </h:commandButton>

				</h:column>
			</x:dataTable>
		</h:panelGrid>
	</h:form>
    <script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>

