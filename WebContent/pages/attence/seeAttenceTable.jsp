<%@ page language="java" contentType="text/html; charset=gbk"
         pageEncoding="gbk" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.attence.ucc.impl.AttenceSetUCC" %>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttDurationBO" %>
<%@ page import="com.hr319wg.attence.pojo.vo.AttClassGroupVO" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttClassBO" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttItemSetDetailBO" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttenceDayMonthBO" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<link href="/css/style.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
    .td_class {
        border: 1px solid #B1CDE3;
        background: #fff;
        font-size: 12px;
        padding: 3px 3px 3px 8px;
        color: #4f6b72;
        text-align: center;
    }

    .table_css1 {
        border: 1px solid #B1CDE3;
        padding: 0;
        margin: 0 auto;
        border-collapse: collapse;
    }

    .table_css {
        border-collapse: collapse;
        border-top: 1px #000000 solid;
        border-right: 1px #000000 solid;
        border-bottom: 1px #000000 solid;
        border-left: 1px #000000 solid;
    }
</style>
<script type="text/javascript">
    function exportToExcel() {
        window.open("/pages/attence/seeAttTableExcel.jsp");
    }

    function showProcessBar() {
        x = document.body.clientWidth / 2 - 150;
        y = document.body.clientHeight / 2;
        document.all('processbar').style.top = y;
        document.all('processbar').style.left = x;
        document.all('processbar').style.display = "";
    }
</script>
<f:verbatim>
    <table width="95%" border="0" cellspacing="0" cellpadding="0" id="a" valign="top">
    <tr><td></f:verbatim>
<x:saveState value="#{seeAttenceTableBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageinit" value="#{seeAttenceTableBB.pageInit}"/>
    <h:panelGrid align="center" columns="2" width="95%">
        <h:panelGrid align="left" columns="2" width="100%">
            <h:panelGroup>
                <h:outputText styleClass="td03" value="考勤时间："></h:outputText>
                <h:selectOneMenu value="#{seeAttenceTableBB.atttype}"
                                 onchange="addDictionary();"
                                 valueChangeListener="#{seeAttenceTableBB.changeStatus}">
                    <c:selectItems value="#{seeAttenceTableBB.nowyearlist}"></c:selectItems>
                </h:selectOneMenu>
                <h:outputText value="年"></h:outputText>
                <h:selectOneMenu value="#{seeAttenceTableBB.atttype1}">
                    <c:selectItem itemLabel="01" itemValue="01"></c:selectItem>
                    <c:selectItem itemLabel="02" itemValue="02"></c:selectItem>
                    <c:selectItem itemLabel="03" itemValue="03"></c:selectItem>
                    <c:selectItem itemLabel="04" itemValue="04"></c:selectItem>
                    <c:selectItem itemLabel="05" itemValue="05"></c:selectItem>
                    <c:selectItem itemLabel="06" itemValue="06"></c:selectItem>
                    <c:selectItem itemLabel="07" itemValue="07"></c:selectItem>
                    <c:selectItem itemLabel="08" itemValue="08"></c:selectItem>
                    <c:selectItem itemLabel="09" itemValue="09"></c:selectItem>
                    <c:selectItem itemLabel="10" itemValue="10"></c:selectItem>
                    <c:selectItem itemLabel="11" itemValue="11"></c:selectItem>
                    <c:selectItem itemLabel="12" itemValue="12"></c:selectItem>
                </h:selectOneMenu>
                <h:outputText value="月"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="时间："></h:outputText>
                <h:selectOneMenu value="#{seeAttenceTableBB.beginDate}">
                    <c:selectItems value="#{seeAttenceTableBB.dayValueList}"/>
                </h:selectOneMenu>
                <h:outputText value="----"></h:outputText>
                <h:selectOneMenu value="#{seeAttenceTableBB.endDate}">
                    <c:selectItems value="#{seeAttenceTableBB.dayValueList}"/>
                </h:selectOneMenu>
                <h:commandButton styleClass="button01" value="查询" onclick="showProcessBar();"
                                 action="#{seeAttenceTableBB.doQuery}"/>
            </h:panelGroup>
        </h:panelGrid>
    </h:panelGrid>

    <marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right"
             width="300"
             scrollamount="5" scrolldelay="10"
             bgcolor="#ECF2FF">
        <table cellspacing="1" cellpadding="0">
            <tr height=8>
                <td bgcolor=#3399FF width=8></td>
                <td></td>
                <td bgcolor=#3399FF width=8></td>
                <td></td>
                <td bgcolor=#3399FF width=8></td>
                <td></td>
                <td bgcolor=#3399FF width=8></td>
                <td></td>
            </tr>
        </table>
    </marquee>

</h:form>
<f:verbatim>
</td></tr></table>
<%
    List dayHash = (ArrayList) session.getAttribute("dayList");
    Hashtable personHash = (Hashtable) session.getAttribute("personHash");
    Hashtable monthHash = (Hashtable) session.getAttribute("monthHash");
    List flarcharList = (ArrayList) session.getAttribute("flarcharList");
    List personsList = (ArrayList) session.getAttribute("personsList");
    String orgName = (String) session.getAttribute("orgName");
    String monthValue = (String) session.getAttribute("monthValue");
    String isAll = (String) session.getAttribute("isAll");
%>


<%if (personHash != null && personHash.size() > 0) { %>
<table width="95%" border="0" cellspacing="0" cellpadding="0" id="control" valign="top">
    <tr>
        <td align="right">
            <input name="b1" type="button" class="button01" value="导出到Excel" onclick="exportToExcel()">
        </td>
    </tr>
</table>

<table id="dtable" border="1" class='table_css1' width="95%">
    <tr>
        <td align='center' colspan="47" class='td_class'><h3>考 勤 表</h3><br>

            <div align="left"><h5>部门：<%=orgName %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=monthValue%>
            </h5></div>
        </td>
    </tr>
    <tr>
        <td rowspan="2" class='td_class'>姓名</td>
        <td class='td_class'>日期</td>
        <%
            if (dayHash != null && dayHash.size() > 0) {
                for (int i = 0; i < dayHash.size(); i++) {
                    String key = (String) dayHash.get(i);
                    String[] str = key.split(":");
        %>
        <td class='td_class'><%=str[0].substring(8, 10) %>
        </td>
        <%
                }
            }
            if (flarcharList != null && flarcharList.size() > 0) {
                for (int w = 0; w < flarcharList.size(); w++) {
                    AttItemSetDetailBO attitemsetdetailbo = (AttItemSetDetailBO) flarcharList.get(w);
                    String itemcodename = "";
                    if ("704".equals(attitemsetdetailbo.getItemCode())) {
                        itemcodename = "迟到";
                    } else if ("705".equals(attitemsetdetailbo.getItemCode())) {
                        itemcodename = "早退";
                    } else if ("706".equals(attitemsetdetailbo.getItemCode())) {
                        itemcodename = "旷工";
                    } else if ("707".equals(attitemsetdetailbo.getItemCode())) {
                        itemcodename = "事假";
                    } else if ("708".equals(attitemsetdetailbo.getItemCode())) {
                        itemcodename = "病假";
                    } else if ("709".equals(attitemsetdetailbo.getItemCode())) {
                        itemcodename = "产假";
                    } else if ("710".equals(attitemsetdetailbo.getItemCode())) {
                        itemcodename = "婚假";
                    } else if ("711".equals(attitemsetdetailbo.getItemCode())) {
                        itemcodename = "探亲假";
                    } else if ("712".equals(attitemsetdetailbo.getItemCode())) {
                        itemcodename = "年假";
                    } else if ("713".equals(attitemsetdetailbo.getItemCode())) {
                        itemcodename = "工伤假";
                    } else if ("714".equals(attitemsetdetailbo.getItemCode())) {
                        itemcodename = "丧假";
                    } else if ("715".equals(attitemsetdetailbo.getItemCode())) {
                        itemcodename = "出差";
                    } else if ("716".equals(attitemsetdetailbo.getItemCode())) {
                        itemcodename = "公出";
                    } else if ("717".equals(attitemsetdetailbo.getItemCode())) {
                        itemcodename = "公假";
                    } else if ("718".equals(attitemsetdetailbo.getItemCode())) {
                        itemcodename = "倒休";
                    } else if ("719".equals(attitemsetdetailbo.getItemCode())) {
                        itemcodename = "工作日延时加班";
                    } else if ("720".equals(attitemsetdetailbo.getItemCode())) {
                        itemcodename = "双休日加班";
                    } else if ("721".equals(attitemsetdetailbo.getItemCode())) {
                        itemcodename = "节假日加班";
                    }
                    if (attitemsetdetailbo.getItemCode() != null && !attitemsetdetailbo.getItemCode().equals("")) {
                        if (!attitemsetdetailbo.getItemCode().equals("00") && !"01".equals(attitemsetdetailbo.getItemCode())) {
                            out.println("<td rowspan='2' class='td_class'>" + itemcodename + "</td>");
                        }
                    }
                }
            }
        %>
    </tr>
    <tr>
        <td class='td_class'>星期</td>
        <%
            if (dayHash != null && dayHash.size() > 0) {
                for (int i = 0; i < dayHash.size(); i++) {
                    String key = (String) dayHash.get(i);
                    String[] str = key.split(":");
        %>
        <td class='td_class'><%=str[1] %>
        </td>
        <%
                }
            }
        %>
    </tr>
    <%
        if (personsList != null && personsList.size() > 0) {
            for (int i = 0; i < personsList.size(); i++) {
                String personId = (String) personsList.get(i);
                String personName = SysCacheTool.findPersonById(personId).getName();
    %>
    <tr>
        <td class='td_class' colspan="2"><%=personName %>
        </td>
        <%
            for (int j = 0; j < dayHash.size(); j++) {
                String key = (String) dayHash.get(j);
                String[] str = key.split(":");
                out.println("<td class='td_class'>" + personHash.get(personId + ":" + str[0]) + "</td>");
            }
            if (flarcharList != null && flarcharList.size() > 0) {
                for (int w = 0; w < flarcharList.size(); w++) {
                    AttItemSetDetailBO attitemsetdetailbo = (AttItemSetDetailBO) flarcharList.get(w);
                    if (isAll.equals("1")) {
                        AttenceDayMonthBO month = (AttenceDayMonthBO) monthHash.get(personId);
                        if (attitemsetdetailbo.getItemCode() != null && !attitemsetdetailbo.getItemCode().equals("")) {
                            if (!attitemsetdetailbo.getItemCode().equals("00") && !"01".equals(attitemsetdetailbo.getItemCode())) {
                                out.println("<td  class='td_class'>" + month.getValueByCode(attitemsetdetailbo.getItemCode()) + "</td>");
                            }
                        }
                    } else {
                        if (attitemsetdetailbo.getItemCode() != null && !attitemsetdetailbo.getItemCode().equals("")) {
                            if (!attitemsetdetailbo.getItemCode().equals("00") && !"01".equals(attitemsetdetailbo.getItemCode())) {
                                out.println("<td  class='td_class'>" + (String) monthHash.get(personId + attitemsetdetailbo.getItemCode()) + "</td>");
                            }
                        }
                    }
                }
            }
        %>
    </tr>
    <%
            }
        }
    %>
    <tr>
        <td class='td_class' colspan="<%=dayHash.size()+46 %>">符号含义：
            <%
                if (flarcharList != null && flarcharList.size() > 0) {
                    for (int w = 0; w < flarcharList.size(); w++) {
                        AttItemSetDetailBO attitemsetdetailbo = (AttItemSetDetailBO) flarcharList.get(w);
                        String itemcodename = "";
                        String flagcharname = "";
                        if ("00".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "正常";
                        } else if ("01".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "公休日";
                        } else if ("704".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "迟到";
                        } else if ("705".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "早退";
                        } else if ("706".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "旷工";
                        } else if ("707".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "事假";
                        } else if ("708".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "病假";
                        } else if ("709".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "产假";
                        } else if ("710".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "婚假";
                        } else if ("711".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "探亲假";
                        } else if ("712".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "年假";
                        } else if ("713".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "工伤假";
                        } else if ("714".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "丧假";
                        } else if ("715".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "出差";
                        } else if ("716".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "公出";
                        } else if ("717".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "公假";
                        } else if ("718".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "倒休";
                        } else if ("719".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "工作日延时加班";
                        } else if ("720".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "双休日加班";
                        } else if ("721".equals(attitemsetdetailbo.getItemCode())) {
                            itemcodename = "节假日加班";
                        }
                        flagcharname = attitemsetdetailbo.getFlagChar();
                        String flagcharcodename = itemcodename + "(" + flagcharname + ")   ";
            %>
            <%=flagcharcodename%>
            <%
                    }
                }
            %>
        </td>
    </tr>
</table>
<%} else { %>
<table>
    <tr>
        <td>
            <div align="center">
                <h3>无记录。</h3>
            </div>
        </td>
    </tr>
</table>
<%} %>
</f:verbatim>