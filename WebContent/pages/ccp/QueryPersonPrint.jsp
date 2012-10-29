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
    String head = "75����(31��),74����(32��),73����(33��),72����(34��),71����(35��),70����(36��),69����(37��),68����(38��),67����(39��)," +
            "66����(40��),65����(41��),64����(42��),63����(43��),62����(44��),61����(45��),60����(46��),59����(47��),58����(48��)," +
            "57����(49��),56����(50��),55����(51��),54����(52��),53����(53��),52����(54��),51����(55��),50����(56��),49����(57��)," +
            "48����(58��),47����(59��),46����(60��)";
    try {
        String sql = (String) session.getAttribute("activeSql");
        if (sql == null || sql.equals("")) {
            out.println("<div><font color=red>û�м�¼</font></div>");
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
                        list.add(new String[]{bo.getName() + "��" + year + "��" + mon + "��" + day + "�գ�"});
                    }
                }
                String file = FileUtil.exportFile(path, heads, null, list, true);
                response.sendRedirect("/file/employee/download/" + file);
            } else {
                out.println("<div><font color=red>û�м�¼</font></div>");
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