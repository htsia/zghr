<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>

<%
    response.setContentType("application/vnd.ms-excel;charset=GB2312");
    response.setHeader("Content-disposition","attachment; filename=tmp.xls");

    String []dealItem = (String[]) session.getAttribute("field");
    HashMap hash = (HashMap) session.getAttribute("fileValue");
%>

    <%
        if (hash != null && hash.size() > 0) {
            int col = dealItem.length;
    %>
    <table width="95%" border="0" align="center" class="table03">
        <tr align="left" class="td_top">
            <td height="27" colspan="<%=col+6%>" class="td_top">检查结果数据如下:
            <%
                String info=(String)hash.get("-1");
                out.write(info);
            %>
            </td>
        </tr>
        <tr >
            <td class="td_top">员工编号</td>
            <td class="td_top">身份证号</td>
            <td class="td_top">员工姓名</td>
            <td class="td_top">所在机构</td>
            <td class="td_top">所在部门</td>

            <%
                for (int c = 0; c < col; c++) {
            %>
            <td class="td_top"><%=CodeUtil.interpertCode("INFOITEM", dealItem[c])%></td>
            <%
                }
            %>
            <td class="td_top">错误描述</td>
        </tr>
        <%
            Iterator iterator = hash.values().iterator();
            Iterator key = hash.keySet().iterator();

            while (iterator.hasNext() && key.hasNext()) {
                String pid=(String) key.next();
                if ("-1".equals(pid)) {
                    iterator.next();
                    continue;
                }
                PersonBO p = SysCacheTool.findPersonById(pid);
                String[] data = (String[]) iterator.next();
        %>
        <tr>
            <td class="td_middle"><%if (p!=null) out.write(p.getPersonCode()); else out.write("-");%></td>
            <td class="td_middle"><%if (p!=null) out.write("'"+p.getIdCard()); else out.write("'"+data[0]);%></td>
            <td class="td_middle"><%=data[1]%></td>
            <td class="td_middle"><%if (p!=null) out.write(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,p.getOrgId())); else out.write("-");%></td>
            <td class="td_middle"><%if (p!=null) out.write(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,p.getDeptId())); else out.write("-");%></td>
            <%
                for (int c = 0; c < col; c++) {
            %>
            <td class="td_middle"><%=CodeUtil.interpertCode("", data[c+2])%></td>
            <%
                }
            %>
            <td class="td_middle"><%=data[col+2]%></td>
        </tr>
        <%
            }
        %>
    </table>
    <%
        }
    %>

