<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
      function process(){
			x = document.body.clientWidth / 2 - 150;
			y = document.body.clientHeight / 2;
			document.all('processbar').style.top = y;
			document.all('processbar').style.left = x;
			document.all('processbar').style.display = "";
      }
</script>
<x:saveState value="#{attMachinePersonMgrBB}" />
<h:inputHidden value="#{attMachinePersonMgrBB.setPwdInit}"/>
<h:form id="form1">
	<h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="ÐÞ¸Ä¿¼ÇÚÃÜÂë" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="95%" align="center">
		<f:verbatim><br/><br/></f:verbatim>
		<h:panelGrid columns="2" align="center" columnClasses="td_form01,td_form02" styleClass="table03">
			<h:outputText value="ÐÂÃÜÂë"/>
			<h:inputText value="#{attMachinePersonMgrBB.pwd}" size="30" styleClass="input"/>
		</h:panelGrid>
		<h:panelGrid columns="1" align="right">
			<h:commandButton styleClass="button01" value="±£´æ" onclick="process();" action="#{attMachinePersonMgrBB.setPwd}"/>
		</h:panelGrid>
	</h:panelGrid>
</h:form>
<marquee id="processbar" style="position:absolute;display:none; border:1px solid #000000" direction="right" width="300"
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


