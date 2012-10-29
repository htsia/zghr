<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

<% response.setHeader("Pragma", "No-cache");
   response.setHeader("Cache-Control", "no-cache");
   response.setDateHeader("Expires", 0);
%>

<x:saveState value="#{sys_RemindPreSetBackingBean)" />
<h:form id="form1">
	<h:inputHidden value="#{sys_RemindSetBackingBean.remindPageInit}" />
	<h:inputHidden value="#{sys_RemindSetBackingBean.remBO.remId}" />
	<h:inputHidden value="#{sys_RemindSetBackingBean.remBO.remFieldDatatype}" />
	<h:inputHidden value="#{sys_RemindSetBackingBean.remBO.validFlag}" />
	<h:inputHidden value="#{sys_RemindSetBackingBean.remBO.remRsltField}" />
	<h:inputHidden value="#{sys_RemindSetBackingBean.remRsltField}" />

    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-0900"," 系统管理 ")%> -> 
                 <%=LanguageSupport.getResource("XTGL-1341"," 提醒项目")%> 
        </f:verbatim>
        </h:panelGroup>
    </h:panelGrid>

	<h:panelGrid width="80%" columns="1" align="center" >
		<h:panelGrid columns="1" cellpadding="5" align="left"   rowClasses="left,left,left,left" 	width="100%">
			 <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-1342"," 设置提醒事项名称")%> 
       		 </f:verbatim>
			<h:inputText id="required1"
					value="#{sys_RemindSetBackingBean.remBO.remName}" style="width:60%">
			</h:inputText>
		</h:panelGrid>

		<h:panelGrid columns="1" cellpadding="5" align="left"   rowClasses="left,left,left,left" 	width="100%">
			 <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-1343"," 设置提示信息")%> 
       		 </f:verbatim>
            <h:inputText id="required2"
                value="#{sys_RemindSetBackingBean.remBO.remMsg}" style="width:60%" />
		</h:panelGrid>

		<h:panelGrid columns="1" cellpadding="5" align="left"   width="100%"		rowClasses="left,left,left,left">
			<h:panelGrid columns="1" width="100%">
				<h:panelGroup>
				  <f:verbatim>
		                 <%=LanguageSupport.getResource("XTGL-1344"," 设置提醒条件")%> 
		          </f:verbatim>
                    <h:commandButton value="设置条件"
                        onclick="return doAdvanceQuery('A','ORG','011','Y','','','N')"
                        action="#{sys_RemindSetBackingBean.setupRemindSQL}"
                        styleClass="button01" />
                </h:panelGroup>
                <h:inputTextarea id="required3"
					value="#{sys_RemindSetBackingBean.remBO.remCondDesc}"
					style="width:60%;border: 1px solid #6395c6;" rows="3">
				</h:inputTextarea>
				
                 <f:verbatim>
		                 <%=LanguageSupport.getResource("XTGL-1345"," 提醒信息内容")%> 
		          </f:verbatim>
				<h:outputText
					value="#{sys_RemindSetBackingBean.remBO.remRsltField}"
					style="width:95%;height:24;border: 1px solid #6395c6;" />

                 <f:verbatim>
		                 <%=LanguageSupport.getResource("XTGL-1346"," 提醒定义")%> 
		          </f:verbatim>
                <h:inputTextarea id="inputtextarea"
					value="#{sys_RemindSetBackingBean.remBO.remCondition}"
					style="width:95%;border: 1px solid #6395c6;" readonly="true" rows="4">
				</h:inputTextarea>
			</h:panelGrid>
		</h:panelGrid>

		<h:panelGrid columns="3" cellpadding="0" align="right" >
			<h:panelGroup>
            <h:selectBooleanCheckbox value="#{sys_RemindSetBackingBean.immeExecute}"></h:selectBooleanCheckbox>
                   <f:verbatim>
		                 <%=LanguageSupport.getResource("XTGL-1347"," 保存后进行提醒查询")%> 
		          </f:verbatim>
            </h:panelGroup>
            <h:commandButton value="保 存"
				action="#{sys_RemindSetBackingBean.createRemItem}"
				styleClass="button01" />
			<h:commandButton value="返 回"  onclick="window.close();"	styleClass="button01" />
		</h:panelGrid>

	</h:panelGrid>
</h:form>
