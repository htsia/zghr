<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
     String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));
     if(!"2".equals(rightFlag)){
         rightFlag = "1";
     }
%>
<html>
<head>
    <base target="_self">
    <title>选择人员</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">

        function forsave(form1) {
            document.getElementById("form1:flag").value = "2";
            return pageCodeExchange(form1);
        }

        function sel() {
            if (checkMutilSelect(document.form1.chk)) {
                document.getElementById("form1:flag").value = "2";
                return true;
            } else {
                alert("请选择人员！")
                return false;
            }
        }

    </script>
</head>
<%
    String sid = request.getParameter("sid");
%>
<body>
<c:view>
    <h:form id="form1">
        <x:saveState value="#{emp_selPersonBB}"/>
        <h:inputHidden id="flag" value="#{emp_selPersonBB.flag}"/>
         <input type="hidden" name = "rightFlag" value="<%=rightFlag%>"/>
        <input type="hidden" name="sid" value="<%=sid%>">
        <table width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF">
            <tr>
                <td class="td_title">选择人员</td>
            </tr>
            <tr>
                <td valign="top">
                    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td>姓名：<h:inputText id="name" value="#{emp_selPersonBB.name}"
                                                            size="20"/></td>
                                        <td>所属机构：<h:inputText id="org" value="#{emp_selPersonBB.org}"
                                                              size="20" code="" dict="yes" dict_num="OU"/>
                                            <input type="button" value=".." onclick="PopUpOrgDlg('form1:org',<%=rightFlag%>,'')"
                                                   class="button_select"/>
                                        </td>
                                        <td><h:commandButton value="查询" onclick="javascript:return forsave(form1)"
                                                             styleClass="button01"
                                                             action="#{emp_selPersonBB.queryPerson}"/></td>
                                        <td><h:commandButton value="选择" onclick="javascript:return sel()"
                                                             styleClass="button01"
                                                             action="#{emp_selPersonBB.savePerson}"/></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h:dataTable width="100%" value="#{emp_selPersonBB.personList}" var="list" border="1"
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
                                        <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                                        <h:outputText value="#{list.name}"/>
                                    </h:column>
                                    <h:column>
                                        <c:facet name="header"><h:outputText value="性别"/></c:facet>
                                        <h:outputText value="#{list.sex}"/>
                                    </h:column>
                                    <h:column>
                                        <c:facet name="header"><h:outputText value="出生日期"/></c:facet>
                                        <h:outputText value="#{list.birth}"/>
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
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </h:form>
</c:view>
</body>
<script type="text/javascript">
    interpret(form1);
</script>
</html>