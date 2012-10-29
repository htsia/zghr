<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String superId = CommonFuns.filterNull(request.getParameter("superId"));
    String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));
     if(!"2".equals(rightFlag)){
         rightFlag = "1";
     }
%>
    <script type="text/javascript">
        function sel() {
            try {
                if (checkMutilSelect(document.form1.perId)) {
                    var id = "";
                    var name = "";
                    if (document.form1.all("perId").length == null) {
                        if (document.form1.perId.checked == true) {
                            id = document.form1.perId.value;
                            name = document.form1.perName.value;

                            var strvalue = id + "||" + name;
                            window.returnValue = strvalue;
                            window.close();
                        }
                    } else {
                        for (i = 0; i < document.form1.all("perId").length; i++) {
                            if (document.form1.perId(i).checked == true) {
                                id += document.form1.perId(i).value + ",";
                                name += document.form1.perName(i).value + ","
                            }
                        }
                        if (id != "") {
                            id = id.substr(0, id.length - 1);
                        }
                        if (name != "") {
                            name = name.substr(0, name.length - 1)
                        }

                        var strvalue = id + "||" + name;
                        window.returnValue = strvalue;
                        window.close();

                    }

                } else {
                    alert("请选择人员！")
                    return false;
                }
            } catch(err) {
                return false;
            }finally{

            }
        }
    </script>
    <h:form id="form1">
        <h:inputHidden id="flag" value="#{emp_selPersonBB.flag}"/>
        <input type="hidden" name = "rightFlag" value="<%=rightFlag%>"/>
        <c:verbatim>
        <table width="100%" height=98% border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF">
            <tr>
                <td class="td_title" height=8> 选择人员</td>
            </tr>

            <tr>
                <td valign="top" height=8>
                    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                                        <td>姓名：
        </c:verbatim>
                                            <h:inputText id="name" value="#{emp_selPersonBB.name}"  size="20"/>
        <c:verbatim>
                                        </td>
                                        <td>所属机构：
        </c:verbatim>
                                            <h:inputText id="org" value="#{emp_selPersonBB.org}"
                                                              size="20" code="" dict="yes" dict_num="OU"/>
        <c:verbatim>
                                            <input type="button"  onclick="PopUpOrgDlg('form1:org',<%=rightFlag%>,'<%=superId%>')"
                                                   class="button_select"/>
                                        </td>
                                        <td>
        </c:verbatim>
                                        <h:commandButton value="查询" onclick="javascript:return forsubmit(form1)"
                                                             styleClass="button01"
                                                             action="#{emp_selPersonBB.queryPerson}"/>
        <c:verbatim>
                                        </td>
                                        <td><input type="button" name="sel1" onclick="sel()" value="选择"
                                                   class="button01"></td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td>
                    <div style='width:100%;height:100%;overflow:auto' id=datatable>
        </c:verbatim>
                    <h:dataTable width="95%" value="#{emp_selPersonBB.personList}" var="list" border="1"
                                 align="center" headerClass="td_top" rowClasses="td_middle"  id="dateList"
                                 styleClass="table03">
                        <h:column>
                            <c:facet name="header"><c:verbatim escape="false"><input type="checkbox"
                                                                                     name="chkAll"
                                                                                     onclick="selectAll(document.form1.chkAll,document.form1.perId)"/>
                            </c:verbatim></c:facet>
                            <c:verbatim escape="false"><div align=center><input type="checkbox"
                                name="perId" value="</c:verbatim>
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
        <c:verbatim>
                    </div>
                </td>
            </tr>
        </table>
        </c:verbatim>
    </h:form>

<script type="text/javascript">
    interpret(form1);
    setDataTableOver("form1:dateList");
</script>