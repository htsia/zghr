<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ include file="/pages/include/taglib.jsp" %>
    <script type="text/javascript">
        function forsave(form1){
            document.getElementById("form1:flag").value = "2";
            return pageCodeExchange(form1);
        }

        function sel(code,value){
            window.returnValue = code + "," + value;
            window.close();
        }
    </script>

<x:saveState value="#{post_selPostBB}"></x:saveState>
<h:inputHidden id="flag" value="#{post_selPostBB.initByDept}" />
<h:form id="form1" >
<c:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
        <td class="td_title" >
          <%=LanguageSupport.getResource("GWGL-1066"," 选择岗位")%>
       </td>
    <td align="right" class="td_title" >
        <a style="cursor:pointer" onclick="window.returnValue = ',';window.close();">
               <%=LanguageSupport.getResource("GWGL-1067","取消选择")%>
        </a>
    </td>
   </tr>

    <tr><td colspan="2" height=10></td></tr>
    <tr>
         <td colspan="2" >
</c:verbatim>
                        <h:dataTable width="98%" value="#{post_selPostBB.postList}" var="list" border="1" id="data"
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
    setDataTableOver("form1:data");
</script>
