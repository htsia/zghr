<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hr319wg.sys.pojo.bo.CodeItemBO"%>
<%@page import="com.hr319wg.sys.pojo.bo.InfoItemBO"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%
	String field=request.getParameter("field");
	String value=request.getParameter("value");
	if(field!=null && !"".equals(field) && value!=null && !"".equals(value)){
		InfoItemBO item= SysCacheTool.findInfoItem(field.substring(0, 4), field);
		if("6".equals(item.getItemDataType())){
			CodeItemBO bo= SysCacheTool.findCodeItem(item.getItemCodeSet(), value);
			if(bo!=null){
				out.print(bo.getItemName()+"|"+item.getItemCodeSet());
			}else{
				out.print("-1");
			}
		}else{
			out.print("-1");
		}
	}else{
		out.print("-1");		
	}
%>