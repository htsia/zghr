<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../include/taglib.jsp" %>
<%
     response.setHeader("progma", "no-cache");
     response.setHeader("Cache-Control", "no-cache");
     response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
     String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));
%>
    <script type="text/javascript">
        function sel(code,value){
            window.returnValue = code + "," + value;
            window.close();
        }
    </script>
<x:saveState value="#{emp_selPersonBB}"></x:saveState>
<h:form id="form1" >
    <h:inputHidden id="flag" value="#{emp_selPersonBB.flag}" />
    <h:inputHidden id="org" value="#{emp_selPersonBB.org}" />
    <h:inputHidden id="filter" value="#{emp_selPersonBB.filter}" />
    <c:verbatim>
    <input type="hidden" name = "rightFlag" value="<%=rightFlag%>"/>
    <table width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif" alt="">选择人员</td>
        </tr>
        <tr><td height=8></td></tr>
        <tr>
        <td valign="top">
            <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td >
</c:verbatim>
                        <h:outputText value="姓名、简拼、员工编号或身份证:"></h:outputText>
                        <h:inputText id="name" value="#{emp_selPersonBB.name}" size="20"/>
                        <h:commandButton value="查询"   styleClass="button01"    action="#{emp_selPersonBB.queryPerson}"/>
<c:verbatim>
                    </td>
                </tr>

                 <tr><td height=8></td></tr>

                <tr>
                    <td >
</c:verbatim>
                       <h:dataTable width="100%" value="#{emp_selPersonBB.personList}" var="list" border="1"
                                     align="center"  headerClass="td_top" rowClasses="td_middle" styleClass="table03">
                           <h:column>
                               <c:facet name="header"><h:outputText value="操作"/></c:facet>
                               <c:verbatim><a class="cursor:hand" onclick="sel('</c:verbatim><h:outputText value="#{list.personId}"/><c:verbatim>','</c:verbatim><h:outputText value="#{list.name}"/><c:verbatim>')">选择</a></c:verbatim>
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
                                <c:facet name="header"><h:outputText value="身份证号"/></c:facet>
                                <h:outputText value="#{list.idCard}"/>
                            </h:column>

                            <h:column>
                                <c:facet name="header"><h:outputText value="人员类别"/></c:facet>
                                <h:outputText value="#{list.personType}"/>
                            </h:column>

                            <h:column>
                                <c:facet name="header"><h:outputText value="性别"/></c:facet>
                                <h:outputText value="#{list.sex}"/>
                            </h:column>
                            <h:column>
                                <c:facet name="header"><h:outputText value="所属机构"/></c:facet>
                                <h:outputText value="#{list.orgId}"/>
                            </h:column>
                            <h:column>
                                <c:facet name="header"><h:outputText value="所属部门"/></c:facet>
                                <h:outputText value="#{list.deptId}"/>
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
