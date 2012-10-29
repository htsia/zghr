<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.lead.pojo.bo.GridResultBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>

<script type="text/javascript">
    function forAdd() {
        window.showModalDialog("/lead/LeadSQLEdit.jsf?resId="+document.all("form1:resId").value, null, "dialogWidth:430px; dialogHeight:320px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
    function forModify(ID) {
        window.showModalDialog("/lead/LeadSQLEdit.jsf?resId="+document.all("form1:resId").value+"&sqlID="+ID, null, "dialogWidth:430px; dialogHeight:320px;center:center;resizable:no;status:no;scroll:no;");
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
	<h:inputHidden id="init" value="#{gridget.pageInit}"></h:inputHidden>
    <h:inputHidden value="#{gridget.orgId}"></h:inputHidden>
    <h:inputHidden id="resId" value="#{gridget.resId}"></h:inputHidden>
    <c:verbatim><br></c:verbatim>
	<h:panelGrid width="98%"  border="0"  cellpadding="2" cellspacing="0" columns="1" >
	   <h:panelGroup>
           <h:outputText value ="名称:#{gridget.showname}"/>
           <h:outputText value ="    "/>
           <h:outputText value ="选择日期:"/>
           <h:selectOneMenu value="#{gridget.selectDate}">
              <c:selectItems  value="#{gridget.dateList}"></c:selectItems>
           </h:selectOneMenu>
           <h:commandButton value="查看" styleClass="button01" action="#{gridget.queryGridResult}"></h:commandButton>
       </h:panelGroup>
     </h:panelGrid>

     <c:verbatim><br><br></c:verbatim>
     <h:inputHidden value="#{gridget.showList[0]}"></h:inputHidden>

     <c:verbatim><table id="form1:dateList" align="center" class="table03"></c:verbatim>
     <%
         int count = Integer.parseInt(session.getAttribute("count").toString());
         List gridInfo = (List) session.getAttribute("gridInfo");
         if (gridInfo!=null){
         for (int i = 0; i < gridInfo.size(); i++) {
             GridResultBO row=(GridResultBO)gridInfo.get(i);
     %>
         <c:verbatim><tr>
     <%
         // ...代表延续上列
         String outstring="";
         int colspan=1;
         String value="";
         for(int j=0;j<count;j++){
             if (j==0){
                 value=CommonFuns.filterNull(row.getShowInfo1());
             }
             else if (j==1){
                 value=CommonFuns.filterNull(row.getShowInfo2());
             }
             else if (j==2){
                 value=CommonFuns.filterNull(row.getShowInfo3());
             }
             else if (j==3){
                 value=CommonFuns.filterNull(row.getShowInfo4());
             }
             else if (j==4){
                 value=CommonFuns.filterNull(row.getShowInfo5());
             }
             else if (j==5){
                 value=CommonFuns.filterNull(row.getShowInfo6());
             }
             else if (j==6){
                 value=CommonFuns.filterNull(row.getShowInfo7());
             }
             else if (j==7){
                 value=CommonFuns.filterNull(row.getShowInfo8());
             }
             else if (j==8){
                 value=CommonFuns.filterNull(row.getShowInfo9());
             }
             else if (j==9){
                 value=CommonFuns.filterNull(row.getShowInfo10());
             }
             else if (j==10){
                 value=CommonFuns.filterNull(row.getShowInfo11());
             }
             else if (j==11){
                 value=CommonFuns.filterNull(row.getShowInfo12());
             }
             else if (j==12){
                 value=CommonFuns.filterNull(row.getShowInfo13());
             }
             else if (j==13){
                 value=CommonFuns.filterNull(row.getShowInfo14());
             }
             else if (j==14){
                 value=CommonFuns.filterNull(row.getShowInfo15());
             }
             else if (j==15){
                 value=CommonFuns.filterNull(row.getShowInfo16());
             }
             else if (j==16){
                 value=CommonFuns.filterNull(row.getShowInfo17());
             }
             else if (j==17){
                 value=CommonFuns.filterNull(row.getShowInfo18());
             }
             else if (j==18){
                 value=CommonFuns.filterNull(row.getShowInfo19());
             }
             else if (j==19){
                 value=CommonFuns.filterNull(row.getShowInfo20());
             }
             if ("...".equals(value)){
                colspan++;
             }
             else{
               outstring=outstring.replaceAll("DDDDDDDD","colspan="+String.valueOf(colspan));
               colspan=1;
               outstring+=("<td class='td_middle_center' DDDDDDDD>" + value + "</td>");
             }
         }
         if ("...".equals(value)){
             outstring=outstring.replaceAll("DDDDDDDD","colspan="+String.valueOf(colspan));
         }

         out.println(outstring);
     %>
         </tr></c:verbatim>
     <%
         }
         } 
     %>
     <c:verbatim></table></c:verbatim>


    </h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
