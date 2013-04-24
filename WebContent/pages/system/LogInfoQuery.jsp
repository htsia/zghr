<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<x:saveState value="#{sys_SysLogOperBackingBean}" />
<h:form id="form1">
    <f:verbatim>
    <table width=98% height=98% align="center">
         <tr>
                <td class=td_title height=8>
</f:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                     <f:verbatim>
                        <%=LanguageSupport.getResource("XTGL-1239", " 操作日志查询")%>
                     </f:verbatim>
<f:verbatim>
                </td>
            </tr>
    
         <tr><td height=8>
</f:verbatim>
            <h:panelGrid border="0" columns="4"  align="center"	width="95%" >
                <h:outputText value="编号或姓名"/>
                <h:inputText value="#{sys_SysLogOperBackingBean.operName}" />
                <f:verbatim>
                        <%=LanguageSupport.getResource("XTGL-1241", " 操作日期")%>
                 </f:verbatim>
                <h:panelGroup>
                    <h:inputText styleClass="input" id="startDate" readonly="true" value="#{sys_SysLogOperBackingBean.dateFrom}"
                              alt="开始日期|1|d|50||"/>
                    <h:commandButton styleClass="button_select" type="button"  onclick="PopUpCalendarDialog('form1:startDate')" />
                     <f:verbatim>
                        <%=LanguageSupport.getResource("XTGL-1242", "至")%>
                 </f:verbatim>
                     <h:inputText styleClass="input" id="endDate" readonly="true" value="#{sys_SysLogOperBackingBean.dateTo}"
                              alt="结束日期|1|d|50||"/>
                    <h:commandButton styleClass="button_select" type="button"  onclick="PopUpCalendarDialog('form1:endDate')" />
                </h:panelGroup>

                 <f:verbatim>
                        <%=LanguageSupport.getResource("XTGL-1136", "指标集名称")%>
                 </f:verbatim>
                <h:inputText value="#{sys_SysLogOperBackingBean.modifiedName}" />

                 <f:verbatim>
                        <%=LanguageSupport.getResource("JGGL-1002", "机构名称")%>
                 </f:verbatim>
                <h:panelGroup >
                    <h:inputText id="orgIds"	value="#{sys_SysLogOperBackingBean.modifiedOrgIds}" style="width:100%;display:none" disabled="flase" >	</h:inputText>
                    <h:commandButton value="选择机构" type="button" styleClass="button01"	onclick="fPopUpOrgDlg2('form1:orgIds','form1:orgNames',1,'')" />
                    <h:inputText id="orgNames" value="#{sys_SysLogOperBackingBean.modifiedOrgName}" />
                </h:panelGroup>

            </h:panelGrid>
<f:verbatim>
         </td></tr>

         <tr>
             <td height=8 align="right">
</f:verbatim>
                    <f:verbatim>
                        <%=LanguageSupport.getResource("COMM-1043", "记录数")%>:
                    </f:verbatim>
                    <h:outputText value="#{sys_SysLogOperBackingBean.pagevo.totalRecord}"></h:outputText>
                    <h:outputText value="  "></h:outputText>
                     <f:verbatim>
                        <%=LanguageSupport.getResource("COMM-1044", "页数")%>:
                    </f:verbatim>
                    <h:outputText value="#{sys_SysLogOperBackingBean.pagevo.totalPage}"></h:outputText>
                    <h:outputText value="  "></h:outputText>
                    <f:verbatim>
                        <%=LanguageSupport.getResource("COMM-1045", "每页有")%>:
                    </f:verbatim>
                    <h:outputText value="#{sys_SysLogOperBackingBean.pagevo.pageSize}"></h:outputText>
                    <h:outputText value="  "></h:outputText>
                    <f:verbatim>
                        <%=LanguageSupport.getResource("COMM-1046", "当前为第")%>:
                    </f:verbatim>
                    <h:outputText value="#{sys_SysLogOperBackingBean.pagevo.currentPage}"></h:outputText>
                    <f:verbatim>
                        <%=LanguageSupport.getResource("COMM-1047", "页")%>:
                    </f:verbatim>
                    <h:commandButton value="首页" action="#{sys_SysLogOperBackingBean.first}" styleClass="button01"></h:commandButton>
                    <h:commandButton value="上页" action="#{sys_SysLogOperBackingBean.pre}" styleClass="button01"></h:commandButton>
                    <h:commandButton value="下页" action="#{sys_SysLogOperBackingBean.next}" styleClass="button01"></h:commandButton>
                    <h:commandButton value="尾页" action="#{sys_SysLogOperBackingBean.last}" styleClass="button01"></h:commandButton>
                    <h:commandButton id="qry" value="查 询" onclick="return forsubmit(document.forms(0))" action="#{sys_SysLogOperBackingBean.querySysLog}" styleClass="button01" />
<f:verbatim>
             </td>
         </tr>

         <tr><td>
            <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
            <h:dataTable border="0" cellpadding="0" cellspacing="0" width="100%"   id="dateList"
                         headerClass="td_top tr_fixrow" columnClasses="td_middle" styleClass="table03" var="loglist" align="left" value="#{sys_SysLogOperBackingBean.syslogList}">
                <h:column>
                    <f:facet name="header">
	                    <f:verbatim>
	                        <%=LanguageSupport.getResource("YXGL-1243", "时间")%>:
	                    </f:verbatim>
                    </f:facet>
                    <h:outputText value="#{loglist.dateTime}" />
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <f:verbatim>
	                        <%=LanguageSupport.getResource("YXGL-1240", "操作员姓名")%>:
	                    </f:verbatim>
                    </f:facet>
                    <h:outputText value="#{loglist.operatorName}" />
                </h:column>

                <h:column>
                    <f:facet name="header">
                          <f:verbatim>
	                        <%=LanguageSupport.getResource("YXGL-1245", "操作类型")%>:
	                    </f:verbatim>
                    </f:facet>
                    <h:outputText value="#{loglist.operType}" />
                </h:column>

                 <h:column>
                    <f:facet name="header">
                         <f:verbatim>
	                        <%=LanguageSupport.getResource("XTGL-1244", "操作对象")%>:
	                    </f:verbatim>
                    </f:facet>
                    <h:outputText value="#{loglist.operPersonName}" />
                </h:column>

                <h:column>
                    <f:facet name="header">
                          <f:verbatim>
	                        <%=LanguageSupport.getResource("XTGL-1136", "指标集名称")%>:
	                    </f:verbatim>
                    </f:facet>
                    <h:outputText value="#{loglist.operInfosetName}" />
                </h:column>

            </h:dataTable>
<f:verbatim>
            </div>
         </td></tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
