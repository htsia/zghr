<%@ page contentType="text/html;charset=gbk" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<f:verbatim>
    <script type="text/javascript">
    function beginInput() {
    	 var url="/eva/ShowLeadJobDetail.jsf?planID="+document.all('form1:planID').value+"&itemID="+document.all('form1:itemID').value;
	 	 if(document.all('form1:itemID').value!=""){
       	  document.all('main').src=url;
		 }
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.clientHeight - 70;
        $("iframe[name=main]").height(mainHeight);
    }
    function forAddPerson() {
        var reval = window.showModalDialog("/eva/personQuery2.jsf?planID="+document.all('form1:planID').value+"&orgId="+document.all('form1:orgId').value, null, "dialogWidth:1000px; dialogHeight:600px;center:center;resizable:yes;status:yes;scroll:yes;");
		if (reval != null && reval!="") {
        	var vars=reval.split("|");
        	document.all("form1:personStr").value = vars[1];
        	return true;
        } else {
            return false;
        }
   }
    </script>
</f:verbatim>
<x:saveState value="#{eva_leadJobEstimateBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_leadJobEstimateBB.pageInit}"/>
    <h:inputHidden id="personStr" value=""/>
    <h:inputHidden id="orgId" value="#{eva_leadJobEstimateBB.orgId}"/>
   	<h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="5">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 -> 考核下属岗位职责"/>
        </h:panelGroup>
   
    <h:panelGrid align="right">
    <h:panelGroup>
    	<h:selectOneMenu id="itemID" value="#{eva_leadJobEstimateBB.itemID}">
            <c:selectItems value="#{eva_leadJobEstimateBB.resultList}"></c:selectItems>
        </h:selectOneMenu>
        <h:outputText value="选择下属人员"></h:outputText>
		<h:selectOneMenu id="planID" value="#{eva_leadJobEstimateBB.planID}" onchange="submit();" valueChangeListener="#{eva_leadJobEstimateBB.changeStatus}">
            <c:selectItems value="#{eva_leadJobEstimateBB.queryList}"></c:selectItems>
        </h:selectOneMenu>
        <h:commandButton value="增加考核对象" styleClass="button01"  onclick="return forAddPerson();" action="#{eva_leadJobEstimateBB.addPerson}"></h:commandButton>
        <h:outputText value="  "></h:outputText>
        <h:commandButton value="开始考核" styleClass="button01" type="button" onclick="beginInput()"></h:commandButton>
    </h:panelGroup>
     </h:panelGrid>
    </h:panelGrid>

    <c:verbatim>
    	<table width="98%" align="center">
    	<tr>
    </c:verbatim>
    <c:verbatim>
    	<td align="right" height="8">
    	</td></tr>

          <tr>
                <td colspan="98%">
                <iframe id="main" width="100%"  frameborder="0" scrolling="auto"></iframe>
                </td>
        </tr>
		</table>
    </c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>