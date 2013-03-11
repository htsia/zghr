<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    Hashtable hash = (Hashtable) session.getAttribute("uploadPhoto");
    List errorDes = (List)session.getAttribute("errorDes");
%>
<script type="text/javascript">
	function process(){
		x = document.body.clientWidth / 2 - 150;
		y = document.body.clientHeight / 2;
		document.all('processbar').style.top = y;
		document.all('processbar').style.left = x;
		document.all('processbar').style.display = "";
	}
</script>
<x:saveState value="#{UpPhBB}"/>
<h:form id="form1">
    <c:verbatim><br>
    <table width="98%">
        <tr>
            <td>
                <%
                   if (errorDes!=null && errorDes.size()>0){
                       out.println("<A target='_blank' href='/pages/employee/batch/PhotoError.jsp'>共有"+errorDes.size()+"错误记录</A>");
                   }
                %>
            </td>
            <td align="right">
</c:verbatim>
                <h:commandButton value="保存到数据库" styleClass="button01" onclick="process();" action="#{UpPhBB.savePhoto}"></h:commandButton>
                <h:commandButton value="返回"  action="upload" styleClass="button01"></h:commandButton>
<c:verbatim>
            </td>
        </tr>
    </table>
        <%
            if (hash != null && hash.size() > 0) {
                out.println("<table align=\"center\" width=\"95%\"><tr><td align='left'>共有"+hash.size()+"条记录</td></tr></table>");
        %>
        <table width="95%" border="0" align="center" class="table03">
            <tr align="center" class="td_top">
                <td height="27" colspan="4" class="td_top">
                   <%=LanguageSupport.getResource("RYGL-2135","查看导入照片文件数据")%>  
                </td>
            </tr>
            <tr >
                <td class="td_top"> <%=LanguageSupport.getResource("YXGL-1023"," 文件名")%> </td>
                <td class="td_top"> <%=LanguageSupport.getResource("XTGL-1042","员工编号")%>  </td>
                <td class="td_top"> <%=LanguageSupport.getResource("RYGL-2136","员工姓名")%>  </td>
                <td class="td_top"> <%=LanguageSupport.getResource("RYGL-2137","所在机构")%>  </td>
            </tr>
            <%
                Iterator key = hash.keySet().iterator();
                while (key.hasNext()) {
                    String filename = (String)key.next();
                    PersonBO p=(PersonBO)hash.get(filename);
            %>
            <tr>
                <td class="td_middle"><%=filename%></td>
                <td class="td_middle"><%=p.getPersonCode()%></td>
                <td class="td_middle"><%=p.getName()%></td>
                <td class="td_middle"><%=CommonFuns.filterNull(CodeUtil.interpertCode("OU",p.getOrgId()))%></td>
            </tr>
            <%
                }
            %>
        </table>
        <%
            }
        %>
    </c:verbatim>
</h:form>
<marquee id="processbar" style="position:absolute;display:none; border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>