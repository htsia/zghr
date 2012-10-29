<%@ page contentType="application/msword;;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%@ page import="com.hr319wg.util.FileUtil"%>
<%@ page import="java.io.*"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%

try

{
String path1=(String)session.getAttribute("path1");
String path2=(String)session.getAttribute("path2");
File pf=new File(path1,path2);
 FileReader freader=new FileReader(pf);
 BufferedReader bfdreader=new BufferedReader(freader);
 String str=bfdreader.readLine();
 while(str!=null)
 {
  out.print(str+"<br/>");
  str=bfdreader.readLine();
 }
 bfdreader.close();
 freader.close();
}
catch(IOException e)
{
 out.print(e);
}



%>


