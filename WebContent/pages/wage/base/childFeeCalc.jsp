<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
     function doCheck(){
         if (document.all('form1:baseTime').value==''){
             alert("请选择基准时间！");
             return false;
         }
         disPlayProcessBar();
         return true;
     }
</script>


<x:saveState value="#{wage_childFeeBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_childFeeBB.pageInit}"/>

    <c:verbatim>
    <table width=98% height=98% border=0 align="center">
    <tr><td height=8px>
    </c:verbatim>
        <h:outputText escape="false" value="<strong>单位：</strong>#{wage_childFeeBB.unitName}"/>
    <c:verbatim></td><td align="right"></c:verbatim>
        <h:inputText id="baseTime" readonly="true" value="#{wage_childFeeBB.baseTime}"></h:inputText>
        <h:commandButton styleClass="button_date" type="button" onclick="PopUpCalendarDialog('form1:baseTime')"></h:commandButton>
        <h:commandButton value="计算" styleClass="button01" onclick="return doCheck();" action="#{wage_childFeeBB.calc}"></h:commandButton>
    <c:verbatim>
        </td>
    </tr>
    <tr><td colspan="2" align="left" valign="top" height="30">
     </c:verbatim>
        <h:outputText value="记录数:#{wage_childFeeBB.page.totalRecord}"></h:outputText>
        <h:outputText value="  "></h:outputText>
        <h:outputText value="页数:#{wage_childFeeBB.page.totalPage}"></h:outputText>
        <h:outputText value="  "></h:outputText>
        <h:outputText value="每页有#{wage_childFeeBB.page.pageSize}"></h:outputText>
        <h:outputText value="  "></h:outputText>
        <h:outputText value="当前为第#{wage_childFeeBB.page.currentPage}页"></h:outputText>
        <h:commandButton value="首页" action="#{wage_childFeeBB.first}" styleClass="button01"></h:commandButton>
        <h:commandButton value="上页" action="#{wage_childFeeBB.pre}" styleClass="button01"></h:commandButton>
        <h:commandButton value="下页" action="#{wage_childFeeBB.next}" styleClass="button01"></h:commandButton>
        <h:commandButton value="尾页" action="#{wage_childFeeBB.last}" styleClass="button01"></h:commandButton>
    <c:verbatim>
    </td></tr>

    <tr><td valign="top" colspan="2">
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
     </c:verbatim>
            <h:dataTable value="#{wage_childFeeBB.feeList}" var="list" align="center"  id="dateList"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >
            <h:column>
                <c:facet name="header"><h:outputText value="员工姓名"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="子女姓名"/></c:facet>
                <h:outputText value="#{list.childName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="子女性别"/></c:facet>
                <h:outputText value="#{list.childSex}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="子女生日"/></c:facet>
                <h:outputText value="#{list.childBirthday}"/>
            </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="独生子女费"/></c:facet>
                    <h:outputText value="#{list.fee}"/>
                </h:column>

        </h:dataTable>
<c:verbatim>
        </div>
    </td></tr>
    </table>
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
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
        </tr>
    </table>
</marquee>
