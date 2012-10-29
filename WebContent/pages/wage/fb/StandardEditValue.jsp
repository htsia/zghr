<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.wage.pojo.vo.WageFBStandardVO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.util.CodeUtil"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.wage.pojo.bo.WageFBStdItemBO"%>
<%@ page import="com.hr319wg.wage.pojo.bo.WageFBStdValueBO"%>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    String act=(String)request.getAttribute("act");

    WageFBStandardVO stdVO = (WageFBStandardVO) session.getAttribute("stdVO");
    ArrayList vItem = stdVO.getV_item();

    ArrayList HCode = stdVO.getHCode();
    Hashtable HColRep = new Hashtable();
    int count = HCode.size();
    int colNum = 1;
    for (int i = 0; i < count; i++) {
        colNum *= ((String[]) HCode.get(i)).length;
        HColRep.put(String.valueOf(i), String.valueOf(colNum));
    }

    ArrayList VCode = stdVO.getVCode();
    Hashtable VRowRep = new Hashtable();
    count = VCode.size();
    int rowNum = 1;
    for (int i = 0; i < count; i++) {
        rowNum *= ((String[]) VCode.get(i)).length;
        VRowRep.put(String.valueOf(i), String.valueOf(rowNum));
    }

%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <style type="text/css">
        <!--
        .td_top {
            background-color: #EDECE2;
            font-family: "Tahoma";
            FONT-SIZE: 11px;
            color: #7C5618;
            padding: 4px;
            border-collapse: collapse;
            border-top: 0px none;
            border-right: 2px solid #FFFFFF;
            border-bottom: 2px solid #FFFFFF;
            border-left: 0px none;
        }

        .td_02 {
            background-color: #F2F2F2;
            font-family: "Tahoma";
            FONT-SIZE: 11px;
            color: #000000;
            padding: 4px;
            border-collapse: collapse;
            border-top: 0px none;
            border-right: 2px solid #FFFFFF;
            border-bottom: 2px solid #FFFFFF;
            border-left: 0px none;
        }

        .input {
            BORDER-RIGHT: 1px solid;
            BORDER-TOP: 1px solid;
            BORDER-LEFT: 1px solid;
            BORDER-BOTTOM: 1px solid;
            COLOR: #000000;
            FONT-SIZE: 11px;
            font-family: "Tahoma";
            HEIGHT: 20px;
            background-color: #F2F2F2
        }

        .td_form02 {
            background-color: #F2F2F2;
            font-family: "Tahoma";
            FONT-SIZE: 11px;
            color: #000000;
            padding: 0px;
            border-collapse: collapse;
            border-top: 0px solid;
            border-right: 2px solid #FFFFFF;
            border-bottom: 2px solid #FFFFFF;
            border-left: 0px solid;
        }

        -->
    </style>
</head>

<body>
<x:saveState value="#{wage_fbstandardBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden id="unitId" value="#{wage_fbstandardBB.standard.unitId}"/>
<h:inputHidden id="stdId" value="#{wage_fbstandardBB.standard.stdId}"/>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td align="right">
            <%
                if(!"view".equals(act)){
            %>
            <h:commandButton styleClass="button01" value="上一步" action="#{wage_fbstandardBB.step2_setCode}"/>
            <h:commandButton styleClass="button01" value="下一步" action="#{wage_fbstandardBB.step4_setName}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <%
                }
            %>
            <h:commandButton styleClass="button01" value="取消返回" action="#{wage_fbstandardBB.list}"/></td>
    </tr>
</table>
<br>

<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
    <%
        if (vItem.size() > 0) {
    %>
    <td class="td_top">&nbsp;</td>
    <%
        }
    %>
    <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="center" class="td_top" colspan=<%=colNum%>><h:outputText
                        value="#{wage_fbstandardBB.standard.name}"/></td>
            </tr>
            <%
                if (HCode.size() > 0) {
                    int rows = HCode.size();
                    for (int i = 0; i < rows; i++) {
                        String[] codeItem = (String[]) HCode.get(i);
                        int items = codeItem.length;
                        int cols = Integer.parseInt((String) HColRep.get(String.valueOf(i)));
            %>
            <tr>
                <%
                    for (int r = 0; r < cols / items; r++) {
                        for (int j = 0; j < items; j++) {
                %>
                <td align="center" class="td_top" colspan="<%=colNum/cols%>" width="<%=100/cols%>%">
                    <%=CodeUtil.interpertCode(null, codeItem[j])%>
                </td>
                <%
                        }
                    }
                %>
            </tr>
            <%
                    }
                }
            %>

        </table>
    </td>
</tr>

<tr>
    <%
        if (vItem.size() > 0) {
    %>
    <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <%
                    int v_col = VCode.size();
                    for (int i = 0; i < v_col; i++) {
                %>
                <td height="100%">
                    <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
                        <%
                            String[]codeItem = (String[]) VCode.get(i);
                            int rows = Integer.parseInt((String) VRowRep.get(String.valueOf(i)));
                            int items = codeItem.length;
                            for (int j = 0; j < rows / items; j++) {
                                for (int k = 0; k < items; k++) {

                        %>
                        <tr>
                            <td align="center" class="td_top" nowrap>
                                <%=CodeUtil.interpertCode(null, codeItem[k])%>
                            </td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </table>
                </td>
                <%
                    }
                %>
            </tr>
        </table>
    </td>
    <%}%>

    <td valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <%
                ArrayList HColName = stdVO.getHColName();
                ArrayList VRowName = stdVO.getVRowName();
                Hashtable rsValue= stdVO.getRs_value();

                for (int i = 0; i < rowNum; i++) {
            %>
            <tr>
                <%
                    for (int j = 0; j < colNum; j++) {
                        String hcol_name = HColName!=null&&HColName.size()>j?(String) HColName.get(j):"";
                        String vrow_name = VRowName!=null&&VRowName.size()>i?(String) VRowName.get(i):"";
                        String name=hcol_name+"|"+vrow_name;
                        String value="";
                        WageFBStdValueBO stdValue=(WageFBStdValueBO)rsValue.get(name);
                        if(stdValue!=null){
                            value=CommonFuns.filterNull(stdValue.getCellValue());
                        }

                %>
                <td align="center" width="<%=100/colNum%>%"  class="<%="view".equals(act)?"td_02":"td_form02" %>" height="100%">
                    <%
                        if(!"view".equals(act)){
                    %>
                    <input type="text" size="10" alt="标准表单元值|1|f" value="<%=value%>" class="input" name="<%=name%>">
                    <%
                        }else{
                            out.println(value);
                        }
                    %>
                </td>
                <%
                    }
                %>
            </tr>
            <%
                }
            %>
        </table>
    </td>
</tr>
</table>
</h:form>
</body>
</html>