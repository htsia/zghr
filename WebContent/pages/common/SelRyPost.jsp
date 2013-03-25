<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String superId = CommonFuns.filterNull(request.getParameter("superId"));
	String fk = request.getParameter("fk");
    String name = "";
    OrgBO bo = SysCacheTool.findOrgById(superId);
    if (bo != null) {
        name = bo.getName();
    }
	String orgId=null;
	if(fk!=null && !"".equals(fk)){
	    PersonBO p = SysCacheTool.findPersonById(fk);
	    orgId = p.getDeptId();
	}
%>
    <script type="text/javascript">
		function killErrors() {
			return true;
		}
		window.onerror = killErrors;

        function refreshList(orgId) {
            document.all("form1:org").value=orgId;
            document.all("form1:query").click();
        }
        function sel(code,value){
            window.returnValue = code + "," + value;
            window.close();
        }
    </script>

<h:form id="form1" >
<x:saveState value="#{post_selPostBB}"></x:saveState>
<h:inputHidden id="flag" value="#{post_selPostBB.flag}" />
<h:inputHidden id="org" value="#{post_selPostBB.org}"  />
<h:commandButton value="查询" id="query" action="#{post_selPostBB.queryPost}" style="display:none"></h:commandButton>
<c:verbatim>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
        <td class="td_title" >
          <%=LanguageSupport.getResource("GWGL-1066"," 选择岗位")%>
       </td>
    <td align="right" class="td_title">
        <a style="cursor:pointer" onclick="window.returnValue = ',';window.close();">
               <%=LanguageSupport.getResource("GWGL-1067","  取消选择")%>  
        </a>
    </td>
   </tr>
    <tr>
        <td valign="top" colspan="2">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr><td colspan=3 height=8></td></tr>
                <tr>
                    <td colspan="3" >
     </c:verbatim>
                        <h:dataTable width="100%" value="#{post_selPostBB.postList}" var="list" border="1" id="data"
                                     align="center"  headerClass="td_top" rowClasses="td_middle" styleClass="table03">
                           <h:column>
                               <c:verbatim><a style="cursor:pointer" onclick="sel('</c:verbatim><h:outputText value="#{list.postId}"/><c:verbatim>','</c:verbatim><h:outputText value="#{list.name}"/><c:verbatim>')"><strong>选择</strong></a></c:verbatim>
                            </h:column>
                            <h:column>
                                <c:facet name="header">
                                    <f:verbatim>
                                      <%=LanguageSupport.getResource("JGGL-1085"," 岗位")%>
                                    </f:verbatim>
                                </c:facet>
                                <h:outputText value="#{list.name}"/>
                            </h:column>
                            <h:column>
                                <c:facet name="header">
                                 <f:verbatim>
                                      <%=LanguageSupport.getResource("JGGL-1024"," 所属机构")%>
                               </f:verbatim>
                               </c:facet>
                                <h:outputText value="#{list.orgId}"/>
                            </h:column>
                             <h:column>
                                <c:facet name="header">
                               <f:verbatim>
                                      <%=LanguageSupport.getResource("JGGL-1079"," 岗位分类")%>
                               </f:verbatim>
                               </c:facet>
                                <h:outputText value="#{list.postClass}"/>
                            </h:column>
                        </h:dataTable>
    <c:verbatim>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</c:verbatim>
</h:form>
<script type="text/javascript">
    var orgId = "<%=orgId%>";
	if(orgId!="null"){
		refreshList(orgId);		
	}
	

</script>
