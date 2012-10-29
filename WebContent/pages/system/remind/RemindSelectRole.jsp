<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
        function forsave(form1) {
            document.getElementById("form1:flag").value = "2";
            return pageCodeExchange(form1);
        }
        function sel() {
            if (checkMutilSelect(document.form1.roleId)) {
                return true;
            } else {
                alert("请选择角色！")
                return false;
            }
        }
 </script>
    
<x:saveState value="#{sys_RemindSelectBackingBean}" />
<h:form id="form1">
   <c:verbatim>
       <table height=98% width=98% align="center">

       <tr><td height=8px>
   </c:verbatim>
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
           <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1357", " 角色选择")%>
			</f:verbatim>
            </h:panelGroup>
        </h:panelGrid>
   <c:verbatim>
       </td></tr>

       <tr><td height=8px>
    </c:verbatim>
           <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1358", "所创建的角色")%>
			</f:verbatim>
           <h:commandButton value="选  择" onclick="javascript:return sel()" action="#{sys_RemindSelectBackingBean.selRole}" styleClass="button01" />
    <c:verbatim>
       </td></tr>

       <tr><td>
    </c:verbatim>
    <div style='width:100%;height:100%;overflow:auto' id=datatable>
       <x:dataTable border="1" value="#{sys_RemindSelectBackingBean.roleList}"  styleClass="table03"  headerClass="td_top"  id="dateList"
					var="roleList" width="100%" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					align="center">
					<h:column>
						<f:facet name="header">
							<f:verbatim escape="false">
								<input type="checkbox" name="chkAllRole"
									onclick="selectAll(document.form1.chkAllRole,document.form1.roleId)" />
							</f:verbatim>
						</f:facet>
						<f:verbatim escape="false">
								<input type="checkbox" name="roleId"
									value="</f:verbatim><h:outputText value="#{roleList.roleId}"/><f:verbatim>">
						</f:verbatim>
						<f:verbatim escape="false">
								<input type="hidden" name="roleName"
									value="</f:verbatim><h:outputText value="#{roleList.roleName}"/><f:verbatim>">
						</f:verbatim>
					</h:column>

					<h:column>
						<f:facet name="header">
						     <f:verbatim>
							        <%=LanguageSupport.getResource("XTGL-1064", "角色名称")%>
							 </f:verbatim>
						</f:facet>
						<h:outputText escape="false" value="#{roleList.roleName}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<f:verbatim>
							        <%=LanguageSupport.getResource("XTGL-1354", "创建时间")%>
							 </f:verbatim>
						</f:facet>
						<h:outputText escape="false" value="#{roleList.createTime}" />
					</h:column>
				</x:dataTable>
    </div>
   <c:verbatim>
        </td></tr>
       </table>
    </c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>