<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="java.util.List"%>
<%@ page import="com.hr319wg.lain.ucc.ILainSupplyUCC"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@page import="com.hr319wg.lain.pojo.bo.*"%>

<%
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
	response.setContentType("text/xml;charset=GBK");

	String superId = request.getParameter("superId"); // ÉÏ¼¶
	
	out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
	out.println("<tree>");
	String icon = "";
	String childnum = "";
	List list = null;
    ILainSupplyUCC lainSupplyUCC;
    StockBO stockBO = null ;
	try {
		lainSupplyUCC = (ILainSupplyUCC)SysContext.getBean("lainSupplyUCC");
		list = lainSupplyUCC.getStockList();  
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	 if (list != null && list.size() > 0) {
	        for (int i = 0; i < list.size(); i++) {
	            icon = "folder";
	            out.println("<Code>");
	            stockBO = (StockBO)list.get(i);
	                childnum = "0";
	                out.println("<key>" + stockBO.getStockId()+ "</key>");
	                out.println("<name>" + stockBO.getStockName()+ "</name>");
	                out.println("<id>" + stockBO.getStockId()+ "</id>");
	                out.println("<icon>" + icon + "</icon>");
	                out.println("<childnum>" + childnum + "</childnum>");
	            out.println("</Code>");
	        }
	    }
	    out.println("</tree>");
	%>