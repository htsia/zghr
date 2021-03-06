<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
     response.setHeader("progma", "no-cache");
     response.setHeader("Cache-Control", "no-cache");
     response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function sel(code,value,email,mobile){
            window.returnValue = code + "," + value+ "," +email + "," +mobile ;
            window.close();
        }
    </script>

<h:form id="form1" >
<c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif" alt="">选择人员</td>
        </tr>

        <tr>
        <td valign="top">
            <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td >
</c:verbatim>
                        <h:outputText value="姓名"></h:outputText>
                        <h:inputText id="name" value="#{emp_selPersonBB.name}" size="20"/>
                        <h:commandButton value="查询"   styleClass="button01"    action="#{emp_selPersonBB.queryeMailInSelf}"/>
<c:verbatim>
                    </td>
                </tr>

                 <tr><td height=8></td></tr>

                 <tr>
                    <td >
</c:verbatim>
                        <h:dataTable width="100%" value="#{emp_selPersonBB.addressList}" var="list" border="1"  id="dateList"
                                     align="center"  headerClass="td_top" rowClasses="td_middle" styleClass="table03">
                           <h:column>
                               <c:facet name="header"><h:outputText value="操作"/></c:facet>
                               <c:verbatim><a class="cursor:hand" onclick="sel('</c:verbatim><h:outputText value="#{list.personId}"/><c:verbatim>','</c:verbatim><h:outputText value="#{list.name}"/><c:verbatim>','</c:verbatim><h:outputText value="#{list.email}"/><c:verbatim>','</c:verbatim><h:outputText value="#{list.mobile}"/><c:verbatim>')">选择</a></c:verbatim>
                            </h:column>
                            <h:column>
                                <c:facet name="header"><h:outputText value="所属机构"/></c:facet>
                                <h:outputText value="#{list.orgName}"/>
                            </h:column>
                            <h:column>
                                <c:facet name="header"><h:outputText value="所属部门"/></c:facet>
                                <h:outputText value="#{list.deptName}"/>
                            </h:column>

                            <h:column>
                                <c:facet name="header"><h:outputText value="员工编号"/></c:facet>
                                <h:outputText value="#{list.personCode}"/>
                            </h:column>
                            <h:column>
                                <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                                <h:outputText value="#{list.name}"/>
                            </h:column>

                            <h:column>
                                <c:facet name="header"><h:outputText value="eMail"/></c:facet>
                                <h:outputText value="#{list.email}"/>
                            </h:column>

                            <h:column>
                                <c:facet name="header"><h:outputText value="手机"/></c:facet>
                                <h:outputText value="#{list.mobile}"/>
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
   setDataTableOver("form1:dateList");
</script>
