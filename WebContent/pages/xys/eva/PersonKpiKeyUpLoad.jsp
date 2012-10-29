<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
        function showProcessBar() {
    	    x = document.body.clientWidth / 2 - 150;
    	    y = document.body.clientHeight / 2;
    	    document.all('processbar').style.top = y;
    	    document.all('processbar').style.left = x;
    	    document.all('processbar').style.display = "";
    	 }
</script>
<x:saveState value="#{xys_KpiPersonSetBB}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:inputHidden id="initUpload" value="#{xys_KpiPersonSetBB.initUpload}"></h:inputHidden>
    <h:inputHidden id="planId" value="#{xys_KpiPersonSetBB.planId}"></h:inputHidden>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">

            <h:outputText value="附件"></h:outputText>
             <h:panelGroup>
              	    <x:inputFileUpload styleClass="input" id="excelFile" value="#{xys_KpiPersonSetBB.excelFile}"  storage="file" size="25" />
 					<h:commandButton value="上传"  styleClass="button01" action="#{xys_KpiPersonSetBB.uploadFile}" onclick="showProcessBar();"/>
 					<h:outputText value="(.xls文件)"></h:outputText>
              </h:panelGroup>

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
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
</h:form>
