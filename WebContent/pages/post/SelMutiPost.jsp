<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <base target="_self">
    <title>选择岗位</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
        function forsave(form1) {
			var orgId = document.getElementById("form1:org").value;
			if(orgId==null || orgId==""){
				alert("请选择机构");
				return false;
			}
            document.getElementById("form1:flag").value = "2";
            return pageCodeExchange(form1);
        }

        function sel() {
            try {
                if (checkMutilSelect(document.form1.postId)) {
                    var id = "";
                    var name = "";
                    var orgName = "";
                    if (document.form1.all("postId").length == null) {
                        if (document.form1.postId.checked == true) {
                            id = document.form1.postId.value;
                            name = document.form1.postName.value;
                            orgName = document.form1.orgName.value;

                            var strvalue = id + "||" + name+"||"+orgName;
                            window.returnValue = strvalue;
                            window.close();
                        }
                    } else {
                        for (i = 0; i < document.form1.all("postId").length; i++) {
                            if (document.form1.postId(i).checked == true) {
                                id += document.form1.postId(i).value + ",";
                                name += document.form1.postName(i).value + ","
                                orgName += document.form1.orgName(i).value + ","
                            }
                        }
                        if (id != "") {
                            id = id.substr(0, id.length - 1);
                        }
                        if (name != "") {
                            name = name.substr(0, name.length - 1)
                        }
                        if (orgName != "") {
                            orgName = orgName.substr(0, orgName.length - 1)
                        }

                        var strvalue = id + "||" + name+"||"+orgName;
                        window.returnValue = strvalue;
                        window.close();

                    }

                } else {
                    alert("请选择岗位！")
                    return false;
                }
            } catch(err) {
                return false;
            } finally {

            }
        }

    </script>
</head>

<body>
<c:view>
    <h:form id="form1">
        <h:inputHidden id="flag" value="#{post_selPostBB.flag}"/>
        <table width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF">
            <tr>
                <td class="td_title">   <%=LanguageSupport.getResource("GWGL-1064", "选择岗位")%></td>
            </tr>
            <tr>
                <td valign="top">
                    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td>  <%=LanguageSupport.getResource("JGGL-1078", "岗位名称")%>：<h:inputText id="name" value="#{post_selPostBB.name}"
                                                              size="20"/></td>
                                        <td> <%=LanguageSupport.getResource("JGGL-1024", "所属机构")%>：<h:inputText id="org" value="#{post_selPostBB.org}"
                                                              size="20" code="" dict="yes" dict_num="OU"/>
                                            <input type="button"  onclick="PopUpOrgDlg('form1:org',1)"
                                                   class="button_select"/>
                                        </td>
                                        <td><h:commandButton value="查询" onclick="javascript:return forsave(form1)"
                                                             styleClass="button01"
                                                             action="#{post_selPostBB.queryPost}"/></td>
                                        <td><input type="button" name="sel1" onclick="sel()" value="<%=LanguageSupport.getResource("GWGL-1065", "选择")%>"
                                                   class="button01"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h:dataTable width="95%" value="#{post_selPostBB.postList}" var="list" border="1"
                                             align="center" headerClass="td_top" rowClasses="td_middle"
                                             styleClass="table03">
                                    <h:column>
                                        <c:facet name="header"><c:verbatim escape="false"><input type="checkbox"
                                                                                                 name="chkAll"
                                                                                                 onclick="selectAll(document.form1.chkAll,document.form1.postId)"/>
                                        </c:verbatim></c:facet>
                                        <c:verbatim escape="false"><div align=center><input type="checkbox"
                                            name="postId" value="</c:verbatim>
                                        <h:outputText value="#{list.postId}"/><c:verbatim>"></div></c:verbatim>
                                        <c:verbatim escape="false"><input
                                            type="hidden" name="postName"
                                            value="</c:verbatim><h:outputText value="#{list.name}"/><c:verbatim
                                            escape="false">"></c:verbatim>
                                        <c:verbatim escape="false"><input
                                            type="hidden" name="orgName"
                                            value="</c:verbatim><h:outputText value="#{list.orgId}"/><c:verbatim
                                            escape="false">"></c:verbatim>
                                    </h:column>
                                    <h:column>
                                        <c:facet name="header">
                                           <f:verbatim>
                                           <%=LanguageSupport.getResource("JGGL-1085", "岗位")%>
                                           </f:verbatim>
                                          </c:facet>
                                        <h:outputText value="#{list.name}"/>
                                    </h:column>
                                    <h:column>
                                        <c:facet name="header">
                                          <f:verbatim>
                                           <%=LanguageSupport.getResource("JGGL-1024", "所属机构")%>
                                           </f:verbatim>
                                          </c:facet>
                                        <h:outputText value="#{list.orgId}"/>
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