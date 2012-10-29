<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.ccp.pojo.bo.PartyBO" %>
<%@ page import="com.hr319wg.ccp.util.CcpTools" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String superId = request.getParameter("superId");
    if (superId == null || "".equals(superId)) {
        superId = (String) request.getAttribute("superId");
    }
    List list = SysCacheTool.querySubObject(SysCache.OBJ_PARTY, null, superId);
    list = CcpTools.filterParty(list, null);
%>
<html>
<head><title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script type="text/javascript">
        //0-up; 1-down;
        function move(obj, flag) {
            if (obj == null)
                return;
            if (flag == 0) {
                for (i = 0; i < obj.options.length; i++) {
                    if (obj.options[i].selected) {
                        if (i == 0) return;
                        tmpvalue = obj.options[i].value;
                        tmptext = obj.options[i].text;
                        tmp = document.createElement("option");
                        tmp.value = tmpvalue;
                        tmp.text = tmptext;
                        obj.add(tmp, i - 1);
                        obj.remove(i + 1);
                        tmp.selected = true;
                        document.all.showItem.scrollTop = document.all.showItem.scrollTop+5;
                    }
                }
                if (document.body.scrollTop > 10) {
                    document.body.scrollTop += -10;
                }
            } else {
                for (i = obj.options.length - 1; i >= 0; i--) {
                    if (obj.options[i].selected) {
                        if (i == (obj.length - 1)) return;
                        tmp = document.createElement("option");
                        tmp.value = obj.options[i].value;
                        tmp.text = obj.options[i].text;
                        obj.add(tmp, i + 2);
                        obj.remove(i);
                        tmp.selected = true;
                    }
                }
                document.body.scrollTop += 10;
            }

        }

        function movetop(obj) {
            for (i = 0; i < obj.options.length; i++) {
                if (obj.options[i].selected) {
                    if (i == 0) return;
                    tmpvalue = obj.options[i].value;
                    tmptext = obj.options[i].text;
                    tmp = document.createElement("option");
                    tmp.value = tmpvalue;
                    tmp.text = tmptext;
                    obj.add(tmp, 0);
                    obj.remove(i + 1);
                    tmp.selected = true;
                }
            }
        }

        function movebottom(obj) {
            for (i = 0; i < obj.options.length; i++) {
                if (obj.options[i].selected) {
                    if (i == (obj.length - 1)) return;
                    tmp = document.createElement("option");
                    tmp.value = obj.options[i].value;
                    tmp.text = obj.options[i].text;
                    obj.add(tmp, obj.length);
                    obj.remove(i);
                    tmp.selected = true;
                }
            }
        }

        function forSave() {
            for (i = 0; i < form1.showItem.options.length; i++) {
                form1.showItem.options[i].selected = true;
            }
            return true;
        }
    </script>
</head>

<body>
<x:saveState value="#{ccp_PartySortBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{ccp_PartySortBB.superId}"/>
    <table align=center width="80%" border="0" cellpadding="2" cellspacing="0">
        <%
            if (list != null && list.size() > 0) {
        %>
        <tr>
            <td class="td_top" colspan="3">&nbsp;</td>
        </tr>
        <tr>
            <td class="td_top">&nbsp;&nbsp;</td>
            <td class="td_middle" width="90%">

                <select name="showItem" size="24" multiple id="showItem" style="width:100%;">
                    <%
                        for (int i = 0; i < list.size(); i++) {
                            PartyBO org = (PartyBO) list.get(i);
                    %>
                    <option value="<%=org.getPartyId()%>"><%=org.getPartyName()%></option>
                    <%
                        }
                    %>
                </select>

            </td>
            <td class="td_middle" align=right width="10%">
                <p>
                    <input type=button class=button01 value='移至顶部' onclick="movetop(showItem)">
                </p>

                <p>
                    <input type=button class=button01 value=' 上移 ' onclick="move(showItem,0)">
                </p>

                <p>
                    <input name=save2 type=button class=button01 value=' 下移 ' onclick="move(showItem,1)">
                </p>

                <p>
                    <input type=button class=button01 value='移至底部' onclick="movebottom(showItem)">
                </p>
            </td>
        </tr>
        <br>
        <tr>
            <td class="td_top" colspan="3" align="center"><h:commandButton value=" 保存 " styleClass="button01"
                                                                           onclick="return forSave()"
                                                                           action="#{ccp_PartySortBB.saveSort}"/></td>
        </tr>
        <%
        } else {
        %>
        <tr>
            <td class="td_middle" colspan="3" align="center"> 无下级党组织！</td>
        </tr>

        <%
            }
        %>
    </table>
</h:form>
<script type="text/javascript">
    if (document.all.showItem.options.length > 30) {
        document.all.showItem.size = document.all.showItem.options.length;
    }

</script>
</body>
</html>