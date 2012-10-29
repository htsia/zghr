<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.qry.util.QueryConstants" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="org.springframework.jdbc.core.JdbcTemplate"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    int a = 0;
    String b = "";
    try{
    if(null != request.getParameter("Execute")){
        JdbcTemplate jt = (JdbcTemplate) SysContext.getBean("jdbcTemplate");
        String count = request.getParameter("count");
        count = count.replaceAll("''","'");
        a = jt.queryForInt(count);
    }
    }catch(Exception e){
        b = e.getMessage();
    }


    String select = (String) session.getAttribute(QueryConstants.SQL_SELECT_PART);
    String from = (String) session.getAttribute(QueryConstants.SQL_FROM_PART);
    String where = (String) session.getAttribute(QueryConstants.SQL_WHERE_PART);
    for(int i=0;i<10;i++){
        select = CommonFuns.filterNull(select).replaceAll("  "," ");
        from = CommonFuns.filterNull(from).replaceAll("  "," ");
        where =CommonFuns.filterNull( where).replaceAll("  "," ");
    }
    where = where.replaceAll("'","''");
    String pk = "";
    String type=request.getParameter("type");
    if("A".equals(type))
        pk = "A001.ID";
    else if("B".equals(type))
        pk = "B001.ORGUID";
    else if("C".equals(type))
        pk = "C001.POSTID";
    else if("D".equals(type))
        pk = "D001.PARTYID";


%>
<html>
<head><title>
</title></head>
<link href="../../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/js/Appclient.js" ></script>
<script type="text/javascript">
    function popQuery(type){
        doAdvanceQuery(type,"ORG","011","Y","","","N","","","");
    }
</script>
<body>
<br><br><br>
<center>
    <form action="Condition.jsp" method="post">
    <table border="0" width="700">

        <tr>
            <td align="right">
                <select name="type">
                    <option value="A"> <%=LanguageSupport.getResource("XTGL-1182","人员")%> </option>
                    <option value="B"><%=LanguageSupport.getResource("XTGL-1183", "机构 ")%></option>
                    <option value="C"> <%=LanguageSupport.getResource("XTGL-1184","岗位")%></option>
                    <option value="D"> <%=LanguageSupport.getResource("XTGL-1185","党组织")%></option>
                </select>
                <input type="submit" class="button01" value='<%=LanguageSupport.getResource("XTGL-1185","定制条件")%>' style="width:200;" onclick="popQuery(document.all('type').value)">
            </td>

        </tr>
        <tr>
            <td align="left">
                Count<br>
                <textarea name="count" rows="4" style="width:100%;">select count(distinct <%=pk%> ) <%=" from " + from + " where " + where%></textarea>
            </td>
        </tr>
        <tr>
            <td align="right">
             <%=LanguageSupport.getResource("XTGL-1186","个数")%>:<%=a%>&nbsp;&nbsp;&nbsp;
             <input type="submit" class="button01" value="<%=LanguageSupport.getResource("JGGL-0109","查询")%>" name="Execute">
            </td>
        </tr>
        <tr>
            <td>
                <%=b%>
            </td>
        </tr>

        <tr>
            <td align="left"><br><br><br><br>
                Full<br>
                <textarea rows="4" style="width:100%;"><%="select " + select + " from " + from + " where " + where%></textarea>
            </td>
        </tr>
    </table>
    </form>
</center>
</body>
</html>