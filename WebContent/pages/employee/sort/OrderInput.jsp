<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.wage.ucc.impl.WageSetPersonUCC"%>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String perstr=request.getParameter("perids");
    String[] persId=null;
    if (perstr==null){  //点按姓名排序的回发
        persId=(String[])session.getAttribute("persId");
    }
    else{
        persId =  perstr.split(",");
        session.setAttribute("persId",persId); // 选择的人员
    }

    String[]  field=new String[1];
    field[0]="A001003";        // 人员排序号
    session.setAttribute("field",field);
    HashMap rs=null;
    try{
        WageSetPersonUCC wagesetpersonucc=(WageSetPersonUCC)SysContext.getBean("wage_SetPersonUccImpl");
        rs = wagesetpersonucc.queryPersonOrder(persId, field);
    }
    catch(Exception e){
    }
%>
<html>
<head>
    <base target="_self">
    <title></title>
</head>

<body>
<x:saveState value="#{wage_OrderInputBB}"/>
<h:inputHidden value="#{wage_OrderInputBB.pageInit}"></h:inputHidden>

<h:form id="form1">
    <h:panelGrid align="center" columns="3" width="95%" >
        <f:verbatim>
          <%=LanguageSupport.getResource( "RYGL-2432", "修改人员排序信息,默认排序是人员入库顺序")%>
        </f:verbatim>
        <h:panelGroup>
            <h:selectBooleanCheckbox onclick="submit()" id="orderByName" valueChangeListener="#{wage_OrderInputBB.changeOrder}"></h:selectBooleanCheckbox>
             <f:verbatim>
          <%=LanguageSupport.getResource( "RYGL-2433", "按姓名排序")%>
        </f:verbatim>
        </h:panelGroup>
        <h:panelGrid align="center" columns="3" width="15%">
            <h:commandButton styleClass="button01" value="确认" action="#{wage_OrderInputBB.savePersonAllSort}"   />
            <h:commandButton styleClass="button01" type="button" value="关闭" onclick="window.close()"/>
        </h:panelGrid>
    </h:panelGrid>

    <c:verbatim escape="false">
     <br>
     <br>
        <%
            if (persId != null && field != null) {
                int col = field.length;
                int row = persId.length;
        %>
        <table width="95%" align="center" cellpadding="2" cellspacing="0" class="table03">
            <tr>
                <td colspan="<%=col+3%>" nowrap class="td_top"> <%=LanguageSupport.getResource( "RYGL-2434", "已选择人员列表")%>&nbsp&nbsp<%=LanguageSupport.getResource( "RYGL-2435", "共有")%> <%out.print(row);%><%=LanguageSupport.getResource( "RYGL-2436", "人")%></td>
            </tr>

            <tr>
                <td nowrap class="td_top"><%=LanguageSupport.getResource( "XTGL-1042", "员工编号")%></td>
                <td nowrap class="td_top"><%=LanguageSupport.getResource( "MSG-0010", "姓名")%></td>
                <td nowrap class="td_top"><%=LanguageSupport.getResource( "XTGL-1045", "所在部门")%></td>
                <%
                    for (int j = 0; j < col; j++) {
                        out.println("<td class=td_top>" + CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM, field[j]) + "</td>");
                    }
                %>
            </tr>
            <%
                for (int i = 0; i < row; i++) {
                    out.println("<tr>");
                    PersonBO pb=SysCacheTool.findPersonById(persId[i]);
                    for (int j = -1; j < col; j++) {
                        if (j == -1) {
                            out.println("<td class=td_top>" + pb.getPersonCode() + "</td>");
                            out.println("<td class=td_top>" + pb.getName()+ "</td>");
                            out.println("<td class=td_top>" + CodeUtil.interpertCode(CodeUtil.TYPE_ORG,pb.getDeptId()) + "</td>");
                        } else {
                            String fldname = persId[i] + "|" + field[j];
                            InfoItemBO item = SysCacheTool.findInfoItem("A001", field[j]);
                            if (InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType())) {
                                String value = CommonFuns.filterNullToZero((String) rs.get(fldname));
                                out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + value + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|s'></td>");
                            } else {
                                String value = CommonFuns.filterNullToZero((String) rs.get(fldname));
                                out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + value + "' class='input' size=10 maxlenght=20 style=\"behavior:url('../../js/mytextbox.htc');\" alt='输入值|0|f'></td>");
                            }
                        }
                    }
                    out.println("</tr>");
                }
            %>
        </table>
        <%
            }
        %>
    </c:verbatim>
</h:form>
</body>
</html>