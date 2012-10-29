<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));
%>
    <c:verbatim>
    <base target="_self">
</c:verbatim>
    <script type="text/javascript">
        function sel() {
            if (checkMutilSelect(document.form1.chk)) {
                document.getElementById("flag").value = "2";
                return true;
            } else {
                alert("请选择人员！")
                return false;
            }
        }
    </script>

    <x:saveState value="#{emp_selBackPersonBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{emp_selBackPersonBB.pageInit}"/>
         <c:verbatim>
        <input type="hidden" name="flag"/>
        <input type="hidden" name="rightFlag" value=<%=rightFlag%>/> 
        <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
            <tr>
                <td class="td_title"> <%=LanguageSupport.getResource("RYGL-2418","选择人员 ")%> </td>
                <td class="td_title" align="right">
</c:verbatim>
                    <h:commandButton value="选择" onclick="javascript:return sel()"
                                                                styleClass="button01"
                                                                action="#{emp_selBackPersonBB.savePerson}"/>

<c:verbatim>
                </td>
            </tr>

       <tr> <td height=8></td></tr>

            <tr>
                <td valign="top" colspan=2>
</c:verbatim>
                                <h:dataTable width="100%" value="#{emp_selBackPersonBB.personList}" var="list"
                                             border="1"        id="data"
                                             align="center" headerClass="td_top" rowClasses="td_middle"
                                             styleClass="table03">
                                    <h:column>
                                        <c:facet name="header"><c:verbatim escape="false"><input type="checkbox"
                                                                                                 name="chkAll"
                                                                                                 onclick="selectAll(document.form1.chkAll,document.form1.chk)"/>
                                        </c:verbatim></c:facet>
                                        <c:verbatim escape="false"><div align=center><input type="checkbox"
                                            name="chk" value="</c:verbatim>
                                        <h:outputText value="#{list.personId}"/><c:verbatim>"></div></c:verbatim>
                                        <c:verbatim escape="false"><input
                                            type="hidden" name="perName"
                                            value="</c:verbatim><h:outputText value="#{list.name}"/><c:verbatim
                                            escape="false">"></c:verbatim>
                                    </h:column>
                                    <h:column>
                                        <c:facet name="header">
                                         <f:verbatim>
                                         <%=LanguageSupport.getResource("RYGL-1016","姓名")%>
                                         </f:verbatim>
                                        </c:facet>
                                        <h:outputText value="#{list.name}"/>
                                    </h:column>
                                    <h:column>
                                        <c:facet name="header">
                                         <f:verbatim>
                                         <%=LanguageSupport.getResource("MSG-0012","性别")%>
                                         </f:verbatim>
                                        </c:facet>
                                        <h:outputText value="#{list.sex}"/>
                                    </h:column>
                                    <h:column>
                                        <c:facet name="header">
                                         <f:verbatim>
                                         <%=LanguageSupport.getResource("MSG-0013","出生日期")%>
                                         </f:verbatim>
                                        </c:facet>
                                        <h:outputText value="#{list.birth}"/>
                                    </h:column>
                                    <h:column>
                                        <c:facet name="header">
                                         <f:verbatim>
                                         <%=LanguageSupport.getResource("JGGL-1024","所属机构")%>
                                         </f:verbatim>
                                        </c:facet>
                                        <h:outputText value="#{list.orgId}"/>
                                    </h:column>
                                    <h:column>
                                        <c:facet name="header">
                                           <f:verbatim>
                                         <%=LanguageSupport.getResource("JGGL-1025","所属部门")%>
                                         </f:verbatim>
                                        </c:facet>
                                        <h:outputText value="#{list.deptId}"/>
                                    </h:column>
                                     <h:column>
                                        <c:facet name="header">
                                          <f:verbatim>
                                         <%=LanguageSupport.getResource("XTGL-1044","员工类别")%>
                                         </f:verbatim>
                                        </c:facet>
                                        <h:outputText value="#{list.personType}"/>
                                    </h:column>
                                </h:dataTable>
<c:verbatim>
                </td>
            </tr>
        </table>
</c:verbatim>
    </h:form>

<script type="text/javascript">
    interpret(form1);
    setDataTableOver("form1:data");
</script>
