<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{sys_NewsListBackingBean}"/>
<h:form id="form1">
       <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" bgcolor="#FFFFFF" columns="2">
            <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
                <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-0900","系统管理 ")%>->
                 </f:verbatim>
              <h:outputText value="#{sys_NewsListBackingBean.pageTitle}"/>
            </h:panelGroup>

            <h:panelGrid columns="1"  cellpadding="2" align="right" 	border="0" >
                  <h:panelGroup>
                  <h:commandButton value="新增" action="sys_newsedit" styleClass="button01" />
                  <h:commandButton value="删除" action="#{sys_NewsListBackingBean.delete}" styleClass="button01" />
                 </h:panelGroup>
            </h:panelGrid>
        </h:panelGrid>
        <f:verbatim>
    	<table height=98% width=100% align="center">
        <tr><td><div style='width:100%;height:98%;overflow:auto' id=datatable>
        </f:verbatim>
		<h:dataTable value="#{sys_NewsListBackingBean.newsList}" var="list" width="95%"
                     headerClass="td_top" id="dateList"
                     styleClass="table03" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_left" align="center">
			<h:column>
				<f:facet name="header">
				    <f:verbatim>
                    	 <%=LanguageSupport.getResource("YXGL-1026","操作 ")%> 
                    </f:verbatim>
				</f:facet>
				<h:commandLink  action="#{sys_NewsListBackingBean.editNews}">
					<h:outputText value="修改"/>
					<x:updateActionListener property="#{sys_NewsListBackingBean.idforEdit}" value="#{list.newId}"></x:updateActionListener>
				</h:commandLink>
			</h:column>
            
            <h:column>
				<f:facet name="header">
				</f:facet>
				<f:verbatim escape="false">
					<input type="checkbox" name="chkblltnId" value="
				</f:verbatim>
					<h:outputText value="#{list.newId}"/>
				<f:verbatim>">
				</f:verbatim>
			</h:column>

			<h:column>
				<f:facet name="header">
				     <f:verbatim>
                    	 <%=LanguageSupport.getResource("XTGL-1094","新闻标题 ")%> 
                    </f:verbatim>
				</f:facet>
				<h:outputText style="width:180px" value="#{list.newTopic}" />
			</h:column>

            <h:column>
                <f:facet name="header">
                    <h:panelGroup>
                        <h:graphicImage value="/images/common/new.gif"></h:graphicImage>
                         <f:verbatim>
                    	 <%=LanguageSupport.getResource("XTGL-1091","标示失效时间")%> 
                        </f:verbatim>
                    </h:panelGroup>
                </f:facet>
                <h:outputText style="width:110px" value="#{list.newEndDate}" />
            </h:column>

			<h:column>
				<f:facet name="header">
					   <f:verbatim>
                    	 <%=LanguageSupport.getResource("XTGL-1095","新闻生效时间")%> 
                        </f:verbatim>
				</f:facet>				
			    <h:outputText style="width:80px" value="#{list.startDate}" />
			</h:column>

			<h:column>
				<f:facet name="header">
				    <f:verbatim>
                    	 <%=LanguageSupport.getResource("XTGL-1096","新闻失效时间")%> 
                    </f:verbatim>
				</f:facet>
				<h:outputText style="width:80px" value="#{list.endDate}" />
			</h:column>

			<h:column>
				<f:facet name="header">
				   <f:verbatim>
                    	 <%=LanguageSupport.getResource("XTGL-1097","新闻范围")%> 
                    </f:verbatim>
				</f:facet>
				<h:outputText value="#{list.organScope}" />
			</h:column>
        </h:dataTable>
        <f:verbatim>
			</div></td></tr></table>
		</f:verbatim>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>

