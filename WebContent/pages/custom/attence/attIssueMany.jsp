<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
      function process(){
			x = document.body.clientWidth / 2 - 150;
			y = document.body.clientHeight / 2;
			document.all('processbar').style.top = y;
			document.all('processbar').style.left = x;
			document.all('processbar').style.display = "";
      }

      function forsave(){
		var userIds = document.all("form1:userIds").value;
		if(userIds==null || userIds==""){
			alert("请选择人员");
			return false;
		}else{
			var selId=window.showModalDialog("/custom/attence/attMachineList.jsf?machineType=1", "", "dialogWidth:600px; dialogHeight:500px; status:0;resizable:yes");
	        if(selId==null || selId.length<=0){
	        	return false;
	        }else{
	        	document.all("form1:IPStr").value=selId;
	        }
	    	process();
	        return true;
		}
		return false;
	}
	function selperson(){
		var ids = window.showModalDialog(
						"/custom/selPerson.jsf?",
						null,
						"dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
		if(ids!=null && ids.length>0){
			document.all('form1:selectedUserIds').value=ids;
			return true;
		}else{
			return false;
		}
	}
</script>
<x:saveState value="#{attMachinePersonMgrBB}"/>
<h:inputHidden value="#{attMachinePersonMgrBB.pageManyInit}"/>
<h:form id="form1">
	<h:inputHidden id="IPStr" value="#{attMachinePersonMgrBB.IPStr}"/>
	<h:inputHidden id="selectedUserIds" value="#{attMachinePersonMgrBB.operUserID}"/>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理-> 多人分发" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="center">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="姓名"/>
			<h:panelGroup>
            	<h:inputTextarea id="userIds" value="#{attMachinePersonMgrBB.selectPersonNames}" cols="50" rows="6" readonly="true"/>
            	<h:commandButton onclick="return selperson();" value="" styleClass="button_select" action="#{attMachinePersonMgrBB.selPerson}"/>
            </h:panelGroup>
		</h:panelGrid>
		<f:verbatim><br/></f:verbatim>
		<h:panelGrid align="center">
			<h:commandButton value="  分  发  " onclick="return forsave();" action="#{attMachinePersonMgrBB.issue}" styleClass="button01"/>
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
