<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{sys_BulletinListBackingBean}"/>
	<h:form id="form1">
       <h:panelGrid styleClass="td_title" width="98%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2" align="center">
           <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                 <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-0900","系统管理 -> ")%>  
                 </f:verbatim>
                <h:outputText value=" #{sys_BulletinListBackingBean.pageTitle}"/>
            </h:panelGroup>

           <h:panelGrid columns="1"  align="right">
               <h:panelGroup>
                   <h:commandButton value="新增" onclick="return doEditBulletin();" styleClass="button01" />
                   <h:commandButton value="删除" action="#{sys_BulletinListBackingBean.delete}" styleClass="button01" />
               </h:panelGroup>
           </h:panelGrid>

       </h:panelGrid>

        <f:verbatim>
			<br>
		</f:verbatim>

		<h:dataTable value="#{sys_BulletinListBackingBean.bulletinList}" var="bulist"
                     columnClasses="td_middle_center,td_middle,td_middle_left,td_middle,td_middle,td_middle_center"
                     width="98%"  headerClass="td_top"    id="dateList"
                     styleClass="table03"  align="center">
			<h:column>
				<f:facet name="header">
				</f:facet>
				<f:verbatim escape="false">
					<input type="checkbox" name="chkblltnId" value="
				</f:verbatim>
					<h:outputText value="#{bulist.blltnId}"/>
				<f:verbatim>">
				</f:verbatim>
			</h:column>

			<h:column>
				<f:facet name="header">
				   <f:verbatim>
                 <%=LanguageSupport.getResource("YXGL-1026","操作 ")%>  
                 </f:verbatim>
				</f:facet>
                <h:commandButton styleClass="button01" value="修改" onclick="return doEditBulletin('#{bulist.blltnId}')"></h:commandButton>
			</h:column>

			<h:column>
				<f:facet name="header">
			    <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-1089","公告标题1")%>  
                 </f:verbatim>
				</f:facet>
				<h:outputText style="width:180px" value="#{bulist.blltnTopic}" />
			</h:column>

			<h:column>
				<f:facet name="header">
				  <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-1090","生效时间1")%>  
                 </f:verbatim>
				</f:facet>				
					<h:outputText style="width:80px" value="#{bulist.startDate}" />
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
                <h:outputText style="width:110px" value="#{bulist.newEndDate}" />
            </h:column>

            <h:column>
				<f:facet name="header">
			    <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-1092","失效时间")%>  
                 </f:verbatim>
				</f:facet>
				<h:outputText style="width:80px" value="#{bulist.endDate}" />
			</h:column>

			<h:column>
				<f:facet name="header">
			    <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-1093","公告范围")%>  
                 </f:verbatim>
				</f:facet>
				<h:outputText value="#{bulist.organScope}" />
			</h:column>

        </h:dataTable>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>