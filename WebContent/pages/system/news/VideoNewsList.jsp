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
                 <h:commandButton value="����" styleClass="button01" onclick="doAddNews();"></h:commandButton>
          </h:panelGrid>

          <x:dataTable value="#{sys_videoNewsBB.videoList}" id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

				<h:column>
					<f:facet name="header">
					   <f:verbatim>
		                 <%=LanguageSupport.getResource("XTGL-1105","����")%>  
		               </f:verbatim>
					</f:facet>
                    <h:outputText value="#{briefList.title}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                         <f:verbatim>
		                 <%=LanguageSupport.getResource("XTGL-1120","����ʱ��")%>  
		               </f:verbatim>
                    </f:facet>
                    <h:outputText value="#{briefList.createDate}" ></h:outputText>
                </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="������" />
                  </f:facet>
                  <h:outputText value="#{briefList.seq}" ></h:outputText>
              </h:column>

                  <h:column>
                      <f:facet name="header">
                        <f:verbatim>
		                 <%=LanguageSupport.getResource("XTGL-1121","�Ƿ�ǰ")%>  
		               </f:verbatim>
                      </f:facet>
                      <h:selectOneRadio value="#{briefList.isCurrent}" disabled="true">
                          <c:selectItem itemValue="0" itemLabel="��"></c:selectItem>
                          <c:selectItem itemValue="1" itemLabel="��"></c:selectItem>
                      </h:selectOneRadio>
                  </h:column>

                <h:column>
                    <f:facet name="header">
                         <f:verbatim>
		                 <%=LanguageSupport.getResource("YXGL-1026","����")%>  
		               </f:verbatim>
                    </f:facet>
                    <h:commandButton value="��Ϊ��ǰ" styleClass="button01"    action="#{sys_videoNewsBB.setCurrent}" >
                        <x:updateActionListener property="#{sys_videoNewsBB.itemID}" value="#{briefList.itemID}"/>
                    </h:commandButton>
                    <h:commandButton value="ɾ��" styleClass="button01"    action="#{sys_videoNewsBB.delete}" onclick="return confirm('ȷ��ɾ����')">
                        <x:updateActionListener property="#{sys_videoNewsBB.itemID}" value="#{briefList.itemID}"/>
                    </h:commandButton>
                    <h:commandButton value="�޸�" styleClass="button01" onclick="doModifyNews('#{briefList.itemID}');"> </h:commandButton>

				</h:column>
			</x:dataTable>
		</h:panelGrid>
	</h:form>
    <script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>

