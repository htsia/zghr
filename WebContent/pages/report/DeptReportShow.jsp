<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script language="javascript" src="<%=request.getContextPath()%>/js/selectitem.js"></script>
<script language="javascript">
    function closeProcessBar() {
       document.all('processbar').style.display = "none";
    }
    function showProcessBar() {
       x = document.body.clientWidth / 2 - 150;
       y = document.body.clientHeight / 2;
       document.all('processbar').style.top = y;
       document.all('processbar').style.left = x;
       document.all('processbar').style.display = "";
    }

    function doCheck2(){
        if (document.all("form1:reportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }
        return disPlayProcessBar();
    }

    function doCheck(){
        if (document.all("form1:reportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }
        var flag=0;
        var obj=document.all("form1:dept");
        for (j = 0; j < obj.options.length; j++) { // 循环打印
            if (obj.options[j].selected) {
                flag=1;
                break;
            }
        }
        if (flag==0){
            alert("请先选择部门！");
            return false;
        }
        return disPlayProcessBar();
    }
    function doPrint(){
        var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID=&ORGUID="+document.all("form1:unitId").value+"&Parameter="+document.all("form1:setId").value
                 +"&Title="+document.all("form1:setId").value+"_"+document.all("form1:dateId").value+"_"+document.all("form1:ReportID").value;
         window.open(url);
         document.all('form1:print').style.display='none';
         document.all('form1:printPerson').style.display='none';
         return false;
     }

    function doAllPrint(){
        var str="";
        var obj=document.all("form1:dept");
        for (j = 0; j < obj.options.length; j++) { // 循环打印
            if (obj.options[j].selected) {
                if (str=="") str=obj.options[j].value;
                else str+=","+obj.options[j].value;
            }
        }
        var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID=&ORGUID="+document.all("form1:unitId").value+"&Parameter="+document.all("form1:setId").value
                 +"&Title="+document.all("form1:setId").value+"_"+document.all("form1:dateId").value+"_"+document.all("form1:ReportID").value;

        showProcessBar();
        window.showModalDialog(url, "", "dialogWidth:300px; dialogHeight:200px;status:0;");
        closeProcessBar();
        return ;
    }
</script>
       <x:saveState value="#{wage_deptPrintBB}"></x:saveState>
   <h:form id="form1">
       <h:inputHidden value="#{wage_deptPrintBB.pageInit}"/>
       <h:inputHidden id="setId" value="#{wage_deptPrintBB.setId}"></h:inputHidden>
       <h:inputHidden id="unitId" value="#{wage_deptPrintBB.unitId}"></h:inputHidden>
       <h:inputHidden id="dateId" value="#{wage_deptPrintBB.dateId}"></h:inputHidden>
       <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
          <h:panelGroup>
           <h:graphicImage value="/images/tips.gif" />
           <h:outputText value=" 按部门打印明细信息 "/>
           </h:panelGroup>
       </h:panelGrid>

       <c:verbatim>
           <table width=98% align="center">
           <tr><td colspan="2">
       </c:verbatim>
           <h:outputText escape="false" value="<strong>发薪单位:</strong>#{wage_deptPrintBB.unitName}"/>
          <c:verbatim>
          </td></tr>

           <tr><td colspan="2">
          </c:verbatim>
               <h:outputText escape="false" value="<strong>账套名称:</strong>#{wage_deptPrintBB.setName}"/>
          <c:verbatim>
          </td></tr>
              
          <tr><td colspan="2">
         </c:verbatim>
              <h:outputText value="按汇总1过滤"></h:outputText>
              <h:selectOneMenu value="#{wage_deptPrintBB.group1}" onchange="disPlayProcessBar();submit();"  valueChangeListener="#{wage_deptPrintBB.changeGroup}">
                  <c:selectItems value="#{wage_deptPrintBB.group1List}"></c:selectItems>
              </h:selectOneMenu>
         <c:verbatim>
         </td></tr>

          <tr><td colspan="2">
          </c:verbatim>
               <h:panelGrid columns="2" width="95%" align="center">
               <h:selectManyMenu id="dept"  value="#{wage_deptPrintBB.selectdeptList}"  style="height:200px">
                   <f:selectItems value="#{wage_deptPrintBB.deptList}"></f:selectItems>
               </h:selectManyMenu>

               <h:panelGrid columns="1">
                   <h:selectOneMenu id="reportID" value="#{wage_deptPrintBB.reportID}">
                       <f:selectItems value="#{wage_deptPrintBB.rptList}"></f:selectItems>
                   </h:selectOneMenu>
                   <c:verbatim>
                   <br>
                   <br>
                   </c:verbatim>
                   <h:commandButton value="选择生成" styleClass="button01" onclick="return doCheck();" action="#{wage_deptPrintBB.doPrintMany}"></h:commandButton>
                   <h:commandButton value="全部生成" styleClass="button01" onclick="return doCheck();" action="#{wage_deptPrintBB.doPrintAll}"></h:commandButton>
                   <h:commandButton value="打印" id="print" styleClass="button01" onclick="doPrint();" type="button" style="display:none"></h:commandButton>
                   <h:commandButton type="button" styleClass="button01" value="返回" onclick="window.close();"></h:commandButton>
               </h:panelGrid>
           </h:panelGrid>
          <c:verbatim>
           </td></tr>

           <tr>
               <td><strong>选择人员：</strong></td>
               <td align="right">
</c:verbatim>
                   <h:inputHidden value="#{wage_deptPrintBB.pids}"></h:inputHidden>
                   <h:commandButton value="生成人员名册"  onclick="return doCheck2();" styleClass="button01" action="#{wage_deptPrintBB.doPrintIDs}" rendered="#{wage_deptPrintBB.names!=''}"></h:commandButton>
                   <h:commandButton value="打印" id="printPerson" styleClass="button01" onclick="doPrint();" type="button" style="display:none"></h:commandButton>
<c:verbatim>
               </td>
           </tr>
           <tr>
               <td colspan="2">
</c:verbatim>
                   <h:outputText value="#{wage_deptPrintBB.names}"></h:outputText>
<c:verbatim>
               </td>
           </tr>
       </table>
</c:verbatim>
   </h:form>

   <script language="javascript">
   <%
      String Mode=(String)request.getAttribute("Mode");
      if ("1".equals(Mode)){
         request.setAttribute("Mode","");
         //out.println("doPrint();");
         out.println("document.all('form1:print').style.display='block';");
      }
      else if ("2".equals(Mode)){
         request.setAttribute("Mode","");
         //out.println("doAllPrint();");
         out.println("document.all('form1:printPerson').style.display='block';");
      }
   %>
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
