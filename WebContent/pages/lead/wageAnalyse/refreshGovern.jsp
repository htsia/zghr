<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="java.util.Vector" %>
<%
    String htsum=(htsum)session.getAttribute("htsum");
    Stromg htdetail=(htdetail)session.getAttribute("htdetail");
    //合计管理人员工资数据
    cv = new CellVO[1];
    cv[0] = new CellVO();

    Vector vtsum = activepageservice.getDataListBySql(cv, sql);
    Hashtable vhtsum = new Hashtable();
    for (int i = 0; i < htsum.size(); i++) {
        CellVO[] row = (CellVO[]) vtsum.get(i);
        vhtsum.put(row[0].getValue(), row[1].getValue());
    }
    session.setAttribute("htsum", vhtsum);
    //管理人员工资数据明细
    cv = new CellVO[1];
    cv[0] = new CellVO();
    Hashtable vhtdetail = new Hashtable();
    for (int i = 0; i < htdetail.size(); i++) {
        CellVO[] row = (CellVO[]) vtdetail.get(i);
        vhtdetail.put(row[0].getValue(), row[1].getValue());
    }
    session.setAttribute("htdetail", vhtdetail); 
%>