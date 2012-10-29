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
                <h:commandButton value="保存到数据库" styleClass="button01" action="#{UpPhBB.savePhoto}"></h:commandButton>
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
