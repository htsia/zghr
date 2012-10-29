<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="java.util.List"%>
<%@ page import="com.hr319wg.rpt.ucc.impl.RptInfoUCC"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@page import="com.hr319wg.rpt.pojo.bo.RptGroupDirBO"%>

<%
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
	response.setContentType("text/xml;charset=GBK");

	String superId = request.getParameter("superId"); // 上级
	
	out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
	out.println("<tree>");
	String icon = "";
	String childnum = "";
	List list = null;
	RptInfoUCC rptucc = null;

	try {
		rptucc = (RptInfoUCC) SysContext.getBean("rpt_infoucc");
		list = rptucc.getRptGroupDirList(superId);
	} catch (Exception e) {
		e.printStackTrace();
	}
	if (list != null) {
		for (int i = 0; i < list.size(); i++) {
			icon = "folder";
			out.println("<itemKeySet>");
			RptGroupDirBO rptGroupDirBO = (RptGroupDirBO) list.get(i);
			String gname = rptGroupDirBO.getDirName()+"("+rptucc.getRptGroupBO(rptGroupDirBO.getGroupId()).getGroupName()+")";
			rptGroupDirBO.setDirName(gname);
			if (rptGroupDirBO != null) {
				try {
					//参数1 GroupID  参数2 GroupDirID
					List li = rptucc.getRptGroupDirList(rptGroupDirBO.getDirId());
					if (li != null && li.size() > 0) {
						childnum = "1";
					} else {
						childnum = "0";
					}
				} catch (Exception e) {
					childnum = "0";
				}
				out.println("<key>" + rptGroupDirBO.getDirId()
						+ "</key>");
				out.println("<name>" + rptGroupDirBO.getDirName()
						+ "</name>");
				out.println("<id>" + rptGroupDirBO.getDirId()
								+ "</id>");
				out.println("<icon>" + icon + "</icon>");
				out.println("<childnum>" + childnum + "</childnum>");
			}
			out.println("</itemKeySet>");
		}
		
	}
	out.println("</tree>");
%>
