<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
     String superId = CommonFuns.filterNull(request.getParameter("superId"));
     String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));
     if(!"2".equals(rightFlag)){
         rightFlag = "1";
     }
%>
<html>
<head>
     <base target="_self">
    <title>选择人员</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">

        function forsave(form1){
            document.getElementById("form1:flag").value = "2";
            return pageCodeExchange(form1);
        }

        function sel(code,value){
            parent.window.returnValue =code+","+value; 
           parent.close();
        }
    </script>
</head>

<body>
<c:view>
<h:form id="form1" >
 <h:inputHidden id="flag" value="#{emp_selPersonBB.orgFlag}"/>
    <input type="hidden" name = "rightFlag" value="<%=rightFlag%>">
<table width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF">
<tr>
    <td class="td_title"> 选择人员</td>
</tr>
<tr>
    <td valign="top">
        <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="3" >
                    <h:dataTable width="100%" value="#{emp_selPersonBB.personList}" var="list" border="1"
                                 align="center"  headerClass="td_top" rowClasses="td_middle" styleClass="table03">
                       <h:column>
                           <c:verbatim><a class="cursor:hand" onclick="sel('</c:verbatim><h:outputText value="#{list.personId}"/><c:verbatim>','</c:verbatim><h:outputText value="#{list.name}"/><c:verbatim>')">选择</a></c:verbatim>
                        </h:column>
                        <h:column>
                            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                            <h:outputText value="#{list.name}"/>
                        </h:column>
                        <h:column>
                            <c:facet name="header"><h:outputText value="性别"/></c:facet>
                            <h:outputText value="#{list.sex}"/>
                        </h:column>
                        <h:column>
                            <c:facet name="header"><h:outputText value="出生日期"/></c:facet>
                            <h:outputText value="#{list.birth}"/>
                        </h:column>
                        <h:column>
                            <c:facet name="header"><h:outputText value="所属机构"/></c:facet>
                            <h:outputText value="#{list.orgId}"/>
                        </h:column>
                        <h:column>
                            <c:facet name="header"><h:outputText value="所属部门"/></c:facet>
                            <h:outputText value="#{list.deptId}"/>
                        </h:column>
                        <h:column>
                            <c:facet name="header"><h:outputText value="政治面貌"/></c:facet>
                            <h:outputText value="#{list.partyFigure}"/>
                        </h:column>
                        <h:column>
                            <c:facet name="header"><h:outputText value="参加党派时间"/></c:facet>
                            <h:outputText value="#{list.partyTime}"/>
                        </h:column>
                    </h:dataTable>
                </td>
            </tr>
        </table>
    </td>
</tr>
</table>
</h:form>
 </c:view>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
        </tr></table>
</marquee>
</body>
<script type="text/javascript">
    interpret(form1);
     function showProcessBar() {
        x = document.body.clientWidth / 2 - 150;
        y = document.body.clientHeight / 2;
        document.all('processbar').style.top = y;
        document.all('processbar').style.left = x;
        document.all('processbar').style.display = "";
    }
</script>
</html>