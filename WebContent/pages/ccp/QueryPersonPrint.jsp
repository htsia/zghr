<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.qry.util.QueryConstants" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.Vector" %>
<%@ page import="javax.faces.context.FacesContext" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.util.FileUtil" %>
<%@ page import="com.hr319wg.emp.ucc.IQueryPersonListUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%
    String age = "1975,1974,1973,1972,1971,1970,1969,1968,1967,1966,1965,1964,1963,1962,1961,1960,1959,1958,1957,1955,1955,1954,1953,1952,1951,1950,1949,1948,1947,1946";
    String head = "75年生(31岁),74年生(32岁),73年生(33岁),72年生(34岁),71年生(35岁),70年生(36岁),69年生(37岁),68年生(38岁),67年生(39岁)," +
            "66年生(40岁),65年生(41岁),64年生(42岁),63年生(43岁),62年生(44岁),61年生(45岁),60年生(46岁),59年生(47岁),58年生(48岁)," +
            "57年生(49岁),56年生(50岁),55年生(51岁),54年生(52岁),53年生(53岁),52年生(54岁),51年生(55岁),50年生(56岁),49年生(57岁)," +
            "48年生(58岁),47年生(59岁),46年生(60岁)";
    try {
        String sql = (String) session.getAttribute("activeSql");
        if (sql == null || sql.equals("")) {
            out.println("<div><font color=red>没有记录</font></div>");
        } else {
            String[] maxleng = new String[]{"0"};
            Hashtable ht = new Hashtable();
            ht.put(QueryConstants.SQL_SELECT_PART, CommonFuns.filterNull((String) session.getAttribute(QueryConstants.SQL_SELECT_PART)));
            ht.put(QueryConstants.SQL_FROM_PART, CommonFuns.filterNull((String) session.getAttribute(QueryConstants.SQL_FROM_PART)));
            ht.put(QueryConstants.SQL_WHERE_PART, CommonFuns.filterNull((String) session.getAttribute(QueryConstants.SQL_WHERE_PART)));
            ht.put(QueryConstants.SQL_SCALE_PART, CommonFuns.filterNull((String) session.getAttribute(QueryConstants.SQL_SCALE_PART)));
            ht.put(QueryConstants.SQL_ORDER_PART, CommonFuns.filterNull((String) session.getAttribute(QueryConstants.SQL_ORDER_PART)));
            IQueryPersonListUCC qrypersonlistucc = (IQueryPersonListUCC) SysContext.getBean("emp_qryPersonListUCC");
            Vector vect = qrypersonlistucc.queryPersonList(sql, age, maxleng, ht);
            System.out.println("@@@@@@@@");
            if (vect != null && vect.size() > 0) {
                System.out.println("!!!!!!!!!!!");
                ServletContext context = (ServletContext) FacesContext.getCurrentInstance().getExternalContext().getContext();
                System.out.println("############");
                String path = context.getRealPath("/") + File.separator + "file" + File.separator + "emp" + File.separator + "download";
                String[] heads = head.split(",");
                List list = new ArrayList();
                for (int i = 0; i < vect.size(); i++) {
                    System.out.println("@@@@@" + vect.get(i));
                    PersonBO bo = (PersonBO) vect.get(i);
                    if (bo == null) {
                        list.add(new String[]{""});
                    } else {
                        String year = bo.getBirth().trim().substring(0, 4);
                        String mon = bo.getBirth().trim().substring(5, 7);
                        String day = bo.getBirth().trim().substring(8);
                        list.add(new String[]{bo.getName() + "（" + year + "年" + mon + "月" + day + "日）"});
                    }
                }
                String file = FileUtil.exportFile(path, heads, null, list, true);
                response.sendRedirect("/file/employee/download/" + file);
            } else {
                out.println("<div><font color=red>没有记录</font></div>");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<html>
<head>
    <title></title>
</head>
</html>