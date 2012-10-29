<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState id="downFileBackingBean" value="#{downFileBackingBean}"/>
<h:form id="form1" enctype="multipart/form-data" >
<h:inputHidden value="#{downFileBackingBean.pageinit}"></h:inputHidden>
    <c:verbatim>
        <table width=98% height=98% align="center">
        <tr><td height=8 class="td_title">
    </c:verbatim>
            <h:graphicImage value="/images/tips.gif" />
             <f:verbatim>
               软件下载  
            </f:verbatim>
    <c:verbatim>
        </td></tr>

        <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </c:verbatim>
        <h:dataTable value="#{downFileBackingBean.listweb}" var="filelist" id="dateList" headerClass="td_top"
                     width="100%" columnClasses="s1,s1,s2,s1,s1,s1" align="center" border="1" styleClass="table03" >
                            <h:column>
                                <f:facet name="header">
                                    <f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1023","文件名")%>  
                              </f:verbatim>
                                </f:facet>
                                <h:outputText value="#{filelist.filename}" escape="false"/>
                            </h:column>

                            <h:column>
                                <f:facet name="header">
                                   <f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1024","描 述")%>  
                              </f:verbatim>
                                </f:facet>
                                <h:outputText value="#{filelist.describe}" escape="false"/>
                            </h:column>

                            <h:column>
                                <f:facet name="header">
                                   <f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1025","文件大小")%>  
                              </f:verbatim>
                                </f:facet>
                                <h:outputText value="#{filelist.filesize}" />
                            </h:column>

                            <h:column>
                                <f:facet name="header">
                                    <f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1005","发布时间")%>  
                              </f:verbatim>
                                </f:facet>
                                <h:outputText value="#{filelist.datetime}" />
                            </h:column>

                            <h:column>

                     <f:facet name="header">
                              <f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1026","操 作")%>  
                              </f:verbatim>
                      </f:facet>
                        <f:verbatim><a target="_blank" href="</f:verbatim><h:outputText value="#{filelist.relativepath}"/><f:verbatim>">
              			 下载</a></f:verbatim>
                            </h:column>
              </h:dataTable>
   <c:verbatim>
       </div>
       </td></tr>
        </table>
   </c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
