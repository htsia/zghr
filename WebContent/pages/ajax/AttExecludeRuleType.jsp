<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.TrainAPI" %>
<%@ page import="com.hr319wg.train.pojo.bo.CourceWareTypeBO" %>
<%@ page import="com.hr319wg.attence.ucc.IAttenceSetUCC" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");
    String superId = request.getParameter("superId");                           // 上级
    User user = (User) session.getAttribute(Constants.USER_INFO);
    String orgid = user.getOrgId();
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    TrainAPI api = null;
    IAttenceSetUCC rc=null;
    try {
        rc = (IAttenceSetUCC) SysContext.getBean("att_setUCC");
        list = rc.getInfoItemBO("A811");
    }
    catch (Exception e) {

    }
    // 返回结果
    if (list != null) {
    	InfoItemBO infoitembo=new InfoItemBO();
    	if("ORACLE".equals(Constants.DB_TYPE)){
    		infoitembo.setItemId("0+isnull(c.A796708,'0')");
    	}else{
    		infoitembo.setItemId("cast(c.A796708 as float)");
    	}
    	infoitembo.setItemName("工龄");
    	if(infoitembo!=null){
            icon = "folder";
            out.println("<GroupType>");
                    childnum = "0";
                out.println("<key>" + infoitembo.getItemId() + "</key>");
                out.println("<name>" + infoitembo.getItemName()+ "</name>");
                out.println("<id>" + infoitembo.getItemId() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            out.println("</GroupType>");
    	}
    	
    	infoitembo=new InfoItemBO();
    	if("ORACLE".equals(Constants.DB_TYPE)){
    		infoitembo.setItemId("0+isnull(b.ANN_DAY,'0')");
    	}else{
    		infoitembo.setItemId("cast(b.ANN_DAY as float)");
    	}
    	infoitembo.setItemName("可享受年假时间");
    	if(infoitembo!=null){
            icon = "folder";
            out.println("<GroupType>");
                    childnum = "0";
                out.println("<key>" + infoitembo.getItemId() + "</key>");
                out.println("<name>" + infoitembo.getItemName()+ "</name>");
                out.println("<id>" + infoitembo.getItemId() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            out.println("</GroupType>");
    	}
        for (int i = 0; i < list.size(); i++) {

            icon = "folder";
            out.println("<GroupType>");

            InfoItemBO o = (InfoItemBO) list.get(i);
            
            if (o != null) {
                    childnum = "0";
                    String str1="";
                	if("ORACLE".equals(Constants.DB_TYPE)){
                		str1="0+isnull(a."+o.getItemId()+",'0')"; 
                	}else{
                        str1="cast(a."+o.getItemId()+" as float)";  
                	}
                String str2="当年"+o.getItemName();
                out.println("<key>" + str1 + "</key>");
                out.println("<name>" + str2+ "</name>");
                out.println("<id>" + str1 + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</GroupType>");
        }
        
        for (int i = 0; i < list.size(); i++) {

            icon = "folder";
            out.println("<GroupType>");

            InfoItemBO o = (InfoItemBO) list.get(i);
            
            if (o != null) {
                    childnum = "0";
                    String str1="";
                	if("ORACLE".equals(Constants.DB_TYPE)){
                		str1="0+isnull(a.Last_"+o.getItemId()+",'0')";
                	}else{
                        str1="cast(a.Last_"+o.getItemId()+" as float)";
                	}
                    String str2="上一年"+o.getItemName();
                out.println("<key>" + str1 + "</key>");
                out.println("<name>" +str2 + "</name>");
                out.println("<id>" + str1 + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</GroupType>");
        }
        
    }
    out.println("</tree>");
%>
