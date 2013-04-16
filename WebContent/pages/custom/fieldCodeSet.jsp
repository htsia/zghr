<%@page import="com.hr319wg.sys.pojo.bo.InfoItemBO"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%
	String field=request.getParameter("field");
	InfoItemBO item= SysCacheTool.findInfoItem(field.substring(0, 4), field);
	if(item==null){
		out.print("-1");
	}else{
		if("6".equals(item.getItemDataType())){
			out.print(item.getItemCodeSet());
		}else{
			out.print("-1");
		}
	}
%>