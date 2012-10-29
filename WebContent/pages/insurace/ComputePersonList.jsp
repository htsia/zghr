<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
    function showdiff(){
        var url="/wage/payoff/ShowDiff.jsf?module=BXGL&unitId="+form1.all("form1:unitId").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
        window.open(url,'','toolbar=0,height=500,width='+screen.width*0.9+',top=40,left='+screen.width*0.05);
        return false;
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
        function forSelectInput() {
            if (checkMutilSelect(form1.chk)) {
                count = form1.chk.length;
                var str = "";
                if (count != null) {
                    var num = 0;
                    for (i = 0; i < count; i++)
                        if (form1.chk[i].checked) {
                            str += form1.chk[i].value + ",";
                            num++;
                        }
                    if (num > 100) {
                        alert("最多只能选择100个人员");
                        return false;
                    }
                } else
                    str = form1.chk.value;

                var setName = form1.all("form1:setName").value;
                var unitId = form1.all("form1:unitId").value;
                var setId = form1.all("form1:setId").value;
                var arg = "act=selectSetInput" + "&setName=" + setName + "&unitId=" + unitId + "&setId=" + setId + "&str=" + str;
                reval = window.showModalDialog("/wage/set/SetInputSelect.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
                if (reval != null) {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert("请选择人员");
                return false;
            }
        }

        function forOrderInput() {
            if (checkMutilSelect(form1.chk)) {
                count = form1.chk.length;
                var str = "";
                if (count != null) {
                    var num = 0;
                    for (i = 0; i < count; i++)
                        if (form1.chk[i].checked) {
                            str += form1.chk[i].value + ",";
                            num++;
                        }
                    if (num > 100) {
                        alert("最多只能选择100个人员");
                        return false;
                    }
                } else
                    str = form1.chk.value;
                reval = window.showModalDialog("/wage/set/OrderInput.jsf?PerStr=" + str, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
                if (reval != null) {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert("请选择人员");
                return false;
            }
        }

        function forUploadFile() {
            var setName = form1.all("form1:setName").value;
            var unitId = form1.all("form1:unitId").value;
            var setId = form1.all("form1:setId").value;
            var arg = "act=selectSetInput" + "&setName=" + setName + "&unitId=" + unitId + "&setId=" + setId;
            reval = window.showModalDialog("/wage/set/SetInputUpload.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            if (reval != null) {
                return true;
            } else {
                return false;
            }
        }
        function forCheckSelect() {
            if (checkMutilSelect(form1.chk)) {
                showProcessBar();
                return true;
            } else {
                alert("请选择人员");
                return false;
            }
        }
        function refreshList() {
             showProcessBar();
            return true;
        }
        function showSum(){
            var url="/wage/payoff/ShowSumInfo.jsf?unitId="+form1.all("form1:unitId").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
            window.open(url,'','toolbar=0,height=460,width=800,top=40,left=40');
            return false;
        }
    </script>

<x:saveState value="#{ins_computelistBB}"/>
<x:saveState value="#{wage_dateBB}"/>

<h:form id="form1">
    <h:inputHidden value="#{ins_computelistBB.pageInit}"/>
    <h:inputHidden id="deptpower" value="#{wage_computeBB.deptpower}"/>
    <h:inputHidden id="setId" value="#{ins_computelistBB.setId}"/>
    <h:inputHidden id="unitId" value="#{ins_computelistBB.unitId}"/>
    <h:inputHidden id="setName" value="#{ins_computelistBB.setName}"/>
    <h:inputHidden id="dateId" value="#{ins_computelistBB.dateId}"/>
    <h:inputHidden id="str" value=""/>
    <c:verbatim>
    <table width=100% height=98% border=0 >
    <tr><td height=8px>
</c:verbatim>
    <h:panelGrid columns="2" align="center" width="95%" >
       <h:panelGroup>
            <h:outputText escape="false" value="<strong>发薪单位：</strong>#{ins_computelistBB.unitName}"/>
            <h:outputText value="   "></h:outputText>
            <h:outputText escape="false" value="<strong>账套：</strong>#{ins_computelistBB.setName}"/>
            <h:outputText value="   "></h:outputText>
            <h:outputText value="#{ins_computelistBB.payoffDate}"></h:outputText>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="11" align="center" width="95%" >
        <h:panelGroup>
            <h:selectOneMenu id="ReportID" style="width:150px">
                <c:selectItems value="#{ins_computelistBB.bxreportList}"/>
            </h:selectOneMenu>
            <h:commandButton value="显示" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
        </h:panelGroup>

        <h:panelGroup>
            <h:outputText value="姓名或员工编号:"/>
            <h:inputText value="" id="nameStr"/>
            <h:commandButton value="查询" action="#{ins_computelistBB.queryPersonByNameStr}" styleClass="button01"/>
            <h:commandButton value="自定义查询" styleClass="button01"
                             action="#{ins_computelistBB.queryAdvance}"
                             onclick="return doAdvanceQuery('A','ORG','011','Y','','','N','152','N')"/>
        </h:panelGroup>

        <h:panelGroup>
                       <h:selectOneMenu id="groupLevel" value="#{ins_computelistBB.groupLevel}">
                           <c:selectItem itemValue="DEPT_NAME" itemLabel="最细层次"></c:selectItem>
                           <c:selectItem itemValue="HIGH_NAME" itemLabel="汇总1"></c:selectItem>
                           <c:selectItem itemValue="HIGH_NAME2" itemLabel="汇总2"></c:selectItem>
                           <c:selectItem itemValue="HIGH_NAME3" itemLabel="汇总3"></c:selectItem>
                           <c:selectItem itemValue="HIGH_NAME4" itemLabel="汇总4"></c:selectItem>
                       </h:selectOneMenu>
                       <h:commandButton value="选择" styleClass="button01" action="#{ins_computelistBB.changeLevel}"></h:commandButton>
                       <h:selectOneMenu id="WageDept"  value="#{ins_computelistBB.dept}">
                          <c:selectItems value="#{ins_computelistBB.deptList}"></c:selectItems>
                       </h:selectOneMenu>
                       <h:commandButton styleClass="button01"value="过滤" action="#{ins_computelistBB.queryPersonByDept}"></h:commandButton>
        </h:panelGroup>

        <h:panelGrid columns="1" align="right" cellspacing="2" >
            <h:panelGroup>
                <h:commandButton value="对比"  styleClass="button01" type="button"
                                  onclick="showdiff();return false;"/>

                <h:commandButton value="导出Excel" type="button" onclick="forExport();" styleClass="button01"/>
                <h:commandButton value="返回" action="#{wage_dateBB.dateList}" styleClass="button01">
                    <x:updateActionListener property="#{wage_dateBB.setId}" value="#{ins_computelistBB.setId}"/>
                    <x:updateActionListener property="#{wage_dateBB.setName}" value="#{ins_computelistBB.setName}"/>
                    <x:updateActionListener property="#{wage_dateBB.unitId}" value="#{ins_computelistBB.unitId}"/>
                    <x:updateActionListener property="#{wage_dateBB.unitName}" value="#{ins_computelistBB.unitName}"/>
                </h:commandButton>
            </h:panelGroup>
        </h:panelGrid>
    </h:panelGrid>
<c:verbatim>
    </td>
    </tr>

    <tr><td>
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

<script type="text/javascript">
     function showProcessBar() {
        x = document.body.clientWidth / 2 - 150;
        y = document.body.clientHeight / 2;
        document.all('processbar').style.top = y;
        document.all('processbar').style.left = x;
        document.all('processbar').style.display = "";
    }
</script>
