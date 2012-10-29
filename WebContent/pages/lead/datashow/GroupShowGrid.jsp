<%@ page import="com.hr319wg.lead.pojo.bo.GridResultBO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>

<script type="text/javascript">
    function showDetail(index) {
        window.showModalDialog("/lead/GroupShowDetail.jsf?resID="+document.all('form1:resId').value+"&index="+index, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
</script>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{gridget}"/>
    <h:form id="form1">
	<h:inputHidden id="init" value="#{gridget.initGroupShow}"></h:inputHidden>
    <h:inputHidden value="#{gridget.orgId}"></h:inputHidden>
    <h:inputHidden id="resId" value="#{gridget.resId}"></h:inputHidden>
    <c:verbatim>
        <table width="100%" height="98%" align="center" cellspacing="0" cellpadding="0">
        <tr><td height=8>
    </c:verbatim>
	<h:panelGrid width="98%"  border="0"  cellpadding="2" cellspacing="0" columns="1" >
	   <h:panelGroup>
           <h:outputText escape="fase" value ="<strong>名称:</strong>#{gridget.showname}"/>
           <h:outputText value ="    "/>
           <h:outputText value ="选择日期:"/>
           <h:selectOneMenu value="#{gridget.selectDate}">
              <c:selectItems  value="#{gridget.dateList}"></c:selectItems>
           </h:selectOneMenu>
           <h:commandButton value="查看" styleClass="button01" action="#{gridget.groupQueryGridResult}"></h:commandButton>
       </h:panelGroup>
     </h:panelGrid>
     <c:verbatim>
     </td></tr>

      <tr><td height=8></td></tr>
     </c:verbatim>

    <h:inputHidden value="#{gridget.showList[0]}"></h:inputHidden>

    <c:verbatim>
     <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
        <table id="form1:dateList" align="center" class="table03">
    </c:verbatim>
     <%
         int count = Integer.parseInt(session.getAttribute("count").toString());
         List gridInfo = (List) session.getAttribute("gridInfo");
         if (gridInfo != null) {
             for (int i = 0; i < gridInfo.size(); i++) {
                 GridResultBO row = (GridResultBO) gridInfo.get(i);
     %>
         <c:verbatim><tr>
     <%
         // ...代表延续上列
         String outstring = "";
         if ("合计".equals(row.getOrgName()) || "单位".equals(row.getOrgName())){
             outstring ="<td class='td_middle_center' nowrap><Strong>" + CommonFuns.filterNull(row.getOrgName()) + "<Strong></td>";
         }
         else{
            outstring ="<td class='td_middle_center' nowrap><A target='_BLANK' href='/lead/GroupShowGridRow.jsf?OrgId="+row.getOrgId()+"'>" + CommonFuns.filterNull(row.getOrgName()) + "</A></td>";
         }
         int colspan = 1;
         String value = "";
         for (int j = 0; j < count; j++) {
             if (j == 0) {
                 value = CommonFuns.filterNull(row.getShowInfo1());
             } else if (j == 1) {
                 value = CommonFuns.filterNull(row.getShowInfo2());
             } else if (j == 2) {
                 value = CommonFuns.filterNull(row.getShowInfo3());
             } else if (j == 3) {
                 value = CommonFuns.filterNull(row.getShowInfo4());
             } else if (j == 4) {
                 value = CommonFuns.filterNull(row.getShowInfo5());
             } else if (j == 5) {
                 value = CommonFuns.filterNull(row.getShowInfo6());
             } else if (j == 6) {
                 value = CommonFuns.filterNull(row.getShowInfo7());
             } else if (j == 7) {
                 value = CommonFuns.filterNull(row.getShowInfo8());
             } else if (j == 8) {
                 value = CommonFuns.filterNull(row.getShowInfo9());
             } else if (j == 9) {
                 value = CommonFuns.filterNull(row.getShowInfo10());
             } else if (j == 10) {
                 value = CommonFuns.filterNull(row.getShowInfo11());
             } else if (j == 11) {
                 value = CommonFuns.filterNull(row.getShowInfo12());
             } else if (j == 12) {
                 value = CommonFuns.filterNull(row.getShowInfo13());
             } else if (j == 13) {
                 value = CommonFuns.filterNull(row.getShowInfo14());
             } else if (j == 14) {
                 value = CommonFuns.filterNull(row.getShowInfo15());
             } else if (j == 15) {
                 value = CommonFuns.filterNull(row.getShowInfo16());
             } else if (j == 16) {
                 value = CommonFuns.filterNull(row.getShowInfo17());
             } else if (j == 17) {
                 value = CommonFuns.filterNull(row.getShowInfo18());
             } else if (j == 18) {
                 value = CommonFuns.filterNull(row.getShowInfo19());
             } else if (j == 19) {
                 value = CommonFuns.filterNull(row.getShowInfo20());
             } else if (j == 20) {
                 value = CommonFuns.filterNull(row.getShowInfo21());
             } else if (j == 21) {
                 value = CommonFuns.filterNull(row.getShowInfo22());
             } else if (j == 22) {
                 value = CommonFuns.filterNull(row.getShowInfo23());
             } else if (j == 23) {
                 value = CommonFuns.filterNull(row.getShowInfo24());
             } else if (j == 24) {
                 value = CommonFuns.filterNull(row.getShowInfo25());
             } else if (j == 25) {
                 value = CommonFuns.filterNull(row.getShowInfo26());
             } else if (j == 26) {
                 value = CommonFuns.filterNull(row.getShowInfo27());
             } else if (j == 27) {
                 value = CommonFuns.filterNull(row.getShowInfo28());
             } else if (j == 28) {
                 value = CommonFuns.filterNull(row.getShowInfo29());
             } else if (j == 29) {
                 value = CommonFuns.filterNull(row.getShowInfo30());
             } else if (j == 30) {
                 value = CommonFuns.filterNull(row.getShowInfo31());
             } else if (j == 31) {
                 value = CommonFuns.filterNull(row.getShowInfo32());
             } else if (j == 32) {
                 value = CommonFuns.filterNull(row.getShowInfo33());
             } else if (j == 33) {
                 value = CommonFuns.filterNull(row.getShowInfo34());
             } else if (j == 34) {
                 value = CommonFuns.filterNull(row.getShowInfo35());
             } else if (j == 35) {
                 value = CommonFuns.filterNull(row.getShowInfo36());
             } else if (j == 36) {
                 value = CommonFuns.filterNull(row.getShowInfo37());
             } else if (j == 37) {
                 value = CommonFuns.filterNull(row.getShowInfo38());
             } else if (j == 38) {
                 value = CommonFuns.filterNull(row.getShowInfo39());
             } else if (j == 39) {
                 value = CommonFuns.filterNull(row.getShowInfo40());
             }

             if ("...".equals(value)) {
                 colspan++;
             } else {
                 outstring = outstring.replaceAll("DDDDDDDD", "colspan=" + String.valueOf(colspan));
                 colspan = 1;
                 if (i==0){
                      outstring += ("<td class='td_middle_center' nowrap DDDDDDDD><A target='_BLANK' href='/pages/lead/datashow/GroupShowGridCol.jsp?Col="+j+"'>" + value + "</A></td>");
                 }
                 else{
                    outstring += ("<td class='td_middle_center' nowrap DDDDDDDD>" + value + "</td>");
                 }
             }
         }
         if ("...".equals(value)) {
             outstring = outstring.replaceAll("DDDDDDDD", "colspan=" + String.valueOf(colspan));
         }

         out.println(outstring);
     %>
         </tr></c:verbatim>
     <%
         }
         }
     %>
     <c:verbatim>
     </table>
     </div>
     </td>
     </tr>
     </table>
     </c:verbatim>

    </h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
