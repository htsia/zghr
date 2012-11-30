<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String superId = CommonFuns.filterNull(request.getParameter("superId"));
    String name = "";
    OrgBO bo = SysCacheTool.findOrgById(superId);
    if (bo != null) {
        name = bo.getName();
    }
%>
    <script type="text/javascript">
        function refreshList(orgId) {
            document.all("form1:org").value=orgId;
            document.all("form1:query").click();
        }
        function codeInterpretCallback() {
            if (xmlHttp.readyState == 4) {
                if (xmlHttp.status == 200) {
                    //处理返回的数据
                    var results = xmlHttp.responseXML;

                    var codes = results.getElementsByTagName("interpretitem");
                    if (codes!=null && codes.length==1){
                        if (codes[0].getElementsByTagName("codename")[0].firstChild != null)
                            document.all("form1:orgName").value = codes[0].getElementsByTagName("codename")[0].firstChild.nodeValue;
                        else
                            document.all("form1:orgName").value = "";
                    }
                }
            }
        }

        function forsave(form1){
            document.getElementById("form1:flag").value = "2";
            return pageCodeExchange(form1);
        }

        function sel(code,value){
            window.returnValue = code + "," + value;
            window.close();
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 50;
            $("iframe[name=tree]").height(mainHeight);
        }
        function transOrgName(){
            if (window.ActiveXObject)
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            else if (window.XMLHttpRequest)
                xmlHttp = new XMLHttpRequest();

            if (xmlHttp == null) {
                return;
            }
            var reqStr="Org=OU|"+document.all("form1:org").value;
            xmlHttp.onreadystatechange = codeInterpretCallback;
            xmlHttp.open("GET", "/pages/ajax/Interpret.jsp?" + reqStr, true);
            xmlHttp.send(null);
        }
    </script>

<h:form id="form1" >
<x:saveState value="#{post_selPostBB}"></x:saveState>
<h:inputHidden id="flag" value="#{post_selPostBB.flag}" />
<c:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
        <td class="td_title" >
          <%=LanguageSupport.getResource("GWGL-1066"," 选择岗位")%>
       </td>
    <td align="right" class="td_title" colspan="2">
        <a style="cursor:pointer" onclick="window.returnValue = ',';window.close();">
               <%=LanguageSupport.getResource("GWGL-1067","  取消选择")%>  
        </a>
    </td>
   </tr>

    <tr><td colspan="3" height=10></td></tr>
    <tr>
        <td width=200 valign="top">
            <iframe name="tree" height="400"  frameborder="0"  scrolling="auto" width="100%"
                                    src="/pages/common/ShowOrgTree.jsp"></iframe>
        </td>

        <td width="3" class="ctrlbar" valign="middle">
        </td>

        <td valign="top" >
            <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="4" >
                        <table>
                            <tr>
                                <td><strong><%=LanguageSupport.getResource("JGGL-1024"," 所属机构")%></strong>
    </c:verbatim>
                                    <h:inputText id="orgName"   readonly="true" size="20" />
                                    <h:inputHidden id="org" value="#{post_selPostBB.org}"  />
    <c:verbatim>
                                </td>

                                <td><strong><%=LanguageSupport.getResource("JGGL-1077"," 岗位名称")%></strong>
                        </c:verbatim>
                                    <h:inputText id="name" value="#{post_selPostBB.name}"  size="20"/>
                        <c:verbatim>
                                </td>

                                <td>
    </c:verbatim>
                                <h:commandButton value="查询" id="query"  styleClass="button01"  action="#{post_selPostBB.queryPost}"/></td>
    <c:verbatim>
                            </tr>
                        </table>
                    </td>
                </tr>
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
    transOrgName();
    setDataTableOver("form1:data");
</script>
