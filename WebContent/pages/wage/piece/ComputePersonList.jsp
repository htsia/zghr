<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
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

        function forExport() {
          window.open('/pages/common/ExportToExcel.jsp');
        }

        function OpenRpt(){
            if (document.all("form1:ReportID").value=="-1"){
                alert("请先选择表格样式！");
                return false;
            }
            var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID=&ORGUID="+document.all("form1:unitId").value+"&Parameter="+document.all("form1:setId").value
                     +"&Title="+document.all("form1:setId").value+"_"+document.all("form1:dateId").value+"_"+document.all("form1:ReportID").value;
            window.open(url);
            return false;
        }

        function refreshList() {
             showProcessBar();
            return true;
        }
        function inputPiece(){
            var url="/wage/piece/addPiece.jsf?unitId="+form1.all("form1:unitId").value+"&unitName="+form1.all("form1:unitName").value+"&setName="+form1.all("form1:setName").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
            window.showModalDialog(url, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function batchInputPiece(){
            var url="/wage/piece/Selectperson.jsf?unitId="+form1.all("form1:unitId").value+"&unitName="+form1.all("form1:unitName").value+"&setName="+form1.all("form1:setName").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
            var reval=window.showModalDialog(url, null, "dialogWidth:650px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function showSum(){
            var url="/wage/piece/ShowSumInfo.jsf?unitId="+form1.all("form1:unitId").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
            window.open(url,'','toolbar=0,height=460,width=800,top=40,left=40');
            return false;
        }
        function showOrgSum(){
            var url="/wage/piece/ShowOrgSumInfo.jsf?unitId="+form1.all("form1:unitId").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
            window.open(url,'','toolbar=0,height=460,width=800,top=40,left=40');
            return false;
        }

    </script>

<x:saveState value="#{wage_computeBB}"/>
<x:saveState value="#{wage_dateBB}"/>
<h:inputHidden value="#{wage_computeBB.pageInit}"/>
<h:form id="form1">
    <h:inputHidden id="setId" value="#{wage_computeBB.setId}"/>
    <h:inputHidden id="unitId" value="#{wage_computeBB.unitId}"/>
    <h:inputHidden id="unitName" value="#{wage_computeBB.unitName}"/>
    <h:inputHidden id="setName" value="#{wage_computeBB.setName}"/>
    <h:inputHidden id="dateId" value="#{wage_computeBB.dateId}"/>
    <h:inputHidden id="str" value=""/>

    <c:verbatim>
        <table height=98% width=98% align="center">
        <tr><td height=8>
    </c:verbatim>
    <h:panelGrid columns="5" align="center" width="95%" >
        <h:panelGroup>
            <h:outputText value="发薪单位：#{wage_computeBB.unitName}"/>
            <c:verbatim>&nbsp;&nbsp;&nbsp;</c:verbatim>
            <h:outputText value="账套：#{wage_computeBB.setName}"/>
        </h:panelGroup>

        <h:panelGrid columns="6" align="right" >
            <h:outputText value="姓名或员工编号:"/>
            <h:inputText value="" id="nameStr"/>
            <h:commandButton value="查询" action="#{wage_computeBB.queryPieceByNameStr}" styleClass="button01"/>
            <h:outputText value="部门过滤" />
            <h:selectOneMenu onchange="submit()" value="#{wage_computeBB.dept}" valueChangeListener="#{wage_computeBB.changePieceDept}">
               <c:selectItems value="#{wage_computeBB.deptList}"></c:selectItems>
            </h:selectOneMenu>
        </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
     </td></tr>

     <tr><td height=8>
    </c:verbatim>

    <h:panelGrid columns="12" align="center" width="95%" >
            <h:panelGroup>
                <h:selectOneMenu id="ReportID" style="width:150px">
                    <c:selectItems value="#{wage_computeBB.bxreportList}"/>
                </h:selectOneMenu>
                <h:commandButton value="显示" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
            </h:panelGroup>

            <h:panelGroup>
                <h:commandButton value="逐条录入数据" styleClass="button01" rendered="#{wage_computeBB.operCompute}"
                             action="#{wage_computeBB.turnPageQuery}"
                             onclick="return inputPiece()"/>
                <h:commandButton value="批量录入数据" styleClass="button01" rendered="#{wage_computeBB.operCompute}"
                             action="#{wage_computeBB.turnPageQuery}"
                             onclick="return batchInputPiece()"/>
            </h:panelGroup>

            <h:panelGroup>
                <h:commandButton value="汇总计算" styleClass="button01" action="#{wage_computeBB.gatherPiece}"></h:commandButton>
                <h:commandButton value="查看个人汇总信息" rendered="#{wage_computeBB.operCompute}" styleClass="button01"
                              onclick="showSum();return false;"/>
                <h:commandButton value="查看部门汇总信息" rendered="#{wage_computeBB.operCompute}" styleClass="button01"
                              onclick="showOrgSum();return false;"/>
            </h:panelGroup>
            <h:commandButton value="导出Excel" type="button" onclick="forExport();" styleClass="button01"/>
    </h:panelGrid>

    <c:verbatim>
     </td></tr>
     <tr><td height>
    <jsp:include page="/pages/common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="false"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="false"/>
        <jsp:param name="keyName" value="ID"/>
        <jsp:param name="fixcol" value="4"/> 
    </jsp:include>
    </td></tr>
    </table>
    </c:verbatim>
</h:form>
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

