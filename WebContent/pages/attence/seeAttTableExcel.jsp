<%@ page language="java" pageEncoding="UTF-8"%>  
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>  
 <head>  
   <%   
    out.clearBuffer();   
    response.setHeader("Content-Type","application/vnd.ms-excel;charset=GBK");   
  	response.setHeader("Content-Disposition","attachment;filename=result.xls");   
  %>  
   <meta http-equiv="Content-Type" content="text/html; charset=GBK">  
    <meta http-equiv="pragma" content="no-cache">  
    <meta http-equiv="cache-control" content="no-cache">  
 </head>  
 <body> 
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
 </body>  
</html> 

