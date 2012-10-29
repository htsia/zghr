<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<f:verbatim>
    <script type="text/javascript">
        function forAdd() {
            window.showModalDialog("/system/RemindEdit.jsf", null, "dialogWidth:530px; dialogHeight:500px;center:center;resizable:no;status:no;");
            return true;
        }
        function forModify(id) {
            window.showModalDialog("/system/RemindEdit.jsf?sys_remindid="+id, null, "dialogWidth:530px; dialogHeight:500px;center:center;resizable:no;status:no;");
            return true;
        }
        function forModifyScope(id) {
            window.showModalDialog("/system/RemindScopeSet.jsf?sys_remindid="+id, null, "dialogWidth:530px; dialogHeight:450px;center:center;resizable:no;status:no;");
            return true;
        }

    </script>
</f:verbatim>

<h:form id="form1">
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
         <f:verbatim>
				<%=LanguageSupport.getResource("XTGL-0900",
									"系统管理 ")%>->  
		                 <%=LanguageSupport.getResource("XTGL-1123",
									"提醒设置")%>
			</f:verbatim>
        
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid width="98%" columns="1" align="center">
		<h:panelGrid columns="1" cellpadding="5" align="right">
            <h:panelGroup>
                <h:commandButton value="新 增"
                    onclick="forAdd();"
                    styleClass="button01" />
                <h:commandButton value="删 除"
                    action="#{sys_RemindPreSetBackingBean.delete}"
                    onclick="if(confirm('确实要删除吗？')){if(checkMutilSelect(form1.remindIds)){return true;}else{return false;}}else{return false;}"
                    styleClass="button01" />
                <h:commandButton value="启 用"
                    action="#{sys_RemindPreSetBackingBean.enabledValidFlag}"
                    styleClass="button01" />
                <h:commandButton value="禁 用"
                    action="#{sys_RemindPreSetBackingBean.disabledValidFlag}"
                    styleClass="button01" />
           </h:panelGroup>
        </h:panelGrid>

        <f:verbatim>
			<br>
		</f:verbatim>
		<h:dataTable value="#{sys_RemindPreSetBackingBean.remindSetList}"  id="setlist"
			var="remindlist" width="99%" border="1"   headerClass="td_top"  styleClass="table03"
			columnClasses="center,left,left,left,left" align="center">
			<h:column>
				<f:facet name="header">
					<f:verbatim escape="false">
						<input type="checkbox" name="chkAll"
							onclick="selectAll(document.form1.chkAll,document.form1.remindIds)" />
					</f:verbatim>
				</f:facet>
				<f:verbatim escape="false">
					<input type="checkbox" name="remindIds"
						value="</f:verbatim><h:outputText value="#{remindlist.remindId}"/><f:verbatim>">
				</f:verbatim>
			</h:column>

			<h:column>
				<f:facet name="header">
  					<f:verbatim>
		                 <%=LanguageSupport.getResource("XTGL-1124", "提醒事项名称")%>
			       </f:verbatim>				 
				</f:facet>
				<h:outputText escape="false" value="#{remindlist.remindName}" />
			</h:column>

			<h:column>
				<f:facet name="header">
				    <f:verbatim>
		                 <%=LanguageSupport.getResource("XTGL-1125", "条件说明")%>
			       </f:verbatim>				
				</f:facet>
				<h:outputText escape="false" value="#{remindlist.remindCondDesc}" />
			</h:column>

			<h:column>
				<f:facet name="header">
				      <f:verbatim>
		                 <%=LanguageSupport.getResource("XTGL-1126", "提示信息")%>
			       </f:verbatim>	
				</f:facet>
				<h:outputText escape="false" value="#{remindlist.remindMsg}" />
			</h:column>

			<h:column>
				<f:facet name="header">
				     <f:verbatim>
		                 <%=LanguageSupport.getResource("XTGL-1051", "状态")%>
			       </f:verbatim>	
				</f:facet>
				<h:outputText escape="false" value="#{remindlist.validFalg}" />
			</h:column>

			<h:column>
				<f:facet name="header">
				       <f:verbatim>
		                 <%=LanguageSupport.getResource("YXGL-1026", "操作")%>
			       </f:verbatim>	
				</f:facet>
				<h:commandButton styleClass="button01"
					onclick="return forModify('#{remindlist.remindId}')" value="修改定义">
				</h:commandButton>
                <h:commandButton styleClass="button01" type="button"
                    onclick="return forModifyScope('#{remindlist.remindId}')" value="修改应用范围">
                </h:commandButton>
			</h:column>
		</h:dataTable>
	</h:panelGrid>
</h:form>
    <script type="text/javascript">
       setDataTableOver("form1:setlist");
    </script>


