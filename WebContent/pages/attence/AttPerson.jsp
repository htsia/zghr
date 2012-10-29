<%@page import="com.hr319wg.org.pojo.bo.OrgBO"%>
<%@page import="java.util.List"%>
<%@page import="com.hr319wg.attence.util.DateUtil"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<script type="text/javascript">
	var selrale = document.all("form1:raletype").value;
	if(selrale==0){
		document.all("form1:qry").disabled=false;
		document.all("form1:setperson").disabled=true;			
	}else if(selrale==1){
		document.all("form1:qry").disabled=true;
		document.all("form1:setperson").disabled=false;			
	}
	function setperson(classID){
		window.showModalDialog(
						"/custom/attence/attClassUser.jsf?classID="+classID,
						null,
						"dialogWidth:1100px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
	}
</script>
<c:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td height=20 class="td_title"><img src="/images/tips.gif">人员设置 -> 
            </c:verbatim>
            <h:outputText value="#{att_class_set_childBB.attClassBO.className}"/>
            <c:verbatim>
            </td>
        </tr>
    </table>
</c:verbatim>
<x:saveState value="#{att_class_set_childBB}" />
<h:inputHidden value="#{att_class_set_childBB.initPerson}"/>
<h:form id="form1">
	<h:inputHidden id="raletype" value="#{att_class_set_childBB.attClassBO.raleType}"/>
	<h:panelGrid columns="1" width="100%" align="center">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="关联类别"/>
			<h:selectOneRadio value="#{att_class_set_childBB.attClassBO.raleType}" onclick="submit();" valueChangeListener="#{att_class_set_childBB.changeRaleType}">
				<c:selectItem itemValue="0" itemLabel="关联查询方案"/>
		        <c:selectItem itemValue="1" itemLabel="关联人员"/>
			</h:selectOneRadio>

			<h:outputText value="关联查询方案"/>
			<h:selectOneMenu id="qry" style="width:150px" value="#{att_class_set_childBB.qryID}">
                <c:selectItems value="#{att_class_set_childBB.qryList}"/>
            </h:selectOneMenu>
			<h:outputText value="关联人员"/>
			<h:commandButton id="setperson" value="设置人员" styleClass="button01" disabled="true" onclick="return setperson('#{att_class_set_childBB.classID}');"/>
		</h:panelGrid>
		<h:panelGrid align="right">
              <h:commandButton value="保存" styleClass="button01"  action="#{att_class_set_childBB.savePerson}"/>
           </h:panelGrid>
	</h:panelGrid>
</h:form>
