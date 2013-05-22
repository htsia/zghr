<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    
    function forSelPerson() {
	    if (checkMutilSelect(document.forms(0).chk)) {
	        showx = event.screenX - event.offsetX - 150;
	        showy = event.screenY - event.offsetY + 18;
	        var obj = document.forms(0).chk ;
	        var ids = "";
            for (i = 0; i < obj.length; i++) {
                if (obj[i].checked) {
                    ids += obj[i].value.split("|")[0] + ",";
                }
            }
	        ids = ids.substr(0, ids.length - 1);
	        if(ids.indexOf(",")==-1){
	        	forModifyPersonDetail(ids);
	        }else{
		        windowOpen("","plist","","1000","600","no","10","0","yes");
		        document.forms(1).perids.value = ids;
		        document.forms(1).target = "plist";
		        document.forms(1).method = "post";
		        document.forms(1).action = "/employee/info/PersonManyEditInfo.jsf";
		        document.forms(1).submit();
		        document.forms(1).target = "_self";
	        }
	        return false;
	    } else {
	        alert("请选择人员");
	        return false;
	    }
	}
    function selectOrg(){
        PopUpOrgOnlyDlgTwoControl("form1:unitId","form1:unitId","1");
        document.all("form1:query").click();
        return true;
    }
</script>

<!--修改1开始-->
<script>
var op = location.search;
window.onload = function () {
	if(op == "?op=ry"){
		document.getElementById("form1:query").click();
	}
}
</script>
<!--修改1结束-->

  <x:saveState value="#{emp_PersonChangeBB}"/>
  <h:form id="form1">
  <h:inputHidden value="#{emp_PersonChangeBB.pageInit}"/>

  <f:verbatim>
  <table width="98%" height="98%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
        <td class="td_title" height=8>
   </f:verbatim>
            <h:graphicImage value="/images/tips.gif" />
<f:verbatim>
              <%=LanguageSupport.getResource("RYGL-0380","人员增减情况")%>
              &nbsp;&nbsp;
</f:verbatim>
            <h:inputHidden id="unitId" value="#{emp_PersonChangeBB.unitId}"></h:inputHidden>
            <h:outputText value="当前机构："></h:outputText>
            <h:outputText id="unitName" value="#{emp_PersonChangeBB.unitName}"/>
            <h:commandButton value="切换单位" type="button" styleClass="button01" rendered="#{emp_PersonChangeBB.showChangeUnit}" onclick="return selectOrg();"></h:commandButton>
<f:verbatim>    
        </td>
        <td class="td_title" height=8 align="right">
   </f:verbatim>
       <h:selectOneRadio value='#{emp_PersonChangeBB.mode}'>
           <c:selectItem itemValue="0" itemLabel="全部"></c:selectItem>
           <c:selectItem itemValue="1" itemLabel="增加"></c:selectItem>
           <c:selectItem itemValue="2" itemLabel="减少"></c:selectItem>
       </h:selectOneRadio>
   <f:verbatim>
        </td>
        <td class="td_title" align="right"  height=8>
</f:verbatim>
            <f:verbatim>
              <%=LanguageSupport.getResource("RYGL-2417","输入查询时间")%>
            </f:verbatim>
            <h:inputText id="inputDate" readonly="true" styleClass="input" value="#{emp_PersonChangeBB.inputDate}"/>
            <c:verbatim>
		    	<img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM',alwaysUseStartDate:true,el:'form1:inputDate'})" src="../../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
            </c:verbatim>
            <h:commandButton value="查询" id="query" styleClass="button01" onclick="return disPlayProcessBar();" action="#{emp_PersonChangeBB.query}"/>
            <h:commandButton value="查看人员信息" styleClass="button01" type="button" onclick="return forSelPerson();"/>
            <h:commandButton value="导出" styleClass="button01" type="button" onclick="doExport();"/>
<f:verbatim>
        </td>
    </tr>

     <tr><td colspan="3" height=8></td></tr>

     <tr><td colspan="3">
         <jsp:include page="/pages/common/activepage/ActiveList.jsp">
             <jsp:param name="hasOperSign" value="true"/>
             <jsp:param name="operSignType" value="checkbox"/>
             <jsp:param name="hasEdit" value="false"/>
             <jsp:param name="isEditList" value="false"/>
             <jsp:param name="isCheckRight" value="false"/>
         </jsp:include>
     </td>
     </tr>
  </table>
</f:verbatim>       
</h:form>
<form id="form2">
        <input type="hidden" name="perids"/>
    </form>
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
