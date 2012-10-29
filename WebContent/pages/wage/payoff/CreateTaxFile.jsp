<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script language="javascript">
   function DoSelectAll(isSelect){
        var size = document.all('form1:inputField').length;
        for (var i = 0; i < size; i++) {
            document.all('form1:inputField')[i].checked=isSelect;
        }
    }
    function doCalc(){
        document.all('form1:showExcel').style.display='none';
        return disPlayProcessBar();
    }
    function refresh(){
        disPlayProcessBar();
        document.all('form1:queryDept').click();
    }
</script>
<x:saveState value="#{wage_taxReportBB}"/>
<h:form id="form1">
    <h:inputHidden id="unitId" value="#{wage_taxReportBB.initFile}"/>
    <h:inputHidden id="dateId" value="#{wage_taxReportBB.dateId}"/>
    <h:inputHidden id="setId" value="#{wage_taxReportBB.setId}"/>
    <c:verbatim>
    <br>
    <table width=98% align="center">
       <tr><td>
</c:verbatim>
           <h:selectOneMenu id="groupLevel" value="#{wage_taxReportBB.groupLevel}" onchange="refresh();" valueChangeListener="#{att_DataUploadBB.changeStatus}">
               <c:selectItem itemValue="DEPT_NAME" itemLabel="最细层次"></c:selectItem>
               <c:selectItem itemValue="HIGH_NAME" itemLabel="汇总1"></c:selectItem>
               <c:selectItem itemValue="HIGH_NAME2" itemLabel="汇总2"></c:selectItem>
               <c:selectItem itemValue="HIGH_NAME3" itemLabel="汇总3"></c:selectItem>
               <c:selectItem itemValue="HIGH_NAME4" itemLabel="汇总4"></c:selectItem>
           </h:selectOneMenu>
           <h:commandButton value="刷新" id="queryDept" style="display:none" styleClass="button01" action="#{wage_taxReportBB.queryDept}">

           </h:commandButton>
           <h:selectManyCheckbox  value="#{wage_taxReportBB.selectDepts}" layout="pageDirection" id="inputField">
               <c:selectItems value="#{wage_taxReportBB.deptList}"/>
           </h:selectManyCheckbox>
<c:verbatim>
       </td>

       <td align="right" valign="top">
</c:verbatim>
            <h:selectBooleanCheckbox value="#{wage_taxReportBB.splitDept}"></h:selectBooleanCheckbox>
            <h:outputText value="分部门出表"></h:outputText>
            <c:verbatim><br><br></c:verbatim>
            <h:commandButton  styleClass="button01" type="button" value="全部选择" onclick="DoSelectAll(true);" />
            <c:verbatim><br><br></c:verbatim>
            <h:commandButton  styleClass="button01" type="button" value="全部取消" onclick="DoSelectAll(false);" />
            <c:verbatim><br><br></c:verbatim>
            <h:commandButton value="生成" onclick="return doCalc();" styleClass="button01" action="#{wage_taxReportBB.genReport}"></h:commandButton>
            <c:verbatim><br><br></c:verbatim>
            <h:commandButton type='button' value="下载报表" id="showExcel" onclick="return showExcelFile();" style="display:none;" styleClass="button01" ></h:commandButton>
<c:verbatim>
       </td>
       </tr>
    </table>
    </c:verbatim>
</h:form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>
<script type="text/javascript">
<%
   if (session.getAttribute("e_path")!=null){
       out.println("document.all('form1:showExcel').style.display='block';");
   }
%>
</script>
